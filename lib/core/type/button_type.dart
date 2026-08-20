/// Android `ButtonType.kt`에 대응.
sealed class HapHapButtonType {
  const HapHapButtonType();
}

class HapHapButtonTypePrimary extends HapHapButtonType {
  const HapHapButtonTypePrimary({this.enabled = true});

  final bool enabled;
}

class HapHapButtonTypeCancel extends HapHapButtonType {
  const HapHapButtonTypeCancel();
}

class HapHapButtonTypeSelected extends HapHapButtonType {
  const HapHapButtonTypeSelected();
}

class HapHapButtonTypeUnSelected extends HapHapButtonType {
  const HapHapButtonTypeUnSelected();
}
