part of 'category_bloc.dart';

enum RequestStatus { error, success, loading }

class CategoryState extends Equatable {
  final RequestStatus requestStatus;

  final List<Category> category;
  final String errorMessage;

  const CategoryState({
    this.requestStatus = RequestStatus.loading,
    this.category = const [],
    this.errorMessage = '',
  });

  CategoryState copyWith({
    RequestStatus? requestStatus,
    List<Category>? category,
    String? errorMessage,
  }) {
    return CategoryState(
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      category: category ?? this.category,
    );
  }

  @override
  List<Object> get props => [requestStatus, category, errorMessage];
}
