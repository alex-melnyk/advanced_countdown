import 'package:advanced_countdown/beans/beans.dart';
import 'package:advanced_countdown/constants.dart';
import 'package:advanced_countdown/extensions/extensions.dart';
import 'package:advanced_countdown/widgets/widgets.dart';
import 'package:flutter/material.dart';

export 'beans/beans.dart';

/// Advanced countdown widget.
class AdvancedCountdown extends StatefulWidget {
  const AdvancedCountdown({
    super.key,
    this.value = Duration.zero,
    this.animationDuration = defaultAnimationDuration,
    this.animationMillisecondsDuration = defaultMillisecondsAnimationDuration,
    this.transitionBuilder,
    this.style,
    this.displayHours = false,
    this.displayMilliseconds = false,
    this.hoursFormat = DurationFormat.single,
    this.minutesFormat = DurationFormat.single,
    this.secondsFormat = DurationFormat.double,
    this.millisecondsFormat = DurationMillisFormat.single,
  });

  /// The value of the countdown.
  final Duration value;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The duration of the animation.
  final Duration animationMillisecondsDuration;

  /// The transition builder for prev and next digits.
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  /// The style of the countdown.
  final TextStyle? style;

  /// Whether to display hours.
  final bool displayHours;

  /// Whether to display milliseconds.
  final bool displayMilliseconds;

  /// The length of the hours digits.
  final DurationFormat hoursFormat;

  /// The length of the minutes digits.
  final DurationFormat minutesFormat;

  /// The length of the seconds digits.
  final DurationFormat secondsFormat;

  /// The length of the milliseconds digits.
  final DurationMillisFormat millisecondsFormat;

  @override
  State<AdvancedCountdown> createState() => _AdvancedCountdownState();
}

class _AdvancedCountdownState extends State<AdvancedCountdown> {
  Duration previousValue = Duration.zero;

  @override
  void didUpdateWidget(covariant AdvancedCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    previousValue = oldWidget.value;
  }

  @override
  Widget build(BuildContext context) {
    final normalizedTextStyle =
        widget.style ?? DefaultTextStyle.of(context).style;
    final digitSize = context.measureTextSize(
      text: '0',
      textStyle: normalizedTextStyle,
    );

    final formattedDuration = widget.value.format(
      withHours: widget.displayHours,
      withMilliseconds: widget.displayMilliseconds,
      hoursDigits: widget.hoursFormat.digits,
      minutesDigits: widget.minutesFormat.digits,
      secondsDigits: widget.secondsFormat.digits,
      millisecondsDigits: widget.millisecondsFormat.digits,
    );

    final timeSections = formattedDuration.split('.');
    final hhmmss = timeSections.first;
    final millis = timeSections.last;
    final hasMilliseconds = timeSections.length > 1;
    final animationForward = widget.value >= previousValue;

    return ClipRect(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final digit in hhmmss.characters)
            if (digit == digitDoubleDot)
              DigitWidget(
                height: digitSize.height,
                value: digit,
                style: normalizedTextStyle,
              )
            else
              AnimatedDigitWidget(
                value: digit,
                style: normalizedTextStyle,
                animationDirection: animationForward,
                size: digitSize,
                animationDuration: widget.animationDuration,
                transitionBuilder: widget.transitionBuilder,
                scalePrevTween: defaultScalePrevTween,
                scaleNextTween: defaultScaleNextTween,
                slidePrevTween: defaultSlidePrevTween,
                slideNextTween: defaultSlideNextTween,
              ),
          if (hasMilliseconds) ...[
            DigitWidget(
              height: digitSize.height,
              value: digitSingleDot,
              style: normalizedTextStyle,
            ),
            for (final digit in millis.characters)
              AnimatedDigitWidget(
                value: digit,
                style: normalizedTextStyle,
                animationDirection: animationForward,
                size: digitSize,
                animationDuration: widget.animationMillisecondsDuration,
                transitionBuilder: widget.transitionBuilder,
                scalePrevTween: defaultScalePrevTween,
                scaleNextTween: defaultScaleNextTween,
                slidePrevTween: defaultSlidePrevTween,
                slideNextTween: defaultSlideNextTween,
              ),
          ],
        ],
      ),
    );
  }
}
