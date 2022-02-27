import 'package:flutter/material.dart';
import 'package:kyahaal/gen/assets.gen.dart';
import 'package:kyahaal/utils/constants.dart';

enum AppLogoVariant {
  markOnly,
  markAndText,
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
    this.size,
    this.variant = AppLogoVariant.markOnly,
    this.duration = kAnimationDuration,
  }) : super(key: key);

  final double? size;
  final AppLogoVariant variant;
  final Duration duration;

  ///Builds the logo with the given size for Mark only variant
  Widget _buildMark() =>
      Hero(tag: 'kyahaal_logo', child: Assets.icons.logo.image());

  ///Builds the logo with the given size for Mark and Text variant
  Widget _buildMarknText(double iconSize, Color color) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Hero(
            tag: 'kyahaal_logo',
            child: Assets.icons.logo.image(
              height: iconSize * 0.5,
              width: iconSize * 0.5,
            ),
          ),
          Text(
            'KyaHaal',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: iconSize * 0.25,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final iconSize = size ?? iconTheme.size ?? 24;
    return AnimatedContainer(
      duration: duration,
      width: variant == AppLogoVariant.markOnly ? iconSize : double.maxFinite,
      height: iconSize,
      child: variant == AppLogoVariant.markOnly
          ? _buildMark()
          : _buildMarknText(iconSize, iconTheme.color!),
    );
  }
}
