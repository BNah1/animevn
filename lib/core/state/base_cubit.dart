import 'package:bloc/bloc.dart';

import 'base_state.dart';

abstract class BaseCubit<S extends BaseState> extends Cubit<S> {
  BaseCubit(super.initialState);
  void setLoading() {
    final newState = state.copyWith(
      status: BaseStatus.loading,
      errorMessage: null,
    ) as S;
    emit(newState);
  }

  void setLoaded(BaseState newState) {
    final result = newState.copyWith(
      status: BaseStatus.loaded,
      errorMessage: null,
    ) as S;
    emit(result);
  }

  void setError(String message) {
    final newState = state.copyWith(
      status: BaseStatus.error,
      errorMessage: message,
    ) as S;
    emit(newState);
  }
}