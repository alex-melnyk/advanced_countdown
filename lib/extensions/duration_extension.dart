/// Duration extension.
extension DurationExtension on Duration {
  /// Creates a string representation of the [Duration] in next format
  /// MM:SS, so the value will be like "01:23'.
  /// - [withHours] parameter specifies whether to include hours in the output.
  /// - [withMilliseconds] parameter specifies whether to include milliseconds
  /// in the output.
  String format({
    bool withHours = false,
    bool withMilliseconds = false,
    int millisecondsDigits = 3,
  }) {
    assert(
      millisecondsDigits >= 1 && millisecondsDigits <= 3,
      'Invalid number of milliseconds digits',
    );

    return [
      [
        if (withHours) inHours.toString().padLeft(2, '0'),
        inMinutes.remainder(60).toString().padLeft(2, '0'),
        inSeconds.remainder(60).toString().padLeft(2, '0'),
      ].join(':'),
      if (withMilliseconds)
        inMilliseconds
            .remainder(1000)
            .toString()
            .padLeft(millisecondsDigits, '0')
            .substring(0, millisecondsDigits),
    ].join('.');
  }
}
