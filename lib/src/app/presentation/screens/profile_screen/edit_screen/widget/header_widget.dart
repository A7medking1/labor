
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour/src/app/presentation/controller/profile_bloc/profile_bloc.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final bloc = context.read<ProfileBloc>();
        return InkWell(
          onTap: () {
            bloc.add(GetProfileImageFromGalleryEvent());
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 120.h,
                width: 120.w,
                decoration:  const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.all(
                    Radius.circular(15),
                  ),
                ),
                child: bloc.image == null ? Image.network(
                  state.user!.image!,
                  fit: BoxFit.cover,
                ) : Image.file(File(bloc.image!.path,),fit: BoxFit.cover,),
              ),
              Container(
                height: 120.h,
                width: 120.w,
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadiusDirectional.all(
                    Radius.circular(15),
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
