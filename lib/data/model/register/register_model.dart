import '../../../presentation/register/type/notification_channel_type.dart';
import '../../../presentation/register/type/register_result_type.dart';

/// Android `RegisterModel.kt`에 대응. 마법사 전체에서 누적되는 폼 데이터.
class RegisterModel {
  const RegisterModel({
    this.postingId,
    this.stageId,
    this.result,
    this.contactedDate,
    this.contactedTime,
    this.contactedMethod = const [],
    this.anonymous = false,
    this.alarmEnabled = false,
  });

  final int? postingId;
  final int? stageId;
  final RegisterResultType? result;

  /// "yyyy-MM-dd" 형식.
  final String? contactedDate;

  /// "HH:mm:ss" 형식.
  final String? contactedTime;
  final List<NotificationChannelType> contactedMethod;
  final bool anonymous;
  final bool alarmEnabled;

  RegisterModel copyWith({
    int? postingId,
    bool clearPostingId = false,
    int? stageId,
    bool clearStageId = false,
    RegisterResultType? result,
    String? contactedDate,
    bool clearContactedDate = false,
    String? contactedTime,
    bool clearContactedTime = false,
    List<NotificationChannelType>? contactedMethod,
    bool? anonymous,
    bool? alarmEnabled,
  }) {
    return RegisterModel(
      postingId: clearPostingId ? null : (postingId ?? this.postingId),
      stageId: clearStageId ? null : (stageId ?? this.stageId),
      result: result ?? this.result,
      contactedDate: clearContactedDate
          ? null
          : (contactedDate ?? this.contactedDate),
      contactedTime: clearContactedTime
          ? null
          : (contactedTime ?? this.contactedTime),
      contactedMethod: contactedMethod ?? this.contactedMethod,
      anonymous: anonymous ?? this.anonymous,
      alarmEnabled: alarmEnabled ?? this.alarmEnabled,
    );
  }
}
