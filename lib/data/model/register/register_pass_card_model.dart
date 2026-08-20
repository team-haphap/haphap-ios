/// Android `RegisterPassCardModel.kt`에 대응.
class RegisterPassCardModel {
  const RegisterPassCardModel({
    required this.userName,
    required this.recruitName,
    required this.companyName,
    required this.logoUrl,
    required this.backgroundImageUrl,
  });

  final String userName;
  final String recruitName;
  final String companyName;
  final String logoUrl;
  final String backgroundImageUrl;
}
