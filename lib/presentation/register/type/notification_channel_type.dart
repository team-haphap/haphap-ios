/// Android `NotificationChannelType.kt`에 대응.
enum NotificationChannelType {
  email('이메일', 'EMAIL'),
  sms('문자', 'SMS'),
  page('기업 홈페이지', 'PAGE'),
  phoneCall('전화', 'PHONE_CALL');

  const NotificationChannelType(this.text, this.apiValue);

  final String text;
  final String apiValue;
}
