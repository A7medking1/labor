import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:labour/src/on_boarding/model/on_boarding_model.dart';
import 'package:labour/src/on_boarding/presentation/widget/indicator_pageView.dart';

class PageViewBuilder extends StatefulWidget {
  const PageViewBuilder({
    super.key,
  });

  @override
  State<PageViewBuilder> createState() => _PageViewBuilderState();
}

class _PageViewBuilderState extends State<PageViewBuilder> {
  final pageController = PageController(initialPage: 0);

  int currentPage = 0;

  bool isLastPage = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.45,
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              onPageChanged: (int index) {
                if (index == items.length - 1) {
                  isLastPage = true;
                } else {
                  isLastPage = false;
                }
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return PageViewWidget(
                  model: items[index],
                );
              },
            ),
          ),
          IndicatorPageView(currentIndex: currentPage),
          const SizedBox(
            height: 50,
          ),
          CustomButton(
            onTap: () {
              if (isLastPage) {
                sl<AppPreferences>().setOnBoarding();
                //   Navigator.push(context, MaterialPageRoute(builder: (_)=> const Test()));
                context.goNamed(Routes.login);
              } else {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.fastLinearToSlowEaseIn,
                );
              }
            },
            text: !isLastPage
                ? AppStrings.btnNext.tr()
                : AppStrings.btnGetStarted.tr(),
          ),
        ],
      ),
    );
  }
}

class PageViewWidget extends StatelessWidget {
  final OnBoardingModel model;

  const PageViewWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            model.image,
            height: 150,
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            model.title.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Text(
              model.desc.tr(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
