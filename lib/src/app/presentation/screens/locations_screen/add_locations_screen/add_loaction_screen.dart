import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour/src/app/data/data/model/location_model.dart';
import 'package:labour/src/app/presentation/controller/locations_bloc/locations_bloc.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/presentation/widget/custom_text_formField.dart';
import 'package:labour/src/core/resources/app_strings.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({Key? key}) : super(key: key);

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final TextEditingController cityController = TextEditingController();

  final TextEditingController regionController = TextEditingController();

  final TextEditingController streetController = TextEditingController();

  final TextEditingController buildingController = TextEditingController();

  @override
  void dispose() {
    cityController.dispose();
    regionController.dispose();
    buildingController.dispose();
    streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsBloc, LocationsState>(
      listener: (context, state) {
        if (state.addLocReqState == RequestState.loading) {
          OverlayLoadingProgress.start(context);
        }

        if (state.addLocReqState == RequestState.loaded) {
          OverlayLoadingProgress.stop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.address.tr()),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(20.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: cityController,
                    title: AppStrings.city.tr(),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    controller: regionController,
                    title: AppStrings.region.tr(),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    controller: streetController,
                    title: AppStrings.street.tr(),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    controller: buildingController,
                    title: AppStrings.building.tr(),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsetsDirectional.all(30),
            child: CustomButton(
              onTap: () {
                LocationsModel location = LocationsModel(
                  city: cityController.text,
                  region: regionController.text,
                  street: streetController.text,
                  building: buildingController.text,
                );
                context.read<LocationsBloc>().add(AddLocationEvent(location));
                //context.pop();
                context.read<LocationsBloc>().add(GetLocationsEvent());
                // context.pop();
              },
              text: AppStrings.add.tr(),
            ),
          ),
        );
      },
    );
  }
}
