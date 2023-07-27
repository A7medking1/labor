import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/style.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.my_wallet.tr()),
      ),
      body: const MyWalletBody(),
    );
  }
}

class MyWalletBody extends StatelessWidget {
  const MyWalletBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(30.0),
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadiusDirectional.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  height: 50 ,
                  padding: EdgeInsetsDirectional.only(start: 20),
                  width: 50,
                  child: SvgPicture.asset(
                    AppAssets.wallet,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.my_balance.tr(),),
                      Text('0.00 EG',style: getBoldStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
