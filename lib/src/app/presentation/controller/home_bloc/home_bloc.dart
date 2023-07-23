import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/app/data/model/service_model.dart';
import 'package:labour/src/app/domain/entity/category.dart';
import 'package:labour/src/app/domain/entity/company.dart';
import 'package:labour/src/app/domain/entity/service_entity.dart';
import 'package:labour/src/app/domain/use_cases/add_services_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_category_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_company_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_services_useCase.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this.getCategoryUseCase,
    this.getCompanyUseCase,
    this.addServicesUseCase,
    this.getServicesUseCase,
  ) : super(const HomeState()) {
    on<GetHomeDataEvent>(_getHome);
    on<GetCompanyDataEvent>(_getCompany);
    on<AddServicesEvent>(_addService);
    on<GetServicesEvent>(_getServices);
  }

  final GetCategoryUseCase getCategoryUseCase;
  final GetCompanyUseCase getCompanyUseCase;
  final AddServicesUseCase addServicesUseCase;
  final GetServicesUseCase getServicesUseCase;

  FutureOr<void> _getHome(HomeEvent event, Emitter<HomeState> emit) async {
    final result = await getCategoryUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          homeRequestStatus: RequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          homeRequestStatus: RequestStatus.success,
          category: r,
        ),
      ),
    );
  }

  FutureOr<void> _getCompany(
      GetCompanyDataEvent event, Emitter<HomeState> emit) async {
    final result = await getCompanyUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          companyRequestStatus: RequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          companyRequestStatus: RequestStatus.success,
          company: r,
        ),
      ),
    );
  }

  FutureOr<void> _addService(
      AddServicesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(addServicesReqStatus: RequestStatus.loading));

    final result = await addServicesUseCase(event.serviceModel);

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          addServicesReqStatus: RequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          addServicesReqStatus: RequestStatus.success,
        ),
      ),
    );
  }

  FutureOr<void> _getServices(
      GetServicesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(servicesReqState: RequestStatus.loading));

    final result = await getServicesUseCase(const NoParameters());

    result.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                servicesReqState: RequestStatus.error,
              ),
            ), (r) {
      if (r.isEmpty) {
        emit(state.copyWith(servicesReqState: RequestStatus.empty));
      } else {
        emit(state.copyWith(
          servicesReqState: RequestStatus.success,
          services: r,
        ));
      }
    });
  }
}
