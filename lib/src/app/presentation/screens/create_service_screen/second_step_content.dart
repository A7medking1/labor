import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/domain/entity/company.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/cubit/step_cubit.dart';
import 'package:labour/src/core/presentation/widget/cached_image_network.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/string_language_helper.dart';

class SecondStepContent extends StatelessWidget {
  const SecondStepContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => BuildCompanyWidget(
                    company: state.company[index],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: state.company.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BuildCompanyWidget extends StatelessWidget {
  final Company company;

  const BuildCompanyWidget({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCubit, BaseStepState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => StepCubit.get(context).changeCompany(company.id),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15),
              color: StepCubit.get(context).company == company.id
                  ? AppColors.green
                  : Colors.white,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // color: Colors.red,
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              print('click');
                              context.pushNamed(Routes.company,extra: company);
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              child: CachedImages(
                                height: 80,
                                imageUrl: company.image,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.only(top: 10),
                                  child: Text(
                                    stringLang(company.name, company.nameAr),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ...List.generate(
                                        5,
                                        (index) => Icon(
                                              Icons.star,
                                              color: AppColors.yellowDark,
                                            ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  stringLang(company.desc, company.descAr),
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                top: 10.0, end: 20),
                            child: Column(
                              children: [
                                Text(
                                  AppStrings.price.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  company.price.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
