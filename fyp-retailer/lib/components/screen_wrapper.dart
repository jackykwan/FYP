import '../components/drop_down_navigation.dart';
import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({
    super.key,
    required this.child,
    required this.name,
  });
  final Widget child;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (name != "") const DropdownNavigation(),
        child,
      ],
    );
  }
}
