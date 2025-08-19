import 'package:flutter/material.dart';
import 'package:ui/src/typography.dart';

/// Helper widget to display text with the App's typography.
///
/// https://docs.flutter.dev/ui/design/text/typography
/// https://m3.material.io/styles/typography/overview
/// https://api.flutter.dev/flutter/material/Typography-class.html
/// https://api.flutter.dev/flutter/widgets/Text-class.html
class AppText extends StatelessWidget {
  /// Display Large (57pt / w400)
  ///
  /// Used for the largest headers, such as main page titles or important focal points.
  ///
  /// There are three display styles in the default type scale: Large, medium, and small.
  /// As the largest text on the screen, display styles are reserved for short, important text or numerals.
  /// They work best on large screens.
  ///
  /// For display type, consider choosing a more expressive font, such as a handwritten or script style.
  ///
  /// If available, set the appropriate optical size to your usage.
  const AppText.displayLarge(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.displayLarge;

  /// Display Medium (45pt / w400)
  ///
  /// Used for medium-sized display texts, often for sections or highlighted text on large screens.
  ///
  /// There are three display styles in the default type scale: Large, medium, and small.
  /// As the largest text on the screen, display styles are reserved for short, important text or numerals.
  /// They work best on large screens.
  ///
  /// For display type, consider choosing a more expressive font, such as a handwritten or script style.
  ///
  /// If available, set the appropriate optical size to your usage.
  const AppText.displayMedium(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.displayMedium;

  /// Display Small (36pt / w400)
  ///
  /// Used for smaller display text, suitable for subtitles or less prominent headings.
  ///
  /// There are three display styles in the default type scale: Large, medium, and small.
  /// As the largest text on the screen, display styles are reserved for short, important text or numerals.
  /// They work best on large screens.
  ///
  /// For display type, consider choosing a more expressive font, such as a handwritten or script style.
  ///
  /// If available, set the appropriate optical size to your usage.
  const AppText.displaySmall(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.displaySmall;

  /// Headline Large (32pt / w400)
  ///
  /// Used for large headlines, typically for primary sections or important headings.
  ///
  /// Headlines are best-suited for short, high-emphasis text on smaller screens.
  /// These styles can be good for marking primary passages of text or important regions of content.
  ///
  /// Headlines can also make use of expressive typefaces,
  /// provided that appropriate line height and letter spacing is also integrated to maintain readability.
  const AppText.headlineLarge(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.headlineLarge;

  /// Headline Medium (28px / w400)
  ///
  /// Used for medium headlines, commonly for sub-sections or secondary importance text.
  ///
  /// Headlines are best-suited for short, high-emphasis text on smaller screens.
  /// These styles can be good for marking primary passages of text or important regions of content.
  ///
  /// Headlines can also make use of expressive typefaces,
  /// provided that appropriate line height and letter spacing is also integrated to maintain readability.
  const AppText.headlineMedium(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.headlineMedium;

  /// Headline Small (24px / w400)
  ///
  /// Used for small headlines, useful for tertiary sections or less important headings.
  ///
  /// Headlines are best-suited for short, high-emphasis text on smaller screens.
  /// These styles can be good for marking primary passages of text or important regions of content.
  ///
  /// Headlines can also make use of expressive typefaces,
  /// provided that appropriate line height and letter spacing is also integrated to maintain readability.
  const AppText.headlineSmall(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.headlineSmall;

  /// Title Large (22px / w400)
  ///
  /// Used for large titles, suitable for prominent section headers or card titles.
  ///
  /// Titles are smaller than headline styles, and should be used for medium-emphasis text that remains relatively short.
  /// For example, consider using title styles to divide secondary passages of text or secondary regions of content.
  ///
  /// For titles, use caution when using expressive fonts, including display, handwritten, and script styles.
  const AppText.titleLarge(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.titleLarge;

  /// Title Medium (16px / w500)
  ///
  /// Used for medium titles, suitable for subtitles or list item titles.
  ///
  /// Titles are smaller than headline styles, and should be used for medium-emphasis text that remains relatively short.
  /// For example, consider using title styles to divide secondary passages of text or secondary regions of content.
  ///
  /// For titles, use caution when using expressive fonts, including display, handwritten, and script styles.
  const AppText.titleMedium(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.titleMedium;

  /// Title Small (14px / w500)
  ///
  /// Used for small titles, appropriate for smaller section headers or minor headings.
  ///
  /// Titles are smaller than headline styles, and should be used for medium-emphasis text that remains relatively short.
  /// For example, consider using title styles to divide secondary passages of text or secondary regions of content.
  ///
  /// For titles, use caution when using expressive fonts, including display, handwritten, and script styles.
  const AppText.titleSmall(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.titleSmall;

  /// Body Large (16px / w400)
  ///
  /// Used for large body text, typically for paragraphs or descriptive text.
  ///
  /// Body styles are used for longer passages of text in your app.
  ///
  /// Use typefaces intended for body styles,
  /// which are readable at smaller sizes and can be comfortably read in longer passages.
  ///
  /// Avoid expressive or decorative fonts for body text because these can be harder to read at small sizes.
  const AppText.bodyLarge(
    this.text, {
    this.textAlign,
    this.softWrap,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    super.key,
  }) : style = AppTextStyles.bodyLarge;

  /// Body Medium (14px / w400)
  ///
  /// Used for medium body text, appropriate for smaller paragraphs or supporting text.
  ///
  /// Body styles are used for longer passages of text in your app.
  ///
  /// Use typefaces intended for body styles,
  /// which are readable at smaller sizes and can be comfortably read in longer passages.
  ///
  /// Avoid expressive or decorative fonts for body text because these can be harder to read at small sizes.
  const AppText.bodyMedium(
    this.text, {
    this.textAlign,
    this.softWrap,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    super.key,
  }) : style = AppTextStyles.bodyMedium;

  /// Body Small (12px / w400)
  ///
  /// Used for small body text, commonly for annotations, footnotes, or captions.
  ///
  /// Body styles are used for longer passages of text in your app.
  ///
  /// Use typefaces intended for body styles,
  /// which are readable at smaller sizes and can be comfortably read in longer passages.
  ///
  /// Avoid expressive or decorative fonts for body text because these can be harder to read at small sizes.
  const AppText.bodySmall(
    this.text, {
    this.textAlign,
    this.softWrap,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    super.key,
  }) : style = AppTextStyles.bodySmall;

  /// Label Large (14px / w700)
  ///
  /// Used for large labels, often for buttons or input fields.
  ///
  /// Label styles are smaller, utilitarian styles,
  /// used for things like the text inside components or for very small text in the content body,
  /// such as captions.
  ///
  /// Buttons, for example, use the label large style.
  const AppText.labelLarge(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.labelLarge;

  /// Label Medium (12px / w700)
  ///
  /// Used for medium labels, appropriate for captions or small button text.
  ///
  /// Label styles are smaller, utilitarian styles,
  /// used for things like the text inside components or for very small text in the content body,
  /// such as captions.
  ///
  /// Buttons, for example, use the label large style.
  const AppText.labelMedium(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.labelMedium;

  /// Label Small (11px / w500)
  ///
  /// Used for small labels, often for microcopy or input hints.
  ///
  /// Label styles are smaller, utilitarian styles,
  /// used for things like the text inside components or for very small text in the content body,
  /// such as captions.
  ///
  /// Buttons, for example, use the label large style.
  const AppText.labelSmall(
    this.text, {
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap,
    super.key,
  }) : style = AppTextStyles.labelSmall;

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String? text;

  /// The style to use for the text.
  final AppTextStyles style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// If this is null [TextStyle.overflow] will be used, otherwise the value
  /// from the nearest [DefaultTextStyle] ancestor will be used.
  final TextOverflow? overflow;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    var effectiveTextStyle = Theme.of(context).extension<AppTypography>()?[style];
    if (effectiveTextStyle == null || effectiveTextStyle.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(effectiveTextStyle);
    }
    if (maxLines == 1) {
      effectiveTextStyle = effectiveTextStyle.merge(const TextStyle(height: 1 /* kTextHeightNone */));
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    return RichText(
      textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      locale: Localizations.localeOf(context),
      softWrap: softWrap ?? defaultTextStyle.softWrap,
      overflow: overflow ?? effectiveTextStyle.overflow ?? defaultTextStyle.overflow,
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      textWidthBasis: defaultTextStyle.textWidthBasis,
      textHeightBehavior: defaultTextStyle.textHeightBehavior ?? DefaultTextHeightBehavior.maybeOf(context),
      selectionColor: DefaultSelectionStyle.of(context).selectionColor ?? DefaultSelectionStyle.defaultColor,
      text: TextSpan(style: effectiveTextStyle, text: text, children: null),
    );
  }
}
