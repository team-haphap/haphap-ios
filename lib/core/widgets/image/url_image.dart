import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// URL을 통해 이미지를 비동기로 로드하여 표시한다.
/// URL이 비어있거나 로드에 실패하면 회색(gray50) placeholder를 보여준다.
class UrlImage extends StatelessWidget {
  const UrlImage({
    super.key,
    this.url = '',
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  });

  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _placeholder();

    return Image.network(
      url,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => _placeholder(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _placeholder();
      },
    );
  }

  Widget _placeholder() {
    return ColoredBox(
      color: AppColors.gray50,
      child: SizedBox(width: width, height: height),
    );
  }
}
