part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}


class GetCurrentUserEvent extends ProfileEvent {}


class GetProfileImageFromGalleryEvent extends ProfileEvent {}



class UpdateUserDataEvent extends ProfileEvent {}
