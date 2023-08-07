import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({
    super.key,
    this.onTap,
  });

  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => onTap,
    );
  }
}
