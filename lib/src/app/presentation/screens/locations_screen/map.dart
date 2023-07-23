import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labour/src/app/presentation/controller/locations_bloc/locations_bloc.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/resources/app_strings.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
/*
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
*/

  LatLng? pickLatLong;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LocationsBloc, LocationsState>(
        listener: (context, state) {
          if (state.updateState == RequestState.loading) {
            OverlayLoadingProgress.start(context);
          }

          if (state.updateState == RequestState.loaded) {
            OverlayLoadingProgress.stop();
            //  context.pop();
          }
        },
        builder: (context, state) {
          final bloc = context.read<LocationsBloc>();
          return GoogleMap(
            mapType: MapType.normal,
            markers: {bloc.placeMarker},
            initialCameraPosition: bloc.cameraPosition,
            onTap: (latLang) {
              print(latLang);
              pickLatLong = latLang;
              bloc.getAddressFromLatLang(latLang);
              bloc.placeMarker = Marker(
                markerId: const MarkerId('id'),
                position: latLang,
              );
              setState(() {});
            },
            onMapCreated: (GoogleMapController controller) {
              //   _controller.complete(controller);
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsetsDirectional.only(bottom: 30.0, end: 30, start: 30),
        child: CustomButton(
          onTap: () {
            context.read<LocationsBloc>().googleMapController!.moveCamera(
              CameraUpdate.newCameraPosition(
                  CameraPosition(target: pickLatLong!)),
            );
            // bloc.add(UpdateMapLocationEvent(pickLabgLat!));
            context.pop();
          },
          text: AppStrings.saveChanges.tr(),
        ),
      ),
    );
  }
}
