import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/cubit/step_cubit.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/first_step_content.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/second_step_content.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/third_step_content.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/widget/bottomNavBar.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/widget/stepper_widget.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:labour/src/core/string_language_helper.dart';

class CreateServiceScreen extends StatelessWidget {
  final String name;

  final String nameAr;

  final String image;

  const CreateServiceScreen({
    super.key,
    required this.name,
    required this.image,
    required this.nameAr,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StepCubit>(),
      child: BlocBuilder<StepCubit, BaseStepState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: BottomNavBar(
              serviceNameAr: nameAr,
              serviceName: name,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            stringLang(name, nameAr),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.green),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const StepperWidget(),
                        ],
                      ),
                      Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: 120,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ...[
                    if (StepCubit.get(context).currentStep == 1) ...{
                      const FirstStepContent(),
                    } else if (StepCubit.get(context).currentStep == 2) ...{
                      const SecondStepContent(),
                    } else ...{
                      const ThirdStepContent(),
                    }
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
