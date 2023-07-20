part of 'company_bloc.dart';

class CompanyState extends Equatable {
  final RequestStatus setCommentStatus;
  final RequestStatus getCommentStatus;
  final RequestStatus setRatingStatus;
  final RequestStatus getRatingStatus;
  final List<CommentEntity> comments;
  final double rating;

  const CompanyState({
    this.setCommentStatus = RequestStatus.empty,
    this.setRatingStatus = RequestStatus.empty,
    this.comments = const [],
    this.getCommentStatus = RequestStatus.loading,
    this.rating = 0.0,
    this.getRatingStatus = RequestStatus.loading,
  });

  CompanyState copyWith({
    RequestStatus? setCommentStatus,
    RequestStatus? setRatingStatus,
    RequestStatus? getRatingStatus,
    RequestStatus? getCommentStatus,
    double? rating,
    List<CommentEntity>? comments,
  }) {
    return CompanyState(
      setCommentStatus: setCommentStatus ?? this.setCommentStatus,
      comments: comments ?? this.comments,
      rating: rating ?? this.rating,
      getCommentStatus: getCommentStatus ?? this.getCommentStatus,
      setRatingStatus: setRatingStatus ?? this.setRatingStatus,
    );
  }

  @override
  List<Object> get props =>
      [setCommentStatus, getCommentStatus, comments, setRatingStatus, rating];
}
