import '../../../dto/base_response.dart';
import '../../../dto/register/register_name_list_response_dto.dart';
import '../../../dto/register/register_stage_list_response_dto.dart';
import '../../../dto/register/registration_check_request_dto.dart';
import '../../../dto/register/register_request_dto.dart';
import '../../../dto/register/registration_response_dto.dart';

abstract class RegisterDataSource {
  Future<BaseResponse<RegisterNameListResponseDto>> getRegisterPostNames();

  Future<BaseResponse<RegisterStageListResponseDto>> getRegisterPostStages(
    int postingId,
  );

  Future<BaseResponse<RegistrationResponseDto>> postRegister(
    RegisterRequestDto request,
  );

  Future<BaseResponse<void>> getRegisterCheck(
    int postingId,
    int stageId,
    RegistrationCheckRequestDto request,
  );
}
