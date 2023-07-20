import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/presentation/controller/category_bloc/category_bloc.dart';
import 'package:labour/src/app/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.getUserStatus) {
          case RequestStatus.error:
          case RequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestStatus.success:
            return Column(
              children: [
                Container(
                  height: 120.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        state.user!.image!,
                      ),
                    ),
                    borderRadius: const BorderRadiusDirectional.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  state.user!.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onTap: () {
                    context.pushNamed(Routes.editScreen);
                  },
                  width: 80,
                  text: AppStrings.edit.tr(),
                ),
              ],
            );
        }
      },
    );
  }
}
