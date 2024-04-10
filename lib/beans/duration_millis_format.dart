/// An enum for duration milliseconds format.
enum DurationMillisFormat {
  /// Single digit.
  single,

  /// Double digit.
  double,

  /// Triple digit.
  triple;

  /// The number of digits.
  int get digits {
    switch (this) {
      case DurationMillisFormat.single:
        return 1;
      case DurationMillisFormat.double:
        return 2;
      case DurationMillisFormat.triple:
        return 3;
    }
  }
}
