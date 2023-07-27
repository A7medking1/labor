import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/data/model/location_model.dart';
import 'package:labour/src/app/domain/entity/location.dart';
import 'package:labour/src/app/presentation/controller/locations_bloc/locations_bloc.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocationsBloc>().add(GetCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.select_address.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              IconButton(
                onPressed: () => context.pushNamed(Routes.addLocation),
                icon: const Icon(
                  Icons.add_circle_outline,
                ),
              ),
            ],
          ),
          body: const HandleBodyLocations(),
          bottomNavigationBar: state.locations.isNotEmpty
              ? Container(
                  padding: const EdgeInsetsDirectional.all(30),
                  child: CustomButton(
                    onTap: () {
                      final currentIndex =
                          context.read<LocationsBloc>().currentLocation;

                      LocationEntity current = state.locations.singleWhere(
                          (element) => element.city == currentIndex);

                      LocationsModel locationsModel = LocationsModel(
                        city: current.city,
                        region: current.region,
                        street: current.street,
                        building: current.building,
                      );
                      sl<AppPreferences>().setLocation(locationsModel);
                      context
                          .read<LocationsBloc>()
                          .add(const GetLocationFromPrefsEvent());
                      context.pop();
                    },
                    text: AppStrings.select.tr(),
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}

class HandleBodyLocations extends StatefulWidget {
  const HandleBodyLocations({
    super.key,
  });

  @override
  State<HandleBodyLocations> createState() => _HandleBodyLocationsState();
}

class _HandleBodyLocationsState extends State<HandleBodyLocations> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
      builder: (context, state) {
        switch (state.requestState) {
          case RequestState.empty:
            return const EmptyLocations();
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.error:
            return Text(state.errorMessage);
          case RequestState.loaded:
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          context.read<LocationsBloc>().currentLocation =
                              state.locations[index].city;
                          setState(() {});
                        },
                        child: BuildLocationCard(
                          location: state.locations[index],
                          onTapDelButton: () {
                            print(state.locations[index].city);
                            String city = state.locations[index].city;
                            context
                                .read<LocationsBloc>()
                                .add(DeleteLocationEvent(city));
                          },
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => const SizedBox(
                      width: 10,
                    ),
                    itemCount: state.locations.length,
                  ),
                )
              ],
            );
        }
      },
    );
  }
}

class EmptyLocations extends StatelessWidget {
  const EmptyLocations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_off,
            size: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppStrings.you_did_not_add_location.tr(),
          )
        ],
      ),
    );
  }
}

class BuildLocationCard extends StatelessWidget {
  final LocationEntity location;
  final void Function()? onTapDelButton;

  const BuildLocationCard({
    super.key,
    required this.location,
    required this.onTapDelButton,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocationsBloc>();
    return Padding(
      padding: const EdgeInsetsDirectional.all(10),
      child: InkWell(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(15),
          ),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
                color: bloc.currentLocation == location.city
                    ? AppColors.green
                    : AppColors.white,
                borderRadius: BorderRadiusDirectional.circular(15)),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 8, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: bloc.currentLocation == location.city
                              ? AppColors.white
                              : AppColors.green,
                          child: SvgPicture.asset(
                            AppAssets.locatio,
                            color: bloc.currentLocation == location.city
                                ? AppColors.yellowDark
                                : Colors.black,
                            height: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildTileAndBody(
                                title: 'city',
                                body: location.city,
                                currentCityName: location.city,
                              ),
                              BuildTileAndBody(
                                title: 'region',
                                body: location.region,
                                currentCityName: location.city,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildTileAndBody(
                                title: 'street',
                                body: location.street,
                                currentCityName: location.city,
                              ),
                              BuildTileAndBody(
                                title: 'building',
                                body: location.building,
                                currentCityName: location.city,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onTapDelButton,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 5123456789012346

class BuildTileAndBody extends StatelessWidget {
  final String title;
  final String body;
  final String currentCityName;

  const BuildTileAndBody({
    super.key,
    required this.body,
    required this.title,
    required this.currentCityName,
  });

/*

  final LocationEntity location;
  final LocationsBloc bloc;
*/

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            body,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 10,
                  color: context.read<LocationsBloc>().currentLocation ==
                          currentCityName
                      ? Colors.white
                      : Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}
