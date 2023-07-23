import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/domain/entity/service_entity.dart';
import 'package:labour/src/app/presentation/controller/payment_bloc/payment_cubit.dart';
import 'package:labour/src/app/presentation/screens/home_screen/home_screen.dart';
import 'package:labour/src/app/presentation/screens/order_screen/on_going_tap.dart';
import 'package:labour/src/core/format_date.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/presentation/widget/custom_text_formField.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/resources/style.dart';
import 'package:labour/src/core/string_language_helper.dart';

class CompleteOrderScreen extends StatefulWidget {
  final ServiceEntity serviceEntity;

  const CompleteOrderScreen({Key? key, required this.serviceEntity})
      : super(key: key);

  @override
  State<CompleteOrderScreen> createState() => _CompleteOrderScreenState();
}

class _CompleteOrderScreenState extends State<CompleteOrderScreen> {
  @override
  void initState() {
    super.initState();
    //context.read<PaymentCubit>().getAuthToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.complete_order.tr()),
      ),
      body: CompleteOrderBody(
        serviceEntity: widget.serviceEntity,
      ),
    );
  }
}

class CompleteOrderBody extends StatelessWidget {
  final ServiceEntity serviceEntity;

  const CompleteOrderBody({Key? key, required this.serviceEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is GetOrderIdLoadingState) {
          OverlayLoadingProgress.start(
            context,
          );
        }
        if (state is GetPaymentRequestSuccessState) {
          context.pushNamed(Routes.toggleScreen,extra: serviceEntity);
          OverlayLoadingProgress.stop();
        }
      },
      builder: (context, state) {
        print(totalPrice(serviceEntity.company.price));
        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 10.0, end: 10, top: 10, bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.my_order_details.tr(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OrderDetails(serviceEntity: serviceEntity),
                  PriceCouponsNotesOrder(
                    service: serviceEntity,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onTap: () {
                      PaymentCubit.get(context).getOrderId(price: (totalPrice(serviceEntity.company.price) * 100).toString() );
                    },
                    text: AppStrings.pay.tr(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
double calculateTax(int price) {
  return (price * 0.05);
}

double totalPrice(int price) {
  return calculateTax(price) + price;
}
class PriceCouponsNotesOrder extends StatelessWidget {
  final ServiceEntity service;

  const PriceCouponsNotesOrder({
    super.key,
    required this.service,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.leave_notes.tr(),
          style: getBoldStyle(),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          maxLines: 5,
          style: getBoldStyle(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.green.shade50,
            hintStyle: getMediumStyle(),
            hintText: AppStrings.your_notes.tr(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        /*   Text(
          AppStrings.add_coupon.tr(),
          style: getBoldStyle(),
        ),
        const SizedBox(
          height: 20,
        ),*/
        CustomTextFormField(
          title: AppStrings.add_coupon.tr(),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          AppStrings.price.tr(),
          style: getBoldStyle(),
        ),
        const SizedBox(
          height: 20,
        ),
        PriceInfoRow(
          title: AppStrings.price_order.tr(),
          body: service.company.price.toString(),
        ),
        PriceInfoRow(
          title: AppStrings.tax.tr(),
          body: calculateTax(service.company.price).toString(),
        ),
        PriceInfoRow(
          title: AppStrings.discount.tr(),
          body: '0',
        ),
        PriceInfoRow(
          title: AppStrings.total_price.tr(),
          body: totalPrice(service.company.price)
              .toString(),
        ),
      ],
    );
  }
}

class PriceInfoRow extends StatelessWidget {
  final String title;
  final String body;

  const PriceInfoRow({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15, end: 30, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getBoldStyle(),
          ),
          Text(
            body,
            style: getBoldStyle(),
          ),
        ],
      ),
    );
  }
}

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.serviceEntity,
  });

  final ServiceEntity serviceEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            RowInfoOrderWidget(
              title: AppStrings.name_of_order.tr(),
              body: stringLang(serviceEntity.serviceName,serviceEntity.serviceNameAr),
            ),
            RowInfoOrderWidget(
              title: AppStrings.date_of_order.tr(),
              body: formatDateTime(serviceEntity.dateTime),
            ),
          ],
        ),
        Row(
          children: [
            RowInfoOrderWidget(
              title: AppStrings.code_of_order.tr(),
              body: '25ds458126fs5dha',
            ),
            RowInfoOrderWidget(
              title: AppStrings.company.tr(),
              body: stringLang(serviceEntity.company.name, serviceEntity.company.nameAr),
            ),
          ],
        ),
        Row(
          children: [
            RowInfoOrderWidget(
              title: AppStrings.details_order.tr(),
              body: '1 Filipino worker under contract',
            ),
            RowInfoOrderWidget(
              title: AppStrings.company.tr(),
              widget: Container(
                alignment: AlignmentDirectional.center,
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: serviceStatusColor(serviceEntity.serviceStatus),
                  borderRadius: BorderRadiusDirectional.circular(20),
                ),
                child: Text(
                  serviceEntity.serviceStatus.tr(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const LocationWidget(),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class RowInfoOrderWidget extends StatelessWidget {
  final String title;
  final String? body;
  final Widget? widget;

  const RowInfoOrderWidget(
      {super.key, this.widget, required this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 80.h,
        //    width: MediaQuery.sizeOf(context).width * 0.5 ,
        // color: Colors.red.shade50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getLightStyle(),
            ),
            const SizedBox(
              height: 10,
            ),
            widget ??
                Text(
                  body!,
                  style: getBoldStyle(fontSize: 14),
                ),
          ],
        ),
      ),
    );
  }
}
