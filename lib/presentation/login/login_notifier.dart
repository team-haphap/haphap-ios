import 'dart:async' show TimeoutException;
import 'dart:io' show SocketException;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../core/util/result.dart';
import 'login_riverpod.dart';

/// Android `LoginContract.kt`에 대응.
sealed class LoginUiState {
  const LoginUiState();
}

class LoginUiStateIdle extends LoginUiState {
  const LoginUiStateIdle();
}

class LoginUiStateLoading extends LoginUiState {
  const LoginUiStateLoading();
}

class LoginUiStateSuccess extends LoginUiState {
  const LoginUiStateSuccess();
}

class LoginUiStateFailure extends LoginUiState {
  const LoginUiStateFailure();
}

/// Android `LoginContract.State`에 대응.
///
/// `SideEffect.NavigateToSignUpComplete`는 별도 채널 대신 [userName]
/// 필드로 state에 실어 보낸다 — `loginUiState`가 [LoginUiStateSuccess]로
/// 바뀔 때 `ref.listen`에서 이 값을 읽어 한 번만 내비게이션하면 된다.
class LoginState {
  const LoginState({
    this.loginUiState = const LoginUiStateIdle(),
    this.userName,
  });

  final LoginUiState loginUiState;
  final String? userName;

  LoginState copyWith({LoginUiState? loginUiState, String? userName}) {
    return LoginState(
      loginUiState: loginUiState ?? this.loginUiState,
      userName: userName ?? this.userName,
    );
  }
}

/// 안드로이드 앱(`KakaoLoginManager`)과 동일한 정책으로 카카오 SDK
/// 로그인을 처리한다:
/// - 카카오톡 앱전환 로그인은 "취소"/"네트워크 오류"가 아닌 다른 에러일
///   때만 브라우저 계정 로그인으로 폴백한다.
/// - 취소/네트워크 오류/기타 실패 모두 사용자에게 별도 에러 메시지를
///   보여주지 않는다(안드로이드 LoginScreen도 Idle과 Failure를 똑같이
///   렌더링하고, 취소/네트워크 오류는 그냥 무시함) — 실패 내역은
///   `debugPrint`로만 남긴다.
class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState();

  Future<void> loginWithKakao() async {
    if (state.loginUiState is LoginUiStateLoading) return;
    state = state.copyWith(loginUiState: const LoginUiStateLoading());

    try {
      final kakaoToken = await _issueKakaoAccessToken();
      final result = await ref
          .read(authRepositoryProvider)
          .postKakaoLogin(kakaoToken.accessToken);

      switch (result) {
        case Ok(:final value):
          // TODO: FCM 붙이면 여기서 alarmRepository.registerDeviceId() 호출.
          state = state.copyWith(
            loginUiState: const LoginUiStateSuccess(),
            userName: value.name,
          );
        case Err(:final error):
          _logFailure(error);
          state = state.copyWith(loginUiState: const LoginUiStateFailure());
      }
    } on _KakaoLoginCancelled {
      state = state.copyWith(loginUiState: const LoginUiStateIdle());
    } on _KakaoLoginNetworkError {
      state = state.copyWith(loginUiState: const LoginUiStateIdle());
    } catch (e) {
      debugPrint('카카오 로그인 실패: $e');
      state = state.copyWith(loginUiState: const LoginUiStateFailure());
    }
  }

  Future<OAuthToken> _issueKakaoAccessToken() async {
    final installed = await isKakaoTalkInstalled();
    if (!installed) {
      return _loginWithKakaoAccount();
    }
    try {
      return await UserApi.instance.loginWithKakaoTalk();
    } catch (e) {
      if (_isCancelledByUser(e)) throw const _KakaoLoginCancelled();
      if (_isNetworkError(e)) throw const _KakaoLoginNetworkError();
      // 카카오톡 앱전환 로그인이 취소/네트워크 오류가 아닌 다른 이유로
      // 실패한 경우에만 브라우저 계정 로그인으로 폴백한다.
      return _loginWithKakaoAccount();
    }
  }

  Future<OAuthToken> _loginWithKakaoAccount() async {
    try {
      return await UserApi.instance.loginWithKakaoAccount();
    } catch (e) {
      if (_isCancelledByUser(e)) throw const _KakaoLoginCancelled();
      if (_isNetworkError(e)) throw const _KakaoLoginNetworkError();
      rethrow;
    }
  }

  bool _isCancelledByUser(Object error) {
    if (error is KakaoClientException) {
      return error.reason == ClientErrorCause.cancelled;
    }
    if (error is KakaoAuthException) {
      return error.error == AuthErrorCause.accessDenied;
    }
    return false;
  }

  bool _isNetworkError(Object error) {
    if (error is KakaoAuthException) {
      final description = error.errorDescription ?? '';
      return description.contains('ERR_INTERNET_DISCONNECTED') ||
          description.contains('ERR_NAME_NOT_RESOLVED') ||
          description.contains('ERR_CONNECTION_REFUSED') ||
          description.contains('ERR_NETWORK_CHANGED') ||
          description.contains('net::');
    }
    return error is SocketException || error is TimeoutException;
  }

  /// 백엔드가 보낸 실제 에러 본문(status/code/message)까지 콘솔에 남긴다.
  /// 사용자에겐 절대 노출하지 않고 개발자 디버깅용으로만 쓴다.
  void _logFailure(Object error) {
    if (error is DioException) {
      debugPrint(
        '카카오 로그인 실패: HTTP ${error.response?.statusCode} '
        'body=${error.response?.data}',
      );
    } else {
      debugPrint('카카오 로그인 실패: $error');
    }
  }
}

/// 사용자가 카카오 로그인 화면에서 취소했을 때.
class _KakaoLoginCancelled implements Exception {
  const _KakaoLoginCancelled();
}

/// 네트워크 문제(오프라인, DNS 실패, 타임아웃 등)로 카카오 로그인이 실패했을 때.
class _KakaoLoginNetworkError implements Exception {
  const _KakaoLoginNetworkError();
}
