import 'package:client_fyp/helper/responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  const BasicCard({
    super.key,
    this.padding,
    this.elevation,
    required this.child,
  });

  final EdgeInsets? padding;
  final double? elevation;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: elevation ?? 3,
      child: Container(
        padding: padding ??
            EdgeInsets.all(
              16.responsiveW,
            ),
        child: child,
      ),
    );
  }
}
