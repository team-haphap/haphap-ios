import 'package:dio/dio.dart';

import '../dto/base_response.dart';
import '../dto/register/register_name_list_response_dto.dart';
import '../dto/register/register_request_dto.dart';
import '../dto/register/register_stage_list_response_dto.dart';
import '../dto/register/registration_check_request_dto.dart';
import '../dto/register/registration_response_dto.dart';

/// Android `RegisterService.kt`(Retrofit)에 대응하는 얇은 Dio 래퍼.
class RegisterService {
  const RegisterService(this._dio);

  final Dio _dio;

  Future<BaseResponse<RegisterNameListResponseDto>> getRegisterPostNames() async {
    final response = await _dio.get<Map<String, dynamic>>('/api/v1/postings/name');
    return BaseResponse.fromJson(
      response.data!,
      RegisterNameListResponseDto.fromJson,
    );
  }

  Future<BaseResponse<RegisterStageListResponseDto>> getRegisterPostStages(
    int postingId,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/postings/$postingId/stages',
    );
    return BaseResponse.fromJson(
      response.data!,
      RegisterStageListResponseDto.fromJson,
    );
  }

  Future<BaseResponse<RegistrationResponseDto>> postRegistration(
    RegisterRequestDto request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/v1/registrations',
      data: request.toJson(),
    );
    return BaseResponse.fromJson(
      response.data!,
      RegistrationResponseDto.fromJson,
    );
  }

  Future<BaseResponse<void>> postRegistrationCheck(
    int postingId,
    int stageId,
    RegistrationCheckRequestDto request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/v1/registrations/$postingId/$stageId',
      data: request.toJson(),
    );
    return BaseResponse.fromJson(response.data!, null);
  }
}
