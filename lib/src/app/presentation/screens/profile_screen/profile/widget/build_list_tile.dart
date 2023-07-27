import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/presentation/widget/list_tile_widget.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

class BuildListTilesScreen extends StatefulWidget {
  const BuildListTilesScreen({
    super.key,
  });

  @override
  State<BuildListTilesScreen> createState() => _BuildListTilesScreenState();
}

String currentLang = sl<AppPreferences>().getAppLang();

class _BuildListTilesScreenState extends State<BuildListTilesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomListTileWidget(
                title: AppStrings.paymentMethods.tr(),
                body: AppStrings.addYourCredit.tr(),
                leadingIcon: AppAssets.card,
                onTap: () async {}),
            SizedBox(
              height: 20.h,
            ),
            CustomListTileWidget(
              title: AppStrings.pushNotification.tr(),
              body: AppStrings.forDailyUpdateAndOthers.tr(),
              leadingIcon: AppAssets.notify,
              trailingWidget: Switch.adaptive(
                value: true,
                onChanged: (value) {},
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomListTileWidget(
              title: AppStrings.selectLanguage.tr(),
              body: AppStrings.selectLanguage.tr(),
              leadingIcon: AppAssets.lang,
              trailingWidget: DropdownButton(
                onChanged: (v) => setState(() {
                  sl<AppPreferences>().changeAppLang();
                  Phoenix.rebirth(context);
                  currentLang = sl<AppPreferences>().getAppLang();
                }),
                value: currentLang,
                items: const [
                  DropdownMenuItem(
                      value: 'en',
                      child: Text(
                        'English',
                        style: TextStyle(fontSize: 13),
                      )),
                  DropdownMenuItem(
                      value: 'ar',
                      child: Text(
                        'العربية',
                        style: TextStyle(fontSize: 13),
                      )),
                ],
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomListTileWidget(
              title: AppStrings.my_wallet.tr(),
              body: AppStrings.my_wallet.tr(),
              leadingIcon: AppAssets.wallet,
              onTap: () => context.pushNamed(Routes.myWallet),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomListTileWidget(
              title: AppStrings.contactUs.tr(),
              body: AppStrings.forMoreInformation.tr(),
              leadingIcon: AppAssets.calling,
              onTap: () => context.pushNamed(Routes.contactUs),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomListTileWidget(
              title: AppStrings.logout.tr(),
              body: AppStrings.logOut.tr(),
              leadingIcon: AppAssets.logout,
              onTap: () async {
                sl<AppPreferences>().removeUserToken();
                sl<AppPreferences>().removeLocation();
                sl<AppPreferences>().removeOnBoarding();
                sl<AppPreferences>().removeOnBoardingLang();
                await FirebaseAuth.instance.signOut().then(
                  (value) {
                    context.goNamed(Routes.login);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
