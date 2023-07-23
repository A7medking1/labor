import 'package:equatable/equatable.dart';
import 'package:labour/src/app/data/model/company_model.dart';
import 'package:labour/src/app/data/model/location_model.dart';

class ServiceEntity extends Equatable {
  final String period;
  final String numberOfMonths;
  final String nationality;
  final String city;
  final CompanyModel company;
  final String numberOfVisit;
  final String dateTime;
  final String serviceStatus;
  final bool paymentStatus;
  final LocationsModel location;
  final String serviceUid;
  final String serviceNameAr;
  final String serviceName;

  const ServiceEntity({
    required this.period,
    required this.numberOfMonths,
    required this.nationality,
    required this.city,
    required this.company,
    required this.numberOfVisit,
    required this.location,
    required this.dateTime,
    required this.serviceStatus,
    required this.paymentStatus,
    required this.serviceUid,
    required this.serviceNameAr,
    required this.serviceName,
  });

  @override
  List<Object> get props => [
        period,
        numberOfMonths,
        nationality,
        location,
        city,
        company,
        numberOfVisit,
        dateTime,
        serviceNameAr,
        serviceName,
        serviceStatus,
        paymentStatus,
        serviceUid,
      ];
}
