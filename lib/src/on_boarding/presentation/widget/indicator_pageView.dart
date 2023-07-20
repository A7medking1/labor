import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndicatorPageView extends StatelessWidget {
  final int currentIndex;

  const IndicatorPageView({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: Opacity(
            opacity: currentIndex == index ? 1 : 0.4,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: index == currentIndex
                  ? Colors.amberAccent
                  : Colors.black.withOpacity(0.2),
              child:  CircleAvatar(
                radius: 8.r,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }
}
