import 'package:flutter/material.dart';

/// Text styles for the App.
enum AppTextStyles {
  displayLarge(DefaultAppTextStyles.displayLarge),
  displayMedium(DefaultAppTextStyles.displayMedium),
  displaySmall(DefaultAppTextStyles.displaySmall),
  headlineLarge(DefaultAppTextStyles.headlineLarge),
  headlineMedium(DefaultAppTextStyles.headlineMedium),
  headlineSmall(DefaultAppTextStyles.headlineSmall),
  titleLarge(DefaultAppTextStyles.titleLarge),
  titleMedium(DefaultAppTextStyles.titleMedium),
  titleSmall(DefaultAppTextStyles.titleSmall),
  bodyLarge(DefaultAppTextStyles.bodyLarge),
  bodyMedium(DefaultAppTextStyles.bodyMedium),
  bodySmall(DefaultAppTextStyles.bodySmall),
  labelLarge(DefaultAppTextStyles.labelLarge),
  labelMedium(DefaultAppTextStyles.labelMedium),
  labelSmall(DefaultAppTextStyles.labelSmall);

  const AppTextStyles(this.style);

  final TextStyle style;
}

/// Default text styles for the App.
abstract final class DefaultAppTextStyles {
  const DefaultAppTextStyles._();

  static const TextStyle displayLarge = TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 64 / 57,
      ),
      displayMedium = TextStyle(fontSize: 45, fontWeight: FontWeight.w400, letterSpacing: 0, height: 52 / 45),
      displaySmall = TextStyle(fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0, height: 44 / 36),
      headlineLarge = TextStyle(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0, height: 40 / 32),
      headlineMedium = TextStyle(fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0, height: 36 / 28),
      headlineSmall = TextStyle(fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0, height: 32 / 24),
      titleLarge = TextStyle(fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 0, height: 28 / 22),
      titleMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, height: 24 / 16),
      titleSmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 20 / 14),
      bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 24 / 16),
      bodyMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 20 / 14),
      bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 16 / 12),
      labelLarge = TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.1, height: 20 / 14),
      labelMedium = TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.5, height: 16 / 12),
      labelSmall = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 16 / 11);
}

/// Typography class for the App.
@immutable
class AppTypography implements ThemeExtension<AppTypography> {
  const AppTypography({
    this.displayLarge = DefaultAppTextStyles.displayLarge,
    this.displayMedium = DefaultAppTextStyles.displayMedium,
    this.displaySmall = DefaultAppTextStyles.displaySmall,
    this.headlineLarge = DefaultAppTextStyles.headlineLarge,
    this.headlineMedium = DefaultAppTextStyles.headlineMedium,
    this.headlineSmall = DefaultAppTextStyles.headlineSmall,
    this.titleLarge = DefaultAppTextStyles.titleLarge,
    this.titleMedium = DefaultAppTextStyles.titleMedium,
    this.titleSmall = DefaultAppTextStyles.titleSmall,
    this.bodyLarge = DefaultAppTextStyles.bodyLarge,
    this.bodyMedium = DefaultAppTextStyles.bodyMedium,
    this.bodySmall = DefaultAppTextStyles.bodySmall,
    this.labelLarge = DefaultAppTextStyles.labelLarge,
    this.labelMedium = DefaultAppTextStyles.labelMedium,
    this.labelSmall = DefaultAppTextStyles.labelSmall,
  });

  final TextStyle displayLarge,
      displayMedium,
      displaySmall,
      headlineLarge,
      headlineMedium,
      headlineSmall,
      titleLarge,
      titleMedium,
      titleSmall,
      bodyLarge,
      bodyMedium,
      bodySmall,
      labelLarge,
      labelMedium,
      labelSmall;

  @override
  Object get type => AppTypography;

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) => AppTypography(
    displayLarge: displayLarge ?? this.displayLarge,
    displayMedium: displayMedium ?? this.displayMedium,
    displaySmall: displaySmall ?? this.displaySmall,
    headlineLarge: headlineLarge ?? this.headlineLarge,
    headlineMedium: headlineMedium ?? this.headlineMedium,
    headlineSmall: headlineSmall ?? this.headlineSmall,
    titleLarge: titleLarge ?? this.titleLarge,
    titleMedium: titleMedium ?? this.titleMedium,
    titleSmall: titleSmall ?? this.titleSmall,
    bodyLarge: bodyLarge ?? this.bodyLarge,
    bodyMedium: bodyMedium ?? this.bodyMedium,
    bodySmall: bodySmall ?? this.bodySmall,
    labelLarge: labelLarge ?? this.labelLarge,
    labelMedium: labelMedium ?? this.labelMedium,
    labelSmall: labelSmall ?? this.labelSmall,
  );

  @override
  ThemeExtension<AppTypography> lerp(covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    return AppTypography(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }

  /// Returns the [TextStyle] for the given [id].
  TextStyle operator [](AppTextStyles style) => switch (style) {
    AppTextStyles.displayLarge => displayLarge,
    AppTextStyles.displayMedium => displayMedium,
    AppTextStyles.displaySmall => displaySmall,
    AppTextStyles.headlineLarge => headlineLarge,
    AppTextStyles.headlineMedium => headlineMedium,
    AppTextStyles.headlineSmall => headlineSmall,
    AppTextStyles.titleLarge => titleLarge,
    AppTextStyles.titleMedium => titleMedium,
    AppTextStyles.titleSmall => titleSmall,
    AppTextStyles.bodyLarge => bodyLarge,
    AppTextStyles.bodyMedium => bodyMedium,
    AppTextStyles.bodySmall => bodySmall,
    AppTextStyles.labelLarge => labelLarge,
    AppTextStyles.labelMedium => labelMedium,
    AppTextStyles.labelSmall => labelSmall,
  };
}
