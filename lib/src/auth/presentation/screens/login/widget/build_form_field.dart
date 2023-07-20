import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labour/src/auth/presentation/controller/auth_bloc.dart';
import 'package:labour/src/core/presentation/widget/custom_text_formField.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/validator_form.dart';

class InputFieldBuild extends StatefulWidget {
  const InputFieldBuild({
    super.key,
  });

  @override
  State<InputFieldBuild> createState() => _InputFieldBuildState();
}

class _InputFieldBuildState extends State<InputFieldBuild> with Validator {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: context.read<AuthBloc>().phone,
         hintText: '+20',
         //validator: (value) => validateEmail(value),
          textInputType: TextInputType.emailAddress,
          suffixIcon: const Icon(Icons.phone),
          title: AppStrings.phone.tr(),
        ),
      ],
    );
  }
}
