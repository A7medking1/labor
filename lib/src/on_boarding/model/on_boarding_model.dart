import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_strings.dart';

class OnBoardingModel extends Equatable {
  final String image;
  final String title;
  final String desc;

  const OnBoardingModel({
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  List<Object> get props => [image, title, desc];
}

List<OnBoardingModel> items =  [
  OnBoardingModel(
    image: AppAssets.onBoarding0,
    title: AppStrings.title1.tr(),
    desc: AppStrings.description1.tr(),
  ),
  OnBoardingModel(
    image: AppAssets.onBoarding1,
    title: AppStrings.title2.tr(),
    desc: AppStrings.description2.tr(),
  ),
  OnBoardingModel(
    image: AppAssets.onBoarding2,
    title: AppStrings.title3.tr(),
    desc: AppStrings.description3.tr(),
  ),
];
