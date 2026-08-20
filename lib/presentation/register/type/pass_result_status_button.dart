import 'register_result_type.dart';

/// Android `PassResultStatusButton`(`RegisterPassResultType.kt`)에 대응.
/// 2단계(결과 선택)에서 쓰는 선택 버튼 3종.
enum PassResultStatusButton {
  pass(
    text: '합격했어요',
    defaultBadgeAsset: 'assets/images/register/img_register_pass_default.png',
    selectedBadgeAsset:
        'assets/images/register/img_register_pass_selected.png',
  ),
  failed(
    text: '불합격했어요',
    defaultBadgeAsset: 'assets/images/register/img_register_fail_default.png',
    selectedBadgeAsset:
        'assets/images/register/img_register_fail_selected.png',
  ),
  dontKnow(
    text: '아직 몰라요',
    defaultBadgeAsset: 'assets/images/register/img_register_wait_default.png',
    selectedBadgeAsset:
        'assets/images/register/img_register_wait_selected.png',
  );

  const PassResultStatusButton({
    required this.text,
    required this.defaultBadgeAsset,
    required this.selectedBadgeAsset,
  });

  final String text;
  final String defaultBadgeAsset;
  final String selectedBadgeAsset;
}

/// Android `RegisterPassResultType.kt`에 대응. 4단계 확인 화면의 결과 라벨.
enum RegisterPassResultType {
  pass('합격했어요'),
  failed('불합격했어요'),
  dontKnow('아직 몰라요');

  const RegisterPassResultType(this.text);

  final String text;
}

/// Android `RegisterPassResultConfirmType.kt`의 매핑 함수에 대응.
extension PassResultStatusButtonMapper on PassResultStatusButton {
  RegisterPassResultType toPassResultType() {
    return switch (this) {
      PassResultStatusButton.pass => RegisterPassResultType.pass,
      PassResultStatusButton.failed => RegisterPassResultType.failed,
      PassResultStatusButton.dontKnow => RegisterPassResultType.dontKnow,
    };
  }

  RegisterResultType toRegisterResultType() {
    return switch (this) {
      PassResultStatusButton.pass => RegisterResultType.pass,
      PassResultStatusButton.failed => RegisterResultType.fail,
      PassResultStatusButton.dontKnow => RegisterResultType.pending,
    };
  }
}
