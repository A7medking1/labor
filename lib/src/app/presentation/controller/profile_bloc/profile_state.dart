part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final RequestStatus getUserStatus;
  final RequestStatus? getImageFromGalleryStatus;
  final RequestStatus? updateUserStatus;
  final User? user;

   const ProfileState({
    this.getUserStatus = RequestStatus.loading,
    this.user,
    this.getImageFromGalleryStatus,
     this.updateUserStatus
  });

  ProfileState copyWith({
    RequestStatus? getUserStatus,
    User? user,
    File? image,
    RequestStatus? getImageFromGalleryStatus,
    RequestStatus? updateUserStatus
  }) {
    return ProfileState(
      user: user ?? this.user,
      getUserStatus: getUserStatus ?? this.getUserStatus,
      getImageFromGalleryStatus:
          getImageFromGalleryStatus ?? this.getImageFromGalleryStatus,
      updateUserStatus: updateUserStatus ?? this.updateUserStatus,
    );
  }

  @override
  List<Object?> get props => [
        getUserStatus,
        getImageFromGalleryStatus,
        user,
    updateUserStatus,
      ];
}
