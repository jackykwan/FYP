part of responsive;

extension ResponsiveExt on num {
  /// Calculates the height depending on the device's width size
  double get responsiveW => this * ResponsiveUtil.widthRatio;
  double get responsiveH => this * ResponsiveUtil.heightRatio;
}
