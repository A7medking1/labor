part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

class SetCommentEvent extends CompanyEvent {
  final SetCommentToCompanyParameters parameters;

  const SetCommentEvent(this.parameters);
}

class GetCommentEvent extends CompanyEvent {
  final String companyUid;

  const GetCommentEvent(this.companyUid);
}

class GetRatingEvent extends CompanyEvent {
  final String companyUid;

  const GetRatingEvent(this.companyUid);
}

class SetRatingToCompanyEvent extends CompanyEvent {
  final SetRatingToCompanyParameters parameters;

  const SetRatingToCompanyEvent(this.parameters);
}
