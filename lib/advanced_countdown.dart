import 'package:advanced_countdown/beans/beans.dart';
import 'package:advanced_countdown/extensions/extensions.dart';
import 'package:flutter/material.dart';

export 'beans/beans.dart';

/// The default scale next digit tween.
final defaultScaleNextTween = Tween<double>(
  begin: 0.5,
  end: 1.0,
);

/// The default scale prev digit tween.
final defaultScalePrevTween = Tween<double>(
  begin: 0.5,
  end: 1.0,
);

/// The default slide next digit tween.
final defaultSlideNextTween = Tween<Offset>(
  begin: const Offset(0, -0.75),
  end: Offset.zero,
);

/// The default slide prev digit tween.
final defaultSlidePrevTween = Tween<Offset>(
  begin: const Offset(0, 0.75),
  end: Offset.zero,
);

/// The default animation duration.
const defaultAnimationDuration = Duration(milliseconds: 250);

/// The default milliseconds animation duration.
const defaultMillisecondsAnimationDuration = Duration(milliseconds: 100);

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

    return ClipRect(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final digit in hhmmss.characters)
            if (digit == ':')
              Container(
                height: digitSize.height,
                alignment: Alignment.center,
                child: Text(
                  digit,
                  style: normalizedTextStyle,
                ),
              )
            else
              AnimatedSwitcher(
                reverseDuration: widget.animationDuration,
                duration: widget.animationDuration,
                transitionBuilder: (child, animation) {
                  if (widget.transitionBuilder != null) {
                    return widget.transitionBuilder!.call(child, animation);
                  }

                  final digitValue = (child.key as ValueKey).value.toString();
                  final forward = widget.value >= previousValue
                      ? digitValue == digit
                      : digitValue != digit;

                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: forward
                          ? defaultScaleNextTween.animate(animation)
                          : defaultScalePrevTween.animate(animation),
                      child: SlideTransition(
                        position: forward
                            ? defaultSlideNextTween.animate(animation)
                            : defaultSlidePrevTween.animate(animation),
                        child: child,
                      ),
                    ),
                  );
                },
                child: Container(
                  key: ValueKey(digit),
                  width: digitSize.width,
                  height: digitSize.height,
                  alignment: Alignment.center,
                  child: Text(
                    digit,
                    style: normalizedTextStyle,
                  ),
                ),
              ),
          if (hasMilliseconds)
            Container(
              height: digitSize.height,
              alignment: Alignment.center,
              child: Text(
                '.',
                style: normalizedTextStyle,
              ),
            ),
          if (hasMilliseconds)
            for (final digit in millis.characters)
              AnimatedSwitcher(
                reverseDuration: widget.animationMillisecondsDuration,
                duration: widget.animationMillisecondsDuration,
                transitionBuilder: (child, animation) {
                  if (widget.transitionBuilder != null) {
                    return widget.transitionBuilder!.call(child, animation);
                  }

                  final digitValue = (child.key as ValueKey).value.toString();
                  final forward = widget.value >= previousValue
                      ? digitValue == digit
                      : digitValue != digit;

                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: forward
                          ? defaultScaleNextTween.animate(animation)
                          : defaultScalePrevTween.animate(animation),
                      child: SlideTransition(
                        position: forward
                            ? defaultSlideNextTween.animate(animation)
                            : defaultSlidePrevTween.animate(animation),
                        child: child,
                      ),
                    ),
                  );
                },
                child: Container(
                  key: ValueKey(digit),
                  width: digitSize.width,
                  height: digitSize.height,
                  alignment: Alignment.center,
                  child: Text(
                    digit,
                    style: normalizedTextStyle,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
