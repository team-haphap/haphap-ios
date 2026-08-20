import '../../../core/extensions/date_time_ext.dart';
import '../../../core/type/present_chance_type.dart';
import '../../model/calendar/calendar_model.dart';
import '../../model/calendar/calendar_posting_model.dart';
import '../../remote/dto/calendar/calendar_postings_response_dto.dart';
import '../../remote/dto/calendar/calendar_response_dto.dart';

/// Android `CalendarMapper.kt`에 대응.
PresentChanceType _toPresentChanceType(String likelihood) {
  return switch (likelihood) {
    'VERY_LOW' => PresentChanceType.veryLow,
    'LOW' => PresentChanceType.low,
    'MEDIUM' => PresentChanceType.medium,
    'HIGH' => PresentChanceType.high,
    'VERY_HIGH' => PresentChanceType.veryHigh,
    _ => PresentChanceType.none,
  };
}

extension CalendarDateDtoMapper on CalendarDateDto {
  CalendarModel toModel() {
    return CalendarModel(
      date: date.toLocalDate(),
      likelihood: _toPresentChanceType(likelihood),
    );
  }
}

extension CalendarPostingDtoMapper on CalendarPostingDto {
  CalendarPostingModel toModel() {
    return CalendarPostingModel(
      id: postingId,
      title: title,
      stageName: stageName,
      likelihood: _toPresentChanceType(likelihood),
      participantCount: participantCount,
      logoImageUrl: logoImageUrl,
    );
  }
}
