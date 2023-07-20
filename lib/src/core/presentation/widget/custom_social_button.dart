import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labour/src/core/resources/app_colors.dart';

class CustomSocialMediaButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color? color;
  final double? width;
  final String? icon;

  const CustomSocialMediaButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color =  const Color(0xFFDFDFDF),
    this.width ,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsetsDirectional.only(bottom: 15),
      child: SizedBox(
        width: width ?? double.infinity,
        height: 55,
        child: MaterialButton(
          onPressed: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20) ,
          ),
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon!,height: 30,),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
