import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/domain/entity/service_entity.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:labour/src/app/presentation/controller/payment_bloc/payment_cubit.dart';
import 'package:labour/src/app/presentation/screens/order_screen/order_screen.dart';
import 'package:labour/src/core/format_date.dart';
import 'package:labour/src/core/presentation/widget/cached_image_network.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/string_language_helper.dart';

class OnGoingTap extends StatefulWidget {
  const OnGoingTap({Key? key}) : super(key: key);

  @override
  State<OnGoingTap> createState() => _OnGoingTapState();
}

class _OnGoingTapState extends State<OnGoingTap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final inReview = state.services
            .where((element) =>
                (element.serviceStatus == 'in_review') ||
                element.serviceStatus == 'accept')
            .toList();

        if (inReview.isEmpty) {
          return const EmptyServices();
        }

        switch (state.servicesReqState) {
          case RequestStatus.empty:
            return const EmptyServices();
          case RequestStatus.loading:
          case RequestStatus.error:
            return const Center(child: CircularProgressIndicator());
          case RequestStatus.success:
            return ListView.builder(
              itemBuilder: (_, index) {
                return OnGoingBuildCard(
                  service: inReview[index],
                );
              },
              itemCount: inReview.length,
            );
        }
      },
    );
  }
}

class OnGoingBuildCard extends StatelessWidget {
  final ServiceEntity service;

  const OnGoingBuildCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20, start: 10, end: 10),
      child: Column(
        children: [
          SizedBox(
            height: !service.paymentStatus ? 340.h : 250,
            width: double.infinity,
            //  color: Colors.red,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.contract_cleaning.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 20,
                                  ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '25ds458126fs',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: serviceStatusColor(service.serviceStatus),
                            borderRadius: BorderRadiusDirectional.circular(20),
                          ),
                          child: Text(
                            service.serviceStatus.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        )
                      ],
                    ),
                    const CustomDivider(),
                    Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => context.pushNamed(Routes.company,
                                  extra: service.company),
                              child: CachedImages(
                                height: 50,
                                width: 50,
                                imageUrl: service.company.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stringLang(service.company.name,
                                      service.company.nameAr),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  formatDateTime(service.dateTime),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1 Filipino worker under contract',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                        Column(
                          children: [
                            Text(
                              AppStrings.price.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                            Text(
                              service.company.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontSize: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                    if (!service.paymentStatus) ...[
                      const CustomDivider(),
                      BlocConsumer<PaymentCubit, PaymentState>(

                        listener: (context, state) {
                          print(state);
                          if (state is GetAuthTokenLoadingState) {
                            OverlayLoadingProgress.start(context);
                          }
                          if (state is GetAuthTokenSuccessState) {

                            OverlayLoadingProgress.stop();
                          }

                          if (state is GetAuthTokenErrorState) {
                            OverlayLoadingProgress.stop();
                          }
                        },
                        builder: (context, state) {
                          return ListTile(
                            dense: true,
                            onTap: () {
                              PaymentCubit.get(context).getAuthToken().then((value) {
                                context.pushNamed(Routes.completeOrder,
                                    extra: service);
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Text(
                              AppStrings.complete_payment_methods.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: AppColors.green,
                                  ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          );
                        },
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyServices extends StatelessWidget {
  const EmptyServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.s_empty,
            height: 150,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppStrings.no_history.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

Color serviceStatusColor(String status) {
  switch (status) {
    case 'in_review':
      return AppColors.grey;
    case 'accepted':
    case 'done':
      return AppColors.green;
    case 'canceled':
      return AppColors.errorRed;
  }
  return Colors.black;
}
