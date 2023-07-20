import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color? color;
  final double? width;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color =  Colors.green,
    this.width ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 50,
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10) ,
        ),
        color: color,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color:Colors.white),
        ),
      ),
    );
  }
}
