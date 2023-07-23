import 'package:csc_picker/csc_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/cubit/step_cubit.dart';
import 'package:labour/src/core/presentation/widget/custom_drop_menu.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/style.dart';

class FirstStepContent extends StatelessWidget {
  const FirstStepContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PeriodContent(),
        const SizedBox(
          height: 20,
        ),
        const NumberOfMonthContent(),
        const SizedBox(
          height: 20,
        ),

        CSCPicker(
          defaultCountry: CscCountry.Egypt,
          layout: Layout.vertical,
          dropdownHeadingStyle: getBoldStyle(),
          showStates: false,
          dropdownItemStyle: getBoldStyle(),
          selectedItemStyle: getBoldStyle(),
          dropdownDecoration: const BoxDecoration(

          ),

          onCountryChanged: (value) {
            print(value);
           /* setState(() {
              countryValue = value;
            });*/
          },
          onStateChanged:(value) {
            print(value);

           /* setState(() {
              stateValue = value;
            });*/
          },
          onCityChanged:(value) {
            print(value);

          /*  setState(() {
              cityValue = value;
            });*/
          },
        ),


        /*ChooseNationality(),
        SizedBox(
          height: 20,
        ),
        ChooseCity(),*/
      ],
    );
  }
}

class ChooseCity extends StatelessWidget {
  const ChooseCity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCubit, BaseStepState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.city.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropMenuDownWidget(
              value: StepCubit.get(context).city,
              onChanged: (value) => StepCubit.get(context).changeCity(value!),
              items: city
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class ChooseNationality extends StatelessWidget {
  const ChooseNationality({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCubit, BaseStepState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.nationality.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropMenuDownWidget(
              value: StepCubit.get(context).nationality,
              onChanged: (value) =>
                  StepCubit.get(context).changeNationality(value!),
              items: nationality
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class NumberOfMonthContent extends StatelessWidget {
  const NumberOfMonthContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCubit, BaseStepState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.number_of_hours.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropMenuDownWidget(
              value: StepCubit.get(context).monthCount,
              onChanged: (value) =>
                  StepCubit.get(context).changeNumberOfMonth(value!),
              items: months
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class PeriodContent extends StatelessWidget {
  const PeriodContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.period.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: periodItems
              .map(
                (e) => BuildPeriodWidget(
              periodModel: e,
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}

class BuildPeriodWidget extends StatelessWidget {
  final PeriodModel periodModel;

  final void Function()? onTap;

  const BuildPeriodWidget({
    super.key,
    required this.periodModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCubit, BaseStepState>(
      builder: (context, state) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: periodModel.id == StepCubit.get(context).periodIndex
                    ? AppColors.yellowDark
                    : Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: InkWell(
                onTap: () {
                  StepCubit.get(context).changePeriodIndex(periodModel.id);
                },
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        periodModel.icon,
                      ),
                      Text(periodModel.title.tr()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
