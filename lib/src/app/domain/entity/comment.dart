import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String userPic;

  final String userName;

  final String dateTime;

  final String commentDisc;

  const CommentEntity({
    required this.userPic,
    required this.userName,
    required this.dateTime,
    required this.commentDisc,
  });

  @override
  List<Object> get props => [userPic, userName, dateTime, commentDisc];
}
