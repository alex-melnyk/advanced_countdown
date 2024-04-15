import 'package:flutter/widgets.dart';

/// The default scale prev digit tween.
final defaultScalePrevTween = Tween<double>(
  begin: 0.5,
  end: 1.0,
);

/// The default scale next digit tween.
final defaultScaleNextTween = Tween<double>(
  begin: 0.5,
  end: 1.0,
);

/// The default slide prev digit tween.
final defaultSlidePrevTween = Tween<Offset>(
  begin: const Offset(0, 0.75),
  end: Offset.zero,
);

/// The default slide next digit tween.
final defaultSlideNextTween = Tween<Offset>(
  begin: const Offset(0, -0.75),
  end: Offset.zero,
);

/// The default animation duration.
const defaultAnimationDuration = Duration(milliseconds: 250);

/// The default milliseconds animation duration.
const defaultMillisecondsAnimationDuration = Duration(milliseconds: 100);

/// The double dot text.
const digitDoubleDot = ':';

/// The single dot text.
const digitSingleDot = '.';