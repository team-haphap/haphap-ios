import '../../../domain/entity/home/home_banner_entity.dart';

class HomeBannerModel {
  const HomeBannerModel({required this.title, required this.subtitle});

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) {
    return HomeBannerModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
    );
  }

  final String title;
  final String subtitle;

  HomeBannerEntity toEntity() {
    return HomeBannerEntity(title: title, subtitle: subtitle);
  }
}
