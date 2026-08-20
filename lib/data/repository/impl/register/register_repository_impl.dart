import 'package:dio/dio.dart';

import '../../../../core/util/result.dart';
import '../../../../core/util/run_catching.dart';
import '../../../../presentation/register/type/register_result_type.dart';
import '../../../mapper/register/register_mapper.dart';
import '../../../model/register/register_dropdown_item_model.dart';
import '../../../model/register/register_model.dart';
import '../../../model/register/register_process_model.dart';
import '../../../model/register/registration_check_type.dart';
import '../../../model/register/registration_model.dart';
import '../../../remote/datasource/api/register/register_data_source.dart';
import '../../../remote/dto/register/register_request_dto.dart';
import '../../../remote/dto/register/registration_check_request_dto.dart';
import '../../api/register/register_repository.dart';

const _registrationConfirmRequiredCode = 'REGISTRATION_CONFIRM_REQUIRED';
const _httpConflict = 409;

class RegisterRepositoryImpl implements RegisterRepository {
  const RegisterRepositoryImpl(this._dataSource);

  final RegisterDataSource _dataSource;

  @override
  Future<Result<List<RegisterDropDownItemModel>>> getRegisterPostNames() {
    return runCatchingAsync(() async {
      final response = await _dataSource.getRegisterPostNames();
      return response.checkData().postings.map((e) => e.toModel()).toList();
    });
  }

  @override
  Future<Result<List<RegisterProcessModel>>> getRegisterPostStages(
    int postingId,
  ) {
    return runCatchingAsync(() async {
      final response = await _dataSource.getRegisterPostStages(postingId);
      return response.checkData().stages.map((e) => e.toModel()).toList();
    });
  }

  @override
  Future<Result<RegistrationModel>> postRegister(RegisterModel registerInfo) {
    return runCatchingAsync(() async {
      final postingId = registerInfo.postingId;
      final stageId = registerInfo.stageId;
      final result = registerInfo.result;
      if (postingId == null) throw StateError('postingId is required');
      if (stageId == null) throw StateError('stageId is required');
      if (result == null) throw StateError('result is required');

      final isPending = result == RegisterResultType.pending;

      final request = RegisterRequestDto(
        postingId: postingId,
        stageId: stageId,
        contactedDate: isPending ? null : registerInfo.contactedDate,
        contactedTime: isPending ? null : registerInfo.contactedTime,
        contactMethods: isPending
            ? null
            : registerInfo.contactedMethod.map((e) => e.apiValue).toList(),
        result: result.apiValue,
        anonymous: registerInfo.anonymous,
        alarmEnabled: registerInfo.alarmEnabled,
      );

      final response = await _dataSource.postRegister(request);
      return response.checkData().toModel();
    });
  }

  @override
  Future<Result<RegistrationCheckType>> postCheckRegistration(
    int postingId,
    int stageId,
    RegisterResultType result,
  ) {
    return runCatchingAsync(() async {
      try {
        final request = RegistrationCheckRequestDto(result: result.apiValue);
        final response = await _dataSource.getRegisterCheck(
          postingId,
          stageId,
          request,
        );
        return response.code == _registrationConfirmRequiredCode
            ? RegistrationCheckType.confirmRequired
            : RegistrationCheckType.newRegistration;
      } on DioException catch (e) {
        if (e.response?.statusCode == _httpConflict) {
          return RegistrationCheckType.duplicate;
        }
        rethrow;
      }
    });
  }
}
