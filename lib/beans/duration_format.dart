/// An enum for duration format.
enum DurationFormat {
  /// Single digit.
  single,

  /// Double digit.
  double;

  /// The number of digits.
  int get digits {
    switch (this) {
      case DurationFormat.single:
        return 1;
      case DurationFormat.double:
        return 2;
    }
  }
}
