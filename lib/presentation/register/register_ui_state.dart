/// Android `RegisterContract.RegisterUiState`에 대응.
sealed class RegisterUiState {
  const RegisterUiState();
}

class RegisterUiStateIdle extends RegisterUiState {
  const RegisterUiStateIdle();
}

class RegisterUiStateLoading extends RegisterUiState {
  const RegisterUiStateLoading();
}

class RegisterUiStateEmpty extends RegisterUiState {
  const RegisterUiStateEmpty();
}

class RegisterUiStateSuccess extends RegisterUiState {
  const RegisterUiStateSuccess();
}

class RegisterUiStateFailure extends RegisterUiState {
  const RegisterUiStateFailure(this.msg);

  final String msg;
}
