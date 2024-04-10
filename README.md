# advanced_countdown

An advanced countdown widget that displays time with digit animation.

![PREVIEW.gif](PREVIEW.gif)

## AdvancedCountdown Parameters
| Parameter                       | Description                           | Type                                 | Required | Default                              |
|:--------------------------------|:--------------------------------------|:-------------------------------------|:---------|:-------------------------------------|
| `value`                         | The value to display                  | *Duration*                           | false    | Duration.zero                        |
| `animationDuration`             | The animation duration for HH, MM, SS | *Duration*                           | false    | defaultAnimationDuration             |
| `animationMillisecondsDuration` | The animation duration for MS         | *Duration*                           | false    | defaultMillisecondsAnimationDuration |
| `transitionBuilder`             | Digits transition builder             | *AnimatedSwitcherTransitionBuilder?* | false    | (default transition)                 |
| `style`                         | Text style                            | *TextStyle?*                         | false    | DefaultTextStyle.of(context).style   |
| `displayHours`                  | Whether to display hours              | *bool*                               | false    | false                                |
| `displayMilliseconds`           | Whether to display milliseconds       | *bool*                               | false    | false                                |
| `hoursFormat`                   | The value to display                  | *DurationFormat*                     | false    | DurationMillisFormat.single          |
| `minutesFormat`                 | The value to display                  | *DurationFormat*                     | false    | DurationMillisFormat.single          |
| `secondsFormat`                 | The value to display                  | *DurationFormat*                     | false    | DurationMillisFormat.double          |
| `millisecondsFormat`            | The value to display                  | *DurationMillisFormat*               | false    | DurationMillisFormat.single          |


