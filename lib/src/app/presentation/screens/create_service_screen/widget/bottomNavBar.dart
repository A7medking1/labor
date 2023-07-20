import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/data/data/model/service_model.dart';
import 'package:labour/src/app/domain/entity/location.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/cubit/step_cubit.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = StepCubit.get(context);

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        print(state.addServicesReqStatus);

        if (state.addServicesReqStatus == RequestStatus.loading) {
          OverlayLoadingProgress.start(context);
        }

        if (state.addServicesReqStatus == RequestStatus.success) {
          OverlayLoadingProgress.stop();

          AwesomeDialog(
            context: context,
            animType: AnimType.RIGHSLIDE,
            dialogType: DialogType.SUCCES,
            dismissOnTouchOutside: false,
            body: Center(
              child: Text(
                AppStrings.request_desc.tr(),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            title: AppStrings.your_request_is_under_review.tr(),
            desc: 'This is also Ignored',
            btnOkText: 'Home',
            btnOkOnPress: () {
              context.goNamed(Routes.homeScreen);
            },
          ).show();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
              bottom: 30.0, end: 30, start: 30),
          child: CustomButton(
            onTap: () {
              Location location = sl<AppPreferences>().getLocation();
              ServiceModel serviceModel = ServiceModel(
                period: periodItems[cubit.periodIndex - 1].title,
                numberOfMonths: cubit.monthCount,
                nationality: cubit.nationality,
                city: location.city,
                company: state.company[cubit.company - 1],
                numberOfVisit: cubit.numberOfVisit,
                dateTime: cubit.dateTime.toString(),
                location: location,
                serviceStatus: 'in_review',
                paymentStatus: false,
              );

              if (StepCubit.get(context).currentStep == 3) {
                context.read<HomeBloc>().add(AddServicesEvent(serviceModel));
              }
              StepCubit.get(context).updateStep();
            },
            text: AppStrings.btnNext.tr(),
          ),
        );
      },
    );
  }
}


