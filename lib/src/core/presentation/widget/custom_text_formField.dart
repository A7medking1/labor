import 'package:flutter/material.dart';
import 'package:labour/src/core/resources/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;

  final bool obscureText;
  final Widget? prefixIcon;

  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    required this.title,
    this.suffixIcon,
    this.textInputType,
    this.prefixIcon,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          style: Theme.of(context).textTheme.titleSmall,
          readOnly: readOnly,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            errorStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.red, fontSize: 14),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
              borderSide: const BorderSide(
                color: Colors.green,
              ),
            ),
            filled: true,
            fillColor: Colors.green.shade50,
            prefixIcon:  prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
              borderSide: const BorderSide(
                color: AppColors.green,
              ),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
