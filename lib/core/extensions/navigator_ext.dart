import 'package:flutter/material.dart';

/// Android `NavControllerExt.kt`에 대응.
///
/// `clearBackStackWithRestoreNavOptions`(탭 전환 시 백스택 초기화 + 이전
/// 탭 상태 복원)에 해당하는 동작은 우리 쪽에선 하단 네비게이션이
/// `IndexedStack`으로 구현되어 있어 애초에 화면을 push/pop하지 않고
/// 인덱스만 바꾸므로 별도 포팅이 필요 없다 — 탭 상태는 항상 보존된다.
extension ClearBackStackNavigation on NavigatorState {
  /// 백스택을 완전히 비우고 [page]로 이동한다.
  ///
  /// 사용 사례: 로그아웃 후 로그인 화면으로 이동, 특정 플로우 완료 후
  /// 이전 화면이 남아있으면 안 되는 새 화면으로 이동(예: 로그인 완료 후 홈).
  void pushAndClearBackStack(Widget page) {
    pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}
