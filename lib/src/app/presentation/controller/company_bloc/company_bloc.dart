import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/app/domain/entity/comment.dart';
import 'package:labour/src/app/domain/use_cases/get_comments_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_rating_useCase.dart';
import 'package:labour/src/app/domain/use_cases/set_comment_to_company_useCase.dart';
import 'package:labour/src/app/domain/use_cases/set_rating_to_company_useCase.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc(this.setCommentToCompanyUseCase, this.getCommentsUseCase,
      this.setRatingToCompanyUseCase, this.getRatingUseCase)
      : super(const CompanyState()) {
    on<SetCommentEvent>(_setComments);
    on<GetCommentEvent>(_getComments);
    on<SetRatingToCompanyEvent>(_setRating);
    on<GetRatingEvent>(_getRating);
  }

  final SetCommentToCompanyUseCase setCommentToCompanyUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final SetRatingToCompanyUseCase setRatingToCompanyUseCase;
  final GetRatingUseCase getRatingUseCase;

  FutureOr<void> _setComments(
      SetCommentEvent event, Emitter<CompanyState> emit) async {
    emit(state.copyWith(setCommentStatus: RequestStatus.loading));

    final result = await setCommentToCompanyUseCase(event.parameters);

    result.fold(
      (l) => emit(
        state.copyWith(
          setCommentStatus: RequestStatus.error,
        ),
      ),
      (r) {
        print('successs');
        emit(
          state.copyWith(
            setCommentStatus: RequestStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getComments(
      GetCommentEvent event, Emitter<CompanyState> emit) async {
    emit(state.copyWith(getCommentStatus: RequestStatus.loading));

    final result = await getCommentsUseCase(event.companyUid);

    result.fold(
      (l) => emit(
        state.copyWith(
          getCommentStatus: RequestStatus.error,
        ),
      ),
      (r) {
        print('success getComments');
        if (r.isEmpty) {
          emit(state.copyWith(getCommentStatus: RequestStatus.empty));
        } else {
          emit(
            state.copyWith(
              getCommentStatus: RequestStatus.success,
              comments: r,
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _setRating(
      SetRatingToCompanyEvent event, Emitter<CompanyState> emit) async {
    emit(state.copyWith(setRatingStatus: RequestStatus.loading));

    final result = await setRatingToCompanyUseCase(event.parameters);

    result.fold(
      (l) => emit(
        state.copyWith(
          setRatingStatus: RequestStatus.error,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            setRatingStatus: RequestStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getRating(
      GetRatingEvent event, Emitter<CompanyState> emit) async {
    emit(state.copyWith(getRatingStatus: RequestStatus.loading));

    final result = await getRatingUseCase(event.companyUid);

    result.fold(
      (l) => emit(
        state.copyWith(
          getRatingStatus: RequestStatus.error,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            getRatingStatus: RequestStatus.success,
            rating: r,
          ),
        );
      },
    );
  }
}
