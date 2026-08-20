import 'package:flutter/material.dart';

import 'haphap_toast.dart';
import 'haphap_toast_visuals.dart';

/// Android `LocalToastTrigger`에 대응.
///
/// Compose의 CompositionLocal과 달리 Flutter는 BuildContext 없이도 호출
/// 가능한 전역 키를 쓴다 — [main.dart]의 `MaterialApp.scaffoldMessengerKey`에
/// 이 키를 연결해두면 [showHapHapToast]를 어디서든 호출할 수 있다.
final GlobalKey<ScaffoldMessengerState> haphapScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

/// Android `LocalToastBottomInset`에 대응 — 토스트를 하단 고정 요소(예: FAB,
/// 네비게이션 바) 위로 띄워야 하는 화면에서 이 값을 갱신해두면 된다.
final ValueNotifier<double> haphapToastBottomInset = ValueNotifier<double>(0);

/// 어디서든 호출 가능한 HapHap 토스트 트리거.
void showHapHapToast(HapHapToastVisuals visuals) {
  final messengerState = haphapScaffoldMessengerKey.currentState;
  if (messengerState == null) return;

  messengerState
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: HapHapToast(text: visuals.message, isAlarm: visuals.isAlarm),
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        duration: visuals.duration.value,
        dismissDirection: visuals.withDismissAction
            ? DismissDirection.down
            : DismissDirection.none,
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20 + haphapToastBottomInset.value,
        ),
      ),
    );
}
