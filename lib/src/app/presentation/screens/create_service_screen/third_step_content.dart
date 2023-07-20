import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/cubit/step_cubit.dart';
import 'package:labour/src/app/presentation/screens/home_screen/home_screen.dart';
import 'package:labour/src/core/presentation/widget/custom_drop_menu.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';

class ThirdStepContent extends StatelessWidget {
  const ThirdStepContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LocationWidget(),
        const SizedBox(
          height: 10,
        ),
        const NumberOfVisit(),
        SizedBox(
          height: 20.h,
        ),
        Text(
          AppStrings.choose_date.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 20.h,
        ),
        const DateTimeLine(),
      ],
    );
  }
}

class DateTimeLine extends StatelessWidget {
  const DateTimeLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCubit, BaseStepState>(
      builder: (context, state) {
        return DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColors.green,
          height: 100.h,
          selectedTextColor: Colors.white,
          daysCount: 20,
          locale: context.locale.languageCode,
          onDateChange: (date) {
            context.read<StepCubit>().updateDateTime(date);
            // New date selected
            /*   setState(() {
          _selectedValue = date;
        });*/
          },
        );
      },
    );
  }
}

class NumberOfVisit extends StatelessWidget {
  const NumberOfVisit({
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
              AppStrings.number_of_visits.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropMenuDownWidget(
              value: StepCubit.get(context).numberOfVisit,
              items: numberOfVisit
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                  .toList(),
              onChanged: (value) =>
                  StepCubit.get(context).changeNumberOfVisit(value!),
            ),
          ],
        );
      },
    );
  }
}
