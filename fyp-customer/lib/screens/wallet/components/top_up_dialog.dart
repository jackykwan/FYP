import 'package:customer_fyp/screens/wallet/components/num_pad.dart';
import 'package:flutter/material.dart';

class TopUpDialog extends StatefulWidget {
  const TopUpDialog({Key? key}) : super(key: key);

  @override
  State<TopUpDialog> createState() => _TopUpDialogState();
}

class _TopUpDialogState extends State<TopUpDialog> {
  String amountStr = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Amount: \$$amountStr",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            NumPad(
              onTap: (value) {
                if (value == 99) {
                  if (amountStr.isNotEmpty) {
                    amountStr = amountStr.substring(0, amountStr.length - 1);
                  }
                } else {
                  amountStr += "$value";
                }
                setState(() {});
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, double.parse(amountStr));
              },
              child: const Text("Top Up"),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
