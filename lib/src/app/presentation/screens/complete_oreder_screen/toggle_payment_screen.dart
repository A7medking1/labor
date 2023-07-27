import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/domain/entity/service_entity.dart';
import 'package:labour/src/app/presentation/controller/payment_bloc/payment_cubit.dart';
import 'package:labour/src/core/presentation/widget/cached_image_network.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/resources/routes_manager.dart';


class ToggleScreen extends StatelessWidget {
  final ServiceEntity serviceEntity ;

  const ToggleScreen({Key? key,required this.serviceEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is GetPaymentMobileWalletLoadingState) {
          OverlayLoadingProgress.start(context);
        }



        if(state is GetPaymentMobileWalletLoadingState){
          OverlayLoadingProgress.start(context);
        }

        if(state is GetPaymentMobileWalletSuccessState){
          context.pushNamed(Routes.MobileWalletScreen,extra: serviceEntity);
          OverlayLoadingProgress.stop();
        }





      },
      builder: (context, state) {
        PaymentCubit cubit = PaymentCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChoosePayment(
                    text: 'payment with visa',
                    onTap: () {
                      context.pushNamed(Routes.visaScreen,extra: serviceEntity);
                    },
                    image: visaImage,
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: 20.0),
                  ChoosePayment(
                    text: 'payment with mobile wallet',
                    onTap: () {
                      cubit.mobileWalletPayment();
                    },
                    image: wallet,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChoosePayment extends StatelessWidget {
  final void Function()? onTap;
  final String? image;
  final String? text;

  const ChoosePayment({super.key, this.onTap, this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black, width: 2.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedImages(
                imageUrl: image!,
                height: 120,
              ),
              Text(
                text!,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 const String refCodeImage =
    "https://cdn-icons-png.flaticon.com/128/4090/4090458.png";

 const String visaImage =
    "https://cdn-icons-png.flaticon.com/128/349/349221.png";


 const String wallet =
    "https://th.bing.com/th/id/R.4a264daff2b601793535bd845574e8e8?rik=Rd%2bH8mBLY6G35g&pid=ImgRaw&r=0";