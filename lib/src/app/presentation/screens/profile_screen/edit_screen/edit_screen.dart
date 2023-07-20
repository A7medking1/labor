
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour/src/app/presentation/controller/category_bloc/category_bloc.dart';
import 'package:labour/src/app/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:labour/src/app/presentation/screens/profile_screen/edit_screen/widget/body_content.dart';
import 'package:labour/src/app/presentation/screens/profile_screen/edit_screen/widget/header_widget.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.updateUserStatus == RequestStatus.loading) {
          OverlayLoadingProgress.start(context);
        }
        if (state.updateUserStatus == RequestStatus.success) {
          OverlayLoadingProgress.stop();
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      sl<AppPreferences>().changeAppLang();
                      Phoenix.rebirth(context);
                    },
                    icon: const Icon(Icons.language))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.center,
                        child: HeaderWidget(),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const BodyWidgetContent(),
                      CustomButton(
                        onTap: () async {
                          context.read<ProfileBloc>().add(UpdateUserDataEvent());
                          //context.read<ProfileBloc>().add(GetCurrentUserEvent());
                        },
                        text: AppStrings.saveChanges.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
