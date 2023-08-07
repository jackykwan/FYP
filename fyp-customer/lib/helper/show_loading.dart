import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
}
