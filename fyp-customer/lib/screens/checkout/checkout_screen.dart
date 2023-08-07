import 'package:customer_fyp/bloc/page_status/page_status_bloc.dart';
import 'package:customer_fyp/components/header.dart';
import 'package:customer_fyp/helper/screen_mapper.dart';
import 'package:customer_fyp/helper/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/api/api_bloc.dart';
import '../../bloc/api/api_event.dart';
import '../../bloc/api/api_state.dart';
import '../../view_models/checkout_item.dart';
import 'components/row_header.dart';
import 'components/row_item.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listenWhen: (previous, current) =>
          previous.isPaymentLoading && !current.isPaymentLoading,
      listener: (context, state) {
        Navigator.pop(context);
        context
            .read<PageStatusBloc>()
            .add(const PageStatusEvent(PageStatus.recordScreen));
      },
      builder: (context, state) {
        final transaction = state.checkingPaidState.transaction!;
        final items = transaction.transactionItems
            .map((e) => CheckoutItem(
                  name: e["name"],
                  price: e["price"],
                  quantity: e["quantity"],
                ))
            .toList();
        final walletAmount = state.login.user!.walletAmount!;
        final total = items
            .map((e) => e.price * e.quantity)
            .reduce((value, element) => element + value);
        return Column(
          children: [
            const Header(title: "Checkout"),
            const SizedBox(
              height: 16,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(),
                  // Items' title
                  const RowHeader(),
                  for (final item in items)
                    RowItem(
                      checkoutItem: item,
                      quantityOnChange: (count, id) {},
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(),
                  Text(
                    "Wallet: \$$walletAmount",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Total: \$$total",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  Text(
                    "Remaining: \$${(walletAmount - total)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (walletAmount > total) {
                        BlocProvider.of<ApiBloc>(context).add(PaymentEvent(
                          transaction.shopId,
                          transaction.id,
                          state.login.user!.id!,
                        ));
                        showLoading(context);
                      }
                    },
                    child: const Text("Pay"),
                  ),

                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<PageStatusBloc>(context).add(
                        const PageStatusEvent(PageStatus.walletScreen),
                      );
                    },
                    child: const Text("Back"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
