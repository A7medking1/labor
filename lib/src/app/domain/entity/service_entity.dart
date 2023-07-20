import 'package:equatable/equatable.dart';
import 'package:labour/src/app/domain/entity/company.dart';
import 'package:labour/src/app/domain/entity/location.dart';

class ServiceEntity extends Equatable {
  final String period;
  final String numberOfMonths;
  final String nationality;
  final String city;
  final Company company;
  final String numberOfVisit;
  final String dateTime;
  final String serviceStatus;
  final bool paymentStatus;
  final Location location;

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
        serviceStatus,
        paymentStatus,
      ];
}
