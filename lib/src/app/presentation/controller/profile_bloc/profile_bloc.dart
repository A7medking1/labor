import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labour/src/app/domain/use_cases/get_current_user_useCase.dart';
import 'package:labour/src/app/presentation/controller/category_bloc/category_bloc.dart';
import 'package:labour/src/auth/data/model/user_model.dart';
import 'package:labour/src/auth/domain/entity/user.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.getCurrentUserUseCase) : super(const ProfileState()) {
    on<GetCurrentUserEvent>(_getCurrentUser);
    on<GetProfileImageFromGalleryEvent>(_getImageFromGallery);
    on<UpdateUserDataEvent>(_updateUserData);
  }

  final GetCurrentUserUseCase getCurrentUserUseCase;

  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController phone = TextEditingController();

  XFile? image;

  FutureOr<void> _getCurrentUser(
      GetCurrentUserEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(getUserStatus: RequestStatus.loading));

    final result = await getCurrentUserUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          getUserStatus: RequestStatus.error,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            user: r,
            getUserStatus: RequestStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getImageFromGallery(
      GetProfileImageFromGalleryEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      getImageFromGalleryStatus: RequestStatus.loading,
    ));
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      image = XFile(pickedFile.path);
      print(pickedFile.path);
      emit(state.copyWith(
        getImageFromGalleryStatus: RequestStatus.success,
      ));
    } else {
      print('No image selected.');
    }
  }

  FutureOr<void> _updateUserData(
      UpdateUserDataEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(updateUserStatus: RequestStatus.loading));

    if (image != null) {
      await uploadImageToFireBase(image!).then((value) {
        updateUser(
          UserModel(
            uid: state.user!.uid,
            name: userName.text,
            email: email.text,
            image: value,
            phone: state.user!.phone,
          ),
        );
        emit(state.copyWith(updateUserStatus: RequestStatus.success));
        add(GetCurrentUserEvent());
      });
    } else {
      await updateUser(
        UserModel(
            uid: state.user!.uid,
            name: userName.text,
            email: email.text,
            image: state.user!.image,
            phone: state.user!.phone),
      ).then((value) {
        emit(state.copyWith(updateUserStatus: RequestStatus.success));
        add(GetCurrentUserEvent());
      });
    }
  }
}

Future<void> updateUser(UserModel user) async {
  final token = sl<AppPreferences>().getUserToken();

  await FirebaseFirestore.instance
      .collection('user')
      .doc(token)
      .update(user.toJson());
}

Future<String> uploadImageToFireBase(XFile image) async {
  final imagePath = image.path;
  final path = 'users/${Uri.file(imagePath).pathSegments.last}';
  final ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child(path)
      .putFile(File(imagePath));
  final TaskSnapshot downloadUrl = (await ref);
  final imageUrl = await downloadUrl.ref.getDownloadURL();
  print(imageUrl);

  return imageUrl;
}
