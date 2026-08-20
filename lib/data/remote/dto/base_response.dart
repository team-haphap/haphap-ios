/// Android `BaseResponse.kt`에 대응. HapHap 백엔드는 성공/실패 모두
/// `{status, code, message, data}` 형태로 응답을 감싸서 보낸다.
class BaseResponse<T> {
  const BaseResponse({
    required this.status,
    required this.code,
    required this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json)? fromJsonT,
  ) {
    final rawData = json['data'];
    return BaseResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: rawData == null || fromJsonT == null
          ? null
          : fromJsonT(rawData as Map<String, dynamic>),
    );
  }

  final int status;
  final String code;
  final String message;
  final T? data;

  static const _httpOk = 200;
  static const _httpCreated = 201;
  static const _httpNoContent = 204;

  /// [data]가 반드시 있어야 하는 응답을 검증하고 꺼낸다.
  T checkData() {
    if (status != _httpOk && status != _httpCreated) {
      throw StateError('Successful response but data was null.');
    }
    return data ?? (throw StateError('API request failed'));
  }

  /// [data]가 없을 수도 있는 응답(예: 204 No Content)을 검증하고 꺼낸다.
  T? checkNullData() {
    if (status != _httpOk && status != _httpNoContent) {
      throw StateError('API request failed');
    }
    return data;
  }
}
