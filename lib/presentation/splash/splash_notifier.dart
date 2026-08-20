import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/network_riverpod.dart';

const _minSplashDelay = Duration(milliseconds: 2000);

class SplashState {
  const SplashState({this.isLoggedIn});

  /// null이면 아직 확인 중.
  final bool? isLoggedIn;
}

/// Android `SplashViewModel.kt`에 대응 — 최소 2초 동안 스플래시를 보여주며
/// 그 사이에 저장된 액세스 토큰 유무로 로그인 여부를 확인한다.
class SplashNotifier extends AutoDisposeNotifier<SplashState> {
  @override
  SplashState build() {
    _checkLoginState();
    return const SplashState();
  }

  Future<void> _checkLoginState() async {
    String? accessToken;
    try {
      final tokenFuture = ref
          .read(localTokenDataSourceProvider)
          .getAccessToken()
          .then((token) => accessToken = token);

      await Future.wait([tokenFuture, Future<void>.delayed(_minSplashDelay)]);
    } catch (e) {
      // 토큰 조회가 실패해도 스플래시에 영원히 멈춰있으면 안 되니,
      // 비로그인으로 간주하고 로그인 화면으로 보낸다.
      debugPrint('스플래시 토큰 확인 실패: $e');
    }

    state = SplashState(
      isLoggedIn: accessToken != null && accessToken!.isNotEmpty,
    );
  }
}
