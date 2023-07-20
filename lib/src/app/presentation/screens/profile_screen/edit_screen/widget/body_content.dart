import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour/src/app/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:labour/src/core/presentation/widget/custom_text_formField.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';

class BodyWidgetContent extends StatelessWidget {
  const BodyWidgetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {

        final bloc = context.read<ProfileBloc>();

        bloc.email.text = state.user!.email;
        bloc.userName.text = state.user!.name;
        bloc.phone.text = state.user!.phone!;
        return Column(
          children: [
            CustomTextFormField(
              controller: bloc.userName,
              title: AppStrings.fullName.tr(),
              suffixIcon: const Icon(Icons.person),
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextFormField(
              readOnly: true,
              controller: bloc.phone,
              title: AppStrings.phone.tr(),
              suffixIcon: const Icon(Icons.call),
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextFormField(
              controller: bloc.email,
              title: AppStrings.email.tr(),
              suffixIcon: const Icon(Icons.key),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        );
      },
    );
  }
}
