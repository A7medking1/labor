import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

class OnBoardingLangScreen extends StatelessWidget {
  const OnBoardingLangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.laborLogo,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppStrings.onBoardingLang.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              AppStrings.selectLanguage.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 19),
            ),
            SizedBox(
              height: 30.h,
            ),
            const ChooseLanguage(),
          ],
        ),
      ),
    );
  }
}

enum ChooseLang { arabic, english }

ChooseLang _character = ChooseLang.english;

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          title: Text(AppStrings.english.tr()),
          value: ChooseLang.english,
          groupValue: _character,
          onChanged: (newValue) {
            setState(() {
              _character = newValue!;
              sl<AppPreferences>().changeAppLang();
              Phoenix.rebirth(context);
              //context.setLocale(englishLocal);
            });
          },
        ),
        RadioListTile(
          title: Text(AppStrings.arabic.tr()),
          value: ChooseLang.arabic,
          groupValue: _character,
          onChanged: (newValue) {
            setState(() {
              _character = newValue!;
              sl<AppPreferences>().changeAppLang();
              Phoenix.rebirth(context);
            });
          },
        ),
        const Divider(),
        SizedBox(
          height: 30.h,
        ),
        CustomButton(
          onTap: () {
            context.goNamed(Routes.onBoarding);
            sl<AppPreferences>().setOnBoardingLang();
          },
          text: AppStrings.btnNext.tr(),
        ),
      ],
    );
  }
}
