import 'package:flutter/material.dart';

class RowHeader extends StatelessWidget {
  const RowHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(child: Text("Product")),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: const Text(
                "Unit Price",
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: const Text(
                "Total",
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
