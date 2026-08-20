import '../../../../remote/service/register_service.dart';
import '../../../dto/base_response.dart';
import '../../../dto/register/register_name_list_response_dto.dart';
import '../../../dto/register/register_request_dto.dart';
import '../../../dto/register/register_stage_list_response_dto.dart';
import '../../../dto/register/registration_check_request_dto.dart';
import '../../../dto/register/registration_response_dto.dart';
import '../../api/register/register_data_source.dart';

class RegisterDataSourceImpl implements RegisterDataSource {
  const RegisterDataSourceImpl(this._registerService);

  final RegisterService _registerService;

  @override
  Future<BaseResponse<RegisterNameListResponseDto>> getRegisterPostNames() {
    return _registerService.getRegisterPostNames();
  }

  @override
  Future<BaseResponse<RegisterStageListResponseDto>> getRegisterPostStages(
    int postingId,
  ) {
    return _registerService.getRegisterPostStages(postingId);
  }

  @override
  Future<BaseResponse<RegistrationResponseDto>> postRegister(
    RegisterRequestDto request,
  ) {
    return _registerService.postRegistration(request);
  }

  @override
  Future<BaseResponse<void>> getRegisterCheck(
    int postingId,
    int stageId,
    RegistrationCheckRequestDto request,
  ) {
    return _registerService.postRegistrationCheck(postingId, stageId, request);
  }
}
