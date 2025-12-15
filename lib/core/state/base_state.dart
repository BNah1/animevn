abstract class BaseState {
  final BaseStatus status;
  final String errorMessage;

  const BaseState({this.status = BaseStatus.initial, this.errorMessage = ''});

  BaseState copyWith({
    BaseStatus? status,
    String? errorMessage,
  });
}

enum BaseStatus {
  initial,
  loading,
  loaded,
  error,
  empty,
  resetInputs
}