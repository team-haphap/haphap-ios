import 'register_pass_card_model.dart';

/// Android `RegistrationModel.kt`에 대응.
class RegistrationModel {
  const RegistrationModel({required this.registrationId, this.card});

  final int registrationId;
  final RegisterPassCardModel? card;
}
