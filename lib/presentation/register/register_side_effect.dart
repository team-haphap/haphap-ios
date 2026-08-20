import '../../data/model/register/register_pass_card_model.dart';

/// Android `RegisterContract.SideEffect`에 대응. (`OnShowToast`는 Flutter에선
/// 전역 함수 [showHapHapToast]를 바로 호출하므로 여기 포함하지 않는다.)
sealed class RegisterSideEffect {
  const RegisterSideEffect();
}

class NavigateToHome extends RegisterSideEffect {
  const NavigateToHome();
}

class NavigateToJobDetail extends RegisterSideEffect {
  const NavigateToJobDetail(this.jobId);

  final int jobId;
}

class NavigateToPassCard extends RegisterSideEffect {
  const NavigateToPassCard(this.passCard);

  final RegisterPassCardModel passCard;
}
