import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/app/domain/entity/category.dart';
import 'package:labour/src/app/domain/use_cases/get_category_useCase.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this.getCategoryUseCase) : super(const CategoryState()) {
    on<GetCategoriesEvent>(_getCategory);
  }

  final GetCategoryUseCase getCategoryUseCase;

  FutureOr<void> _getCategory(
      GetCategoriesEvent event, Emitter<CategoryState> emit) async {
    final result = await getCategoryUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          requestStatus: RequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          requestStatus: RequestStatus.success,
          category: r,
        ),
      ),
    );
  }
}
