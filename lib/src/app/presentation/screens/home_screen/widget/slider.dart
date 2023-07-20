import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_colors.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  CarouselController controller = CarouselController();

  int currPos = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: controller,
          items: banners
              .map((e) => Image.asset(
                    e.image,
                    fit: BoxFit.cover,
                  ))
              .toList(),
          options: CarouselOptions(
            height: 150,
            aspectRatio: 16 / 9,
            onPageChanged: (index, _) {
              setState(() {
                currPos = index;
              });
            },
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            //autoPlay: true,
            // autoPlayInterval: const Duration(seconds: 4),
            //autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Align(
          alignment: AlignmentDirectional.center,
          child: DotsIndicator(
            dotsCount: banners.length,
            position: currPos,
            decorator: DotsDecorator(
              color: Colors.grey[300]!,
              activeColor: AppColors.green,
            ),
          ),
        ),
      ],
    );
  }
}

class BannerModel extends Equatable {
  final int id;

  final String image;

  const BannerModel({
    required this.image,
    required this.id,
  });

  @override
  List<Object> get props => [image, id];
}

List<BannerModel> banners = [
  const BannerModel(
    image: AppAssets.pic,
    id: 1,
  ),
  const BannerModel(
    image: AppAssets.pic,
    id: 2,
  ),
  const BannerModel(
    image: AppAssets.pic,
    id: 2,
  ),
];
