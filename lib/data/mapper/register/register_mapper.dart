import '../../model/register/register_dropdown_item_model.dart';
import '../../model/register/register_pass_card_model.dart';
import '../../model/register/register_process_model.dart';
import '../../model/register/registration_model.dart';
import '../../remote/dto/register/register_name_list_response_dto.dart';
import '../../remote/dto/register/register_stage_list_response_dto.dart';
import '../../remote/dto/register/registration_response_dto.dart';

/// Android `RegisterMapper.kt`에 대응.
extension RegisterNameDtoMapper on RegisterNameDto {
  RegisterDropDownItemModel toModel() =>
      RegisterDropDownItemModel(id: id, text: title);
}

extension RegisterStageDtoMapper on RegisterStageDto {
  RegisterProcessModel toModel() =>
      RegisterProcessModel(id: stageId, text: stageName);
}

extension RegistrationResponseDtoMapper on RegistrationResponseDto {
  RegistrationModel toModel() => RegistrationModel(
    registrationId: registrationId,
    card: card?.toModel(),
  );
}

extension PassCardDtoMapper on PassCardDto {
  RegisterPassCardModel toModel() => RegisterPassCardModel(
    userName: userName,
    recruitName: title,
    companyName: companyName,
    logoUrl: companyCardLogoImageUrl,
    backgroundImageUrl: cardImageUrl,
  );
}
