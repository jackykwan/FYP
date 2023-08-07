part of responsive;

const _iphone13ProWidth = 390;
const _iphone13ProHeight = 844;

class ResponsiveUtil {
  /// Device's BoxConstraints
  static late BoxConstraints _boxConstraints;

  /// Device's Orientation
  static Orientation orientation = Orientation.portrait;

  /// Device's Height
  static double height = _iphone13ProHeight.toDouble();

  /// Device's Width
  static double width = _iphone13ProWidth.toDouble();

  /// The width ratio of current device to iPhone13 pro
  static double widthRatio = 1;

  /// The height ratio of current device to iPhone13 pro
  static double heightRatio = 1;

  /// Sets the Screen's size and Device's Orientation,
  /// BoxConstraints, Height, and Width
  static void setScreenSize(
      BoxConstraints constraints, Orientation currentOrientation) {
    // Sets boxconstraints and orientation
    _boxConstraints = constraints;
    orientation = currentOrientation;

    // Sets screen width and height
    if (orientation == Orientation.portrait) {
      width = _boxConstraints.maxWidth;
      height = _boxConstraints.maxHeight;
    } else {
      width = _boxConstraints.maxHeight;
      height = _boxConstraints.maxWidth;
    }

    widthRatio = _boxConstraints.maxWidth / _iphone13ProWidth;
    heightRatio = _boxConstraints.maxHeight / _iphone13ProHeight;
  }
}
