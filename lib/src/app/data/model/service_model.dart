import 'package:labour/src/app/data/model/company_model.dart';
import 'package:labour/src/app/data/model/location_model.dart';
import 'package:labour/src/app/domain/entity/company.dart';
import 'package:labour/src/app/domain/entity/service_entity.dart';

class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required super.period,
    required super.numberOfMonths,
    required super.nationality,
    required super.city,
    required super.company,
    required super.numberOfVisit,
    required super.dateTime,
    required super.location,
    required super.serviceStatus,
    required super.paymentStatus,
    required super.serviceUid,
    required super.serviceNameAr,
    required super.serviceName,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      period: json['period'],
      serviceNameAr: json['service_name_ar'],
      serviceName: json['service_name'],
      numberOfMonths: json['number_of_month'],
      nationality: json['nationality'],
      city: json['city'],
      serviceUid: json['serviceUid'],
      company: CompanyModel.fromJson(json['company']),
      numberOfVisit: json['number_of_visit'],
      dateTime: json['dateTime'],
      location: LocationsModel.fromJson(json['location']),
      serviceStatus: json['service_status'],
      paymentStatus: json['payment_status'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'period': period,
      'serviceUid': serviceUid,
      'service_name_ar': serviceNameAr,
      'service_name': serviceName,
      'number_of_month': numberOfMonths,
      'nationality': nationality,
      'city': city,
      'number_of_visit': numberOfVisit,
      'company': company.toJson(),
      'location':  location.toJson(),
      'dateTime': dateTime,
      'service_status': serviceStatus,
      'payment_status': paymentStatus,
    };
  }
}

/*
{
'id': company.id,
'name': company.name,
'image': company.image,
'price': company.price,
'desc_ar': company.descAr,
'name_ar': company.nameAr,
'desc': company.desc,
'hour': company.hour,
'uid':company.uid,
},*/
/*
{
'city': location.city,
'region': location.region,
'street': location.street,
'building': location.building,
},*/
