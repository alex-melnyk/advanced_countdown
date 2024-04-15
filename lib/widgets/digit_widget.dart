import 'package:flutter/widgets.dart';

/// The single digit widget.
class DigitWidget extends StatelessWidget {
  const DigitWidget({
    super.key,
    required this.height,
    required this.value,
    required this.style,
  });

  /// The value of the digit.
  final String value;

  /// The height of the widget.
  final double height;

  /// The style of the digit.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Text(
        value,
        style: style,
      ),
    );
  }
}
