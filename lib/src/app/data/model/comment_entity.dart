import 'package:labour/src/app/domain/entity/comment.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.userPic,
    required super.userName,
    required super.dateTime,
    required super.commentDisc,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'user_pic': userPic,
      'date_time': dateTime,
      'comment_desc': commentDisc,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userPic: json['user_pic'],
      userName: json['user_name'],
      dateTime: json['date_time'],
      commentDisc: json['comment_desc'],
    );
  }
}
