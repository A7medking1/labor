import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_strings.dart';

part 'step_state.dart';

class StepCubit extends Cubit<BaseStepState> {
  StepCubit() : super(StepInitial());

  static StepCubit get(context) => BlocProvider.of(context);

  int currentStep = 1;

  int periodIndex = 1;

  String monthCount = '1';

  String city = 'Abha';

  int company = 1;

  String nationality = 'egypt';

  String numberOfVisit = '1';

  DateTime dateTime = DateTime.now();

  void updateDateTime(DateTime date) {
    dateTime = date;
    emit(UpdateTimeState());
  }

  void updateStep() {
    if (currentStep < 3) {
      currentStep++;
    }
    emit(UpdateStepState());
  }

  void onTapStep(int value) {
    currentStep = value;
    emit(OnTappedStepState());
  }

  void changePeriodIndex(int value) {
    periodIndex = value;
    emit(UpdatePeriodState());
  }

  void changeNumberOfMonth(String value) {
    monthCount = value;
    emit(UpdateMonthState());
  }

  void changeCity(String value) {
    city = value;
    emit(UpdateCityState());
  }

  void changeCompany(int value) {
    company = value;
    emit(UpdateChooseCompanyState());
  }

  void changeNationality(String value) {
    nationality = value;
    emit(UpdateChooseCompanyState());
  }

  void changeNumberOfVisit(String value) {
    numberOfVisit = value;
    emit(UpdateNumberOfVisitState());
  }
}

class StepModel {
  final int index;

  final String circleTitle;

  const StepModel({
    required this.index,
    required this.circleTitle,
  });
}

List<StepModel> steps = [
  const StepModel(
    index: 1,
    circleTitle: '1',
  ),
  const StepModel(
    index: 2,
    circleTitle: '2',
  ),
  const StepModel(
    index: 3,
    circleTitle: '3',
  ),
];

class PeriodModel {
  final String title;

  final String icon;

  final int id;

  PeriodModel({
    required this.title,
    required this.icon,
    required this.id,
  });
}

List<PeriodModel> periodItems = [
  PeriodModel(title: AppStrings.morning, icon: AppAssets.sun, id: 1),
  PeriodModel(title: AppStrings.night, icon: AppAssets.night, id: 2),
];

List<String> months = ['1', '2', '3', '4', '5'];
List<String> numberOfVisit = ['1', '2', '3', '4', '5'];
List<String> city = ['Abha', 'Ad-Dilam', 'Buraydah', 'Jizan', 'Jeddah'];
List<String> price = ['high', 'low', 'all'];
List<String> nationality = ['egypt', 'china', 'all', 'Philippines'];
