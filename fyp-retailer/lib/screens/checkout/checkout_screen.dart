import 'dart:convert';

import 'package:client_fyp/bloc/api/api_event.dart';
import 'package:client_fyp/helper/barcode_utils.dart';
import 'package:client_fyp/helper/responsive_sizer/responsive_sizer.dart';
import 'package:client_fyp/helper/user_utils.dart';
import 'package:client_fyp/screens/checkout/components/row_header.dart';
import 'package:client_fyp/screens/checkout/components/row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../bloc/api/api_bloc.dart';
import '../../bloc/api/api_state.dart';
import '../../components/header.dart';
import '../../view_models/checkout_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late String id;
  List<CheckoutItem> items = [];

  @override
  void initState() {
    id = const Uuid().v4().toString();
    super.initState();
  }

  void handleQuantityChange({required int count, required String id}) {
    setState(() {});
    final itemIndex =
        items.indexOf(items.firstWhere((element) => element.id == id));
    if (items[itemIndex].quantity == 1 && count == -1) {
      items.removeAt(itemIndex);
      return;
    }
    items[itemIndex].quantity += count;
  }

  void handleProductScan(String id, ApiState state) {
    final inventoryStock =
        UserUtils.getStockByStockId(user: state.login.user!, id: id);
    if (items.where((stock) => inventoryStock.id == stock.id).isNotEmpty) {
      for (int i = 0; i < items.length; i++) {
        if (items[i].id == inventoryStock.id) {
          items[i].quantity++;
        }
      }
    } else {
      items.add(
        CheckoutItem(
          name: inventoryStock.name!,
          id: inventoryStock.id!,
          price: inventoryStock.price!,
          quantity: 1,
        ),
      );
    }
    setState(() {});
  }

  void handleCheckout(ApiState state) async {
    if (items.isNotEmpty) {
      final Map<String, dynamic> data = {
        'transactionId': id,
        'shopId': state.login.user!.id,
      };
      context.read<ApiBloc>().add(CreateCheckoutEvent(items, id));
      context.read<ApiBloc>().add(CheckTransaction(id: id));
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: json.encode(data),
                ),
                ElevatedButton(
                  child: const Text("Back"),
                  onPressed: () {
                    ApiBloc.stopTransaction = true;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listenWhen: (previous, current) =>
          previous.checkingPaidState.isLoading &&
          !current.checkingPaidState.isLoading,
      listener: (context, state) {
        if (state.checkingPaidState.isPaid) {
          Navigator.pop(context);
          items = [];
          showDialog(
            context: context,
            builder: (_) {
              return const AlertDialog(title: Text("Payment Success"));
            },
          );
          id = const Uuid().v4().toString();
          context.read<ApiBloc>().add(const GetUserEvent());
        }
        if (state.checkingPaidState.isTimeout) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) {
              return const AlertDialog(
                  title: Text("Payment Failed, Please try again"));
            },
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            //Screen Header
            const Header(
              title: "Checkout",
            ),
            SizedBox(
              height: 8.responsiveH,
            ),
            // Total and confirm pay
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 32.responsiveW,
              ),
              child: InkWell(
                onTap: () {
                  handleCheckout(state);
                },
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (items.isEmpty) const Text("No items"),
                        if (items.isNotEmpty)
                          Text(
                            "Sales: \$${items.map((e) => e.price * e.quantity).reduce((value, element) => element + value)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.qr_code_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.responsiveH,
            ),
            const Divider(),
            // Items' title
            const RowHeader(),
            // Items
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final item in items)
                      RowItem(
                        checkoutItem: item,
                        quantityOnChange: (count, id) {
                          handleQuantityChange(count: count, id: id);
                        },
                      ),
                  ],
                ),
              ),
            ),
            // Scan Barcode
            ElevatedButton(
              onPressed: () async {
                final id = await BarcodeUtils.scanBarcodeNormal();
                handleProductScan(id, state);
              },
              child: const Text(
                "Scan Barcode",
              ),
            ),
          ],
        );
      },
    );
  }
}
