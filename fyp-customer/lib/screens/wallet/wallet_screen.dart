import 'dart:convert';

import 'package:customer_fyp/components/header.dart';
import 'package:customer_fyp/helper/barcode_utils.dart';
import 'package:customer_fyp/helper/show_loading.dart';
import 'package:customer_fyp/screens/wallet/components/top_up_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/api/api_bloc.dart';
import '../../bloc/api/api_event.dart';
import '../../bloc/api/api_state.dart';
import '../../bloc/page_status/page_status_bloc.dart';
import '../../helper/screen_mapper.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  void onPayPressed() async {
    final paymentDetails = await BarcodeUtils.scanBarcodeNormal();
    final Map paymentJson = json.decode(paymentDetails);
    // ignore: use_build_context_synchronously
    showLoading(context);
    // ignore: use_build_context_synchronously
    BlocProvider.of<ApiBloc>(context).add(CheckTransaction(
        id: paymentJson['transactionId']!, shopId: paymentJson['shopId']));
  }

  void onTopUpPressed() async {
    final value = await showDialog(
      context: context,
      builder: (context) {
        return const TopUpDialog();
      },
    );
    // ignore: use_build_context_synchronously
    BlocProvider.of<ApiBloc>(context).add(ApiTopUpEvent(value.toDouble()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listenWhen: (previous, current) =>
          previous.checkingPaidState.isLoading &&
          !current.checkingPaidState.isLoading,
      listener: (context, state) {
        Navigator.pop(context);
        BlocProvider.of<PageStatusBloc>(context)
            .add(const PageStatusEvent(PageStatus.checkoutScreen));
      },
      builder: (context, state) {
        final user = state.login.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(
              title: "My Wallet",
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Wallet Remaining: \$${user!.walletAmount!}",
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "You can top up your account or pay for the order",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Username: ${user.email}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "User ID:\n${user.id}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: onPayPressed,
              child: const Text(
                "Pay",
              ),
            ),
            ElevatedButton(
              onPressed: onTopUpPressed,
              child: const Text(
                "Top Up",
              ),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}
