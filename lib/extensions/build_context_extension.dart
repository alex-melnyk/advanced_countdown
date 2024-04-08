import 'package:flutter/widgets.dart';

/// A set of extensions for the [BuildContext] class.
extension BuildContextExtension on BuildContext {
  /// Measures the size of the given [text] with the [DefaultTextStyle]
  /// or given [textStyle].
  ///
  /// Returns the [Size] of the given [text].
  Size measureTextSize({required String text, TextStyle? textStyle}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle ?? DefaultTextStyle.of(this).style,
      ),
      textScaler: MediaQuery.of(this).textScaler,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.maxFinite);

    return textPainter.size;
  }
}
