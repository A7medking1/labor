part of 'step_cubit.dart';

abstract class BaseStepState {}

class StepInitial extends BaseStepState {}

class UpdateStepState extends BaseStepState {}
class UpdatePeriodState extends BaseStepState {}
class UpdateMonthState extends BaseStepState {}
class UpdateCityState extends BaseStepState {}
class UpdateChooseCompanyState extends BaseStepState {}
class UpdateNationalityState extends BaseStepState {}
class UpdateNumberOfVisitState extends BaseStepState {}
class UpdateTimeState extends BaseStepState {}


class SelectMonthState extends BaseStepState {}
class SelectDayState extends BaseStepState {}


class OnTappedStepState extends BaseStepState {}
