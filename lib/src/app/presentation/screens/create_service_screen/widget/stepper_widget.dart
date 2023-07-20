import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/cubit/step_cubit.dart';
import 'package:labour/src/core/resources/app_strings.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCubit, BaseStepState>(
      builder: (context, state) {
        return Row(
          children: steps
              .map((e) => InkWell(
                    onTap: () {
                      StepCubit.get(context).onTapStep(e.index);
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 0),
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  StepCubit.get(context).currentStep == e.index
                                      ? Colors.green
                                      : Colors.grey,
                              child: Text(
                                e.circleTitle,
                                style: Theme.of(context).textTheme.titleSmall,
                              )),
                          SizedBox(width: 5,),
                          Text(AppStrings.step.tr(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900),) ,
                          SizedBox(width: 8,),

                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
