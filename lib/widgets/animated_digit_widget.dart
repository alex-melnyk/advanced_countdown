import 'package:flutter/widgets.dart';

/// The animated digit widget.
class AnimatedDigitWidget extends StatelessWidget {
  const AnimatedDigitWidget({
    super.key,
    required this.value,
    this.style,
    required this.animationDirection,
    required this.animationDuration,
    this.transitionBuilder,
    required this.size,
    required this.scalePrevTween,
    required this.scaleNextTween,
    required this.slidePrevTween,
    required this.slideNextTween,
  });

  /// The value of the digit.
  final String value;

  /// The TextStyle of the digit.
  final TextStyle? style;

  /// The direction of the animation when forward when "true",
  /// otherwise backward.
  final bool animationDirection;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The transition builder for prev and next digits.
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  /// The size of the widget.
  final Size size;

  /// The tween for the previous scale.
  final Tween<double> scalePrevTween;

  /// The tween for the next scale.
  final Tween<double> scaleNextTween;

  /// The tween for the previous slide.
  final Tween<Offset> slidePrevTween;

  /// The tween for the next slide.
  final Tween<Offset> slideNextTween;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      reverseDuration: animationDuration,
      duration: animationDuration,
      transitionBuilder: (child, animation) {
        if (transitionBuilder != null) {
          return transitionBuilder!.call(child, animation);
        }

        final digitValue = (child.key as ValueKey).value.toString();
        final forward = animationDirection
            ? digitValue == value
            : digitValue != value;

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: forward
                ? scaleNextTween.animate(animation)
                : scalePrevTween.animate(animation),
            child: SlideTransition(
              position: forward
                  ? slideNextTween.animate(animation)
                  : slidePrevTween.animate(animation),
              child: child,
            ),
          ),
        );
      },
      child: Container(
        key: ValueKey(value),
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Text(
          value,
          style: style,
        ),
      ),
    );
  }
}
