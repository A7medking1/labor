part of 'home_bloc.dart';

enum RequestStatus { error, success, loading ,empty}

class HomeState extends Equatable {
  final RequestStatus homeRequestStatus;
  final RequestStatus companyRequestStatus;
  final RequestStatus servicesReqState;
  final RequestStatus? addServicesReqStatus;

  final List<Category> category;
  final List<Company> company;
  final List<ServiceEntity> services;
  final String errorMessage;

  const HomeState({
    this.homeRequestStatus = RequestStatus.loading,
    this.category = const [],
    this.errorMessage = '',
    this.company = const [],
    this.addServicesReqStatus,
    this.services = const [],
    this.servicesReqState = RequestStatus.loading,
    this.companyRequestStatus = RequestStatus.loading,
  });

  HomeState copyWith({
    RequestStatus? homeRequestStatus,
    List<Category>? category,
    String? errorMessage,
    List<Company>? company,
    List<ServiceEntity>? services,
    RequestStatus? companyRequestStatus,
    RequestStatus? addServicesReqStatus,
    RequestStatus? servicesReqState,
  }) {
    return HomeState(
      homeRequestStatus: homeRequestStatus ?? this.homeRequestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      category: category ?? this.category,
      company: company ?? this.company,
      addServicesReqStatus: addServicesReqStatus ?? this.addServicesReqStatus,
      companyRequestStatus: companyRequestStatus ?? this.companyRequestStatus,
      services: services ?? this.services,
      servicesReqState: servicesReqState ?? this.servicesReqState,
    );
  }

  @override
  List<Object?> get props =>
      [
        homeRequestStatus,
        companyRequestStatus,
        addServicesReqStatus,
        servicesReqState,
        category,
        company,
        services,
        services,
        errorMessage,
      ];
}
