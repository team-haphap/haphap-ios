/// Android `SnackbarDuration`에 대응.
enum HapHapToastDuration {
  short(Duration(seconds: 4)),
  long(Duration(seconds: 10)),
  indefinite(Duration(days: 1));

  const HapHapToastDuration(this.value);

  final Duration value;
}

/// Android `HapHapToastVisuals`에 대응하는 토스트 표시 정보.
class HapHapToastVisuals {
  const HapHapToastVisuals({
    required this.message,
    this.isAlarm = true,
    this.withDismissAction = false,
    this.duration = HapHapToastDuration.indefinite,
  });

  final String message;
  final bool isAlarm;
  final bool withDismissAction;
  final HapHapToastDuration duration;
}
