import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labour/src/app/presentation/controller/locations_bloc/locations_bloc.dart';
import 'package:labour/src/app/presentation/screens/locations_screen/place_item.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> mapController = Completer();

  LatLng? pickLatLong;
  bool isSearch = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocationsBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: {bloc.placeMarker},
            myLocationButtonEnabled: false,
            onMapCreated: (controller) {
              mapController.complete(controller);
            },
            onCameraMove: (position) {
              bloc.cameraPosition = position;
            },
            initialCameraPosition: bloc.cameraPosition,
            onTap: (latLang) {
              pickLatLong = latLang;
              bloc.add(GetAddressFromLatLangEvent(pickLatLong!));
              bloc.placeMarker = Marker(
                markerId: const MarkerId('id'),
                position: latLang,
              );
              setState(() {});
            },
          ),
          if (isSearch) buildFloatingSearchBar(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsetsDirectional.only(
            bottom: 30.0, end: 30, start: 30, top: 20),
        child: CustomButton(
          onTap: () {
            context.pop();
          },
          text: AppStrings.saveChanges.tr(),
        ),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      controller: context.read<LocationsBloc>().controller,
      scrollPadding: const EdgeInsets.only(top: 0, bottom: 0),
      transitionDuration: const Duration(milliseconds: 800),
      automaticallyImplyBackButton: false,
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      height: 70,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        getPlacesSuggestions(query);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                placeListView(),
              ],
            ),
          ),
        );
      },
    );
  }

  void getPlacesSuggestions(String query) {
    context.read<LocationsBloc>().add(GetPlaceIdEvent(query));
  }

  Widget placeListView() => BlocConsumer<LocationsBloc, LocationsState>(
        listener: (context, state) {
          if (state.placeDetailsReqState == RequestState.loading) {
            OverlayLoadingProgress.start(context);
          }
          if (state.placeDetailsReqState == RequestState.loaded) {
            OverlayLoadingProgress.stop();
            goToMySearchedForLocation(
                context,
                LatLng(
                  state.placeDetails!.lat,
                  state.placeDetails!.lng,
                ));
          }
        },
        builder: (context, state) {
          final bloc = context.read<LocationsBloc>();
          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, index) => const SizedBox(
              height: 20,
            ),
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  bloc.controller!.close();
                  bloc.placeSuggestion = state.places[index];
                  bloc.add(GetPlaceDetailsEvent(state.places[index].placeId));
                },
                child: PlaceItem(
                  place: state.places[index],
                ),
              );
            },
            itemCount: state.places.length,
          );
        },
      );

  Future<void> goToMySearchedForLocation(
      BuildContext context, LatLng latLng) async {
    final bloc = context.read<LocationsBloc>();

    bloc.buildCameraNewPosition(latLng);

    final GoogleMapController controller = await mapController.future;

    await controller.animateCamera(
        CameraUpdate.newCameraPosition(bloc.goToSearchCameraPosition!));

    buildSearchPaceMarker();
  }

  Future<void> buildSearchPaceMarker() async {
    final bloc = context.read<LocationsBloc>();
    bloc.placeMarker = Marker(
      markerId: const MarkerId('1'),
      position: bloc.goToSearchCameraPosition!.target,
      onTap: () {
        // TODO show current location
      },
      infoWindow: InfoWindow(
        title: bloc.placeSuggestion!.description,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    pickLatLong = bloc.goToSearchCameraPosition!.target;
    bloc.add(GetAddressFromLatLangEvent(pickLatLong!));
    setState(() {});

  }
}
