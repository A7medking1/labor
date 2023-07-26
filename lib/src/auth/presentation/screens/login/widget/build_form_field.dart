import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labour/src/auth/presentation/controller/auth_bloc.dart';
import 'package:labour/src/core/presentation/widget/custom_text_formField.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/style.dart';
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
    final bloc = context.read<AuthBloc>();
    return Column(
      children: [
        CustomTextFormField(
          controller: bloc.phone,
          prefixIcon: TextButton(
            onPressed: () {
              showCountryPicker(
                context: context,
                countryListTheme: CountryListThemeData(
                  borderRadius: BorderRadius.zero,
                  bottomSheetHeight: MediaQuery.sizeOf(context).height * 0.5,
                ),
                onSelect: (value) {
                  setState(() {
                    bloc.country = value;
                  });
                },
              );
            },
            child: Text(
              '${bloc.country.flagEmoji} +${bloc.country.phoneCode}',
              style: getBoldStyle(),
            ),
          ),
          //validator: (value) => validateEmail(value),
          textInputType: TextInputType.number,
          suffixIcon: const Icon(Icons.phone),
          title: AppStrings.phone.tr(),
        ),
      ],
    );
  }
}
