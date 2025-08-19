import 'package:flutter/material.dart';
import 'package:ui/src/colors.dart';
import 'package:ui/src/typography.dart';

const double baseRadius = 16;
const double radiusSm = baseRadius - 8.0;
const double radiusMd = baseRadius - 4.0;
const double radiusLg = baseRadius;
const double radiusXl = baseRadius + 4.0;

// Responsive values
const double statusBarHeight = 24;
const double safeAreaTop = 44;
const double safeAreaBottom = 34;
const double appHeaderHeight = 56;
const double bottomNavHeight = 80;
const double mobilePadding = 16;
const double tabletPadding = 24;
const double desktopPadding = 32;

// Typography
const double baseFontSize = 14;
const FontWeight fontWeightNormal = FontWeight.w400;
const FontWeight fontWeightMedium = FontWeight.w500;

ThemeData lightTheme() => ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: LightColors.lightPrimary,
    onPrimary: LightColors.lightPrimaryForeground,
    secondary: LightColors.lightSecondary,
    onSecondary: LightColors.lightSecondaryForeground,
    error: LightColors.lightDestructive,
    onError: LightColors.lightDestructiveForeground,
    surface: LightColors.lightCard,
    onSurface: LightColors.lightCardForeground,
  ),
  scaffoldBackgroundColor: LightColors.lightBackground,
  cardColor: LightColors.lightCard,
  cardTheme: CardThemeData(
    color: LightColors.lightCard,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: LightColors.lightBackground,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: fontWeightMedium, color: LightColors.lightForeground),
    iconTheme: IconThemeData(color: LightColors.lightForeground),
  ),
  textTheme: _buildTextTheme(LightColors.lightForeground),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColors.lightPrimary,
      foregroundColor: LightColors.lightPrimaryForeground,
      minimumSize: const Size.fromHeight(44),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
      textStyle: const TextStyle(fontSize: baseFontSize, fontWeight: fontWeightMedium),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: LightColors.lightInputBackground,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: LightColors.lightBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: LightColors.lightBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: LightColors.lightPrimary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: LightColors.lightDestructive),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: LightColors.lightDestructive, width: 2),
    ),
    labelStyle: const TextStyle(color: LightColors.lightForeground, fontWeight: fontWeightMedium),
    hintStyle: const TextStyle(color: LightColors.lightMutedForeground),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return LightColors.lightPrimary;
      }
      return LightColors.lightSwitchBackground;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return LightColors.lightPrimary.withAlpha(127);
      }
      return LightColors.lightSwitchBackground.withAlpha(127);
    }),
  ),
  dividerTheme: const DividerThemeData(color: LightColors.lightBorder, thickness: 1, space: 1),
  extensions: const <ThemeExtension<dynamic>>[
    CustomThemeExtension(
      popover: LightColors.lightPopover,
      popoverForeground: LightColors.lightPopoverForeground,
      muted: LightColors.lightMuted,
      mutedForeground: LightColors.lightMutedForeground,
      accent: LightColors.lightAccent,
      accentForeground: LightColors.lightAccentForeground,
      border: LightColors.lightBorder,
      input: LightColors.lightInput,
      inputBackground: LightColors.lightInputBackground,
      switchBackground: LightColors.lightSwitchBackground,
      ring: LightColors.lightRing,
      chart1: LightColors.lightChart1,
      chart2: LightColors.lightChart2,
      chart3: LightColors.lightChart3,
      chart4: LightColors.lightChart4,
      chart5: LightColors.lightChart5,
      sidebar: LightColors.lightSidebar,
      sidebarForeground: LightColors.lightSidebarForeground,
      sidebarPrimary: LightColors.lightSidebarPrimary,
      sidebarPrimaryForeground: LightColors.lightSidebarPrimaryForeground,
      sidebarAccent: LightColors.lightSidebarAccent,
      sidebarAccentForeground: LightColors.lightSidebarAccentForeground,
      sidebarBorder: LightColors.lightSidebarBorder,
      sidebarRing: LightColors.lightSidebarRing,
    ),

    AppTypography(),
  ],
);

ThemeData darkTheme() => ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: DarkColors.darkPrimary,
    onPrimary: DarkColors.darkPrimaryForeground,
    secondary: DarkColors.darkSecondary,
    onSecondary: DarkColors.darkSecondaryForeground,
    error: DarkColors.darkDestructive,
    onError: DarkColors.darkDestructiveForeground,
    surface: DarkColors.darkCard,
    onSurface: DarkColors.darkCardForeground,
  ),
  scaffoldBackgroundColor: DarkColors.darkBackground,
  cardColor: DarkColors.darkCard,
  cardTheme: CardThemeData(
    color: DarkColors.darkCard,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkColors.darkBackground,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: fontWeightMedium, color: DarkColors.darkForeground),
    iconTheme: IconThemeData(color: DarkColors.darkForeground),
  ),
  textTheme: _buildTextTheme(DarkColors.darkForeground),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DarkColors.darkPrimary,
      foregroundColor: DarkColors.darkPrimaryForeground,
      minimumSize: const Size.fromHeight(44),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
      textStyle: const TextStyle(fontSize: baseFontSize, fontWeight: fontWeightMedium),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: DarkColors.darkInput,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: DarkColors.darkBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: DarkColors.darkBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: DarkColors.darkPrimary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: DarkColors.darkDestructive),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: DarkColors.darkDestructive, width: 2),
    ),
    labelStyle: const TextStyle(color: DarkColors.darkForeground, fontWeight: fontWeightMedium),
    hintStyle: const TextStyle(color: DarkColors.darkMutedForeground),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return DarkColors.darkPrimary;
      }
      return DarkColors.darkMuted;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return DarkColors.darkPrimary.withAlpha(127);
      }
      return DarkColors.darkMuted.withAlpha(127);
    }),
  ),
  dividerTheme: const DividerThemeData(color: DarkColors.darkBorder, thickness: 1, space: 1),
  extensions: const <ThemeExtension<dynamic>>[
    CustomThemeExtension(
      popover: DarkColors.darkPopover,
      popoverForeground: DarkColors.darkPopoverForeground,
      muted: DarkColors.darkMuted,
      mutedForeground: DarkColors.darkMutedForeground,
      accent: DarkColors.darkAccent,
      accentForeground: DarkColors.darkAccentForeground,
      border: DarkColors.darkBorder,
      input: DarkColors.darkInput,
      inputBackground: DarkColors.darkInput,
      switchBackground: DarkColors.darkMuted,
      ring: DarkColors.darkRing,
      chart1: DarkColors.darkChart1,
      chart2: DarkColors.darkChart2,
      chart3: DarkColors.darkChart3,
      chart4: DarkColors.darkChart4,
      chart5: DarkColors.darkChart5,
      sidebar: DarkColors.darkSidebar,
      sidebarForeground: DarkColors.darkSidebarForeground,
      sidebarPrimary: DarkColors.darkSidebarPrimary,
      sidebarPrimaryForeground: DarkColors.darkSidebarPrimaryForeground,
      sidebarAccent: DarkColors.darkSidebarAccent,
      sidebarAccentForeground: DarkColors.darkSidebarAccentForeground,
      sidebarBorder: DarkColors.darkSidebarBorder,
      sidebarRing: DarkColors.darkSidebarRing,
    ),
    AppTypography(),
  ],
);

TextTheme _buildTextTheme(Color foregroundColor) => TextTheme(
  displayLarge: TextStyle(fontSize: 24, fontWeight: fontWeightMedium, height: 1.3, color: foregroundColor),
  displayMedium: TextStyle(fontSize: 20, fontWeight: fontWeightMedium, height: 1.4, color: foregroundColor),
  displaySmall: TextStyle(fontSize: 18, fontWeight: fontWeightMedium, height: 1.4, color: foregroundColor),
  headlineMedium: TextStyle(fontSize: 16, fontWeight: fontWeightMedium, height: 1.4, color: foregroundColor),
  bodyLarge: TextStyle(fontSize: baseFontSize, fontWeight: fontWeightNormal, height: 1.5, color: foregroundColor),
  titleMedium: TextStyle(fontSize: baseFontSize, fontWeight: fontWeightMedium, height: 1.4, color: foregroundColor),
  labelLarge: TextStyle(fontSize: baseFontSize, fontWeight: fontWeightMedium, height: 1.4, color: foregroundColor),
);

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  const CustomThemeExtension({
    required this.popover,
    required this.popoverForeground,
    required this.muted,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.border,
    required this.input,
    required this.inputBackground,
    required this.switchBackground,
    required this.ring,
    required this.chart1,
    required this.chart2,
    required this.chart3,
    required this.chart4,
    required this.chart5,
    required this.sidebar,
    required this.sidebarForeground,
    required this.sidebarPrimary,
    required this.sidebarPrimaryForeground,
    required this.sidebarAccent,
    required this.sidebarAccentForeground,
    required this.sidebarBorder,
    required this.sidebarRing,
  });
  final Color popover;
  final Color popoverForeground;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color border;
  final Color input;
  final Color inputBackground;
  final Color switchBackground;
  final Color ring;
  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;
  final Color sidebar;
  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarPrimaryForeground;
  final Color sidebarAccent;
  final Color sidebarAccentForeground;
  final Color sidebarBorder;
  final Color sidebarRing;

  @override
  ThemeExtension<CustomThemeExtension> copyWith() => this;

  @override
  ThemeExtension<CustomThemeExtension> lerp(ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      popover: Color.lerp(popover, other.popover, t) ?? popover,
      popoverForeground: Color.lerp(popoverForeground, other.popoverForeground, t) ?? popoverForeground,
      muted: Color.lerp(muted, other.muted, t) ?? muted,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t) ?? mutedForeground,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      accentForeground: Color.lerp(accentForeground, other.accentForeground, t) ?? accentForeground,
      border: Color.lerp(border, other.border, t) ?? border,
      input: Color.lerp(input, other.input, t) ?? input,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t) ?? inputBackground,
      switchBackground: Color.lerp(switchBackground, other.switchBackground, t) ?? switchBackground,
      ring: Color.lerp(ring, other.ring, t) ?? ring,
      chart1: Color.lerp(chart1, other.chart1, t) ?? chart1,
      chart2: Color.lerp(chart2, other.chart2, t) ?? chart2,
      chart3: Color.lerp(chart3, other.chart3, t) ?? chart3,
      chart4: Color.lerp(chart4, other.chart4, t) ?? chart4,
      chart5: Color.lerp(chart5, other.chart5, t) ?? chart5,
      sidebar: Color.lerp(sidebar, other.sidebar, t) ?? sidebar,
      sidebarForeground: Color.lerp(sidebarForeground, other.sidebarForeground, t) ?? sidebarForeground,
      sidebarPrimary: Color.lerp(sidebarPrimary, other.sidebarPrimary, t) ?? sidebarPrimary,
      sidebarPrimaryForeground:
          Color.lerp(sidebarPrimaryForeground, other.sidebarPrimaryForeground, t) ?? sidebarPrimaryForeground,
      sidebarAccent: Color.lerp(sidebarAccent, other.sidebarAccent, t) ?? sidebarAccent,
      sidebarAccentForeground:
          Color.lerp(sidebarAccentForeground, other.sidebarAccentForeground, t) ?? sidebarAccentForeground,
      sidebarBorder: Color.lerp(sidebarBorder, other.sidebarBorder, t) ?? sidebarBorder,
      sidebarRing: Color.lerp(sidebarRing, other.sidebarRing, t) ?? sidebarRing,
    );
  }
}

// Helper extension to easily access custom theme properties
extension CustomTheme on ThemeData {
  CustomThemeExtension get custom => extension<CustomThemeExtension>()!;
}
