/// Android `UiState.kt`에 대응하는 범용 UI 상태 래퍼.
sealed class UiState<T> {
  const UiState();
}

class UiStateIdle<T> extends UiState<T> {
  const UiStateIdle();
}

class UiStateLoading<T> extends UiState<T> {
  const UiStateLoading();
}

class UiStateSuccess<T> extends UiState<T> {
  const UiStateSuccess(this.data);

  final T data;
}

class UiStateFailure<T> extends UiState<T> {
  const UiStateFailure(this.message);

  final String message;
}
