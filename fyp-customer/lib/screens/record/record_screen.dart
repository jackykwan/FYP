import 'package:customer_fyp/components/header.dart';
import 'package:customer_fyp/dto/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/api/api_bloc.dart';
import '../../bloc/api/api_state.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiBloc, ApiState>(
      builder: (context, state) {
        final transactions =
            state.login.user!.transactions?.reversed.toList() ?? [];
        return Column(
          children: [
            const Header(title: "Records"),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final transaction in transactions)
                      Column(
                        children: [
                          TransactionContainer(transaction: transaction),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Scaffold(
                body: Detail(
                  transaction: transaction,
                  transactionItems: transaction.transactionItems,
                ),
              );
            },
          );
        },
        child: Card(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Shop: ${transaction.shopName}"),
                const SizedBox(
                  height: 8,
                ),
                Text("Date: ${transaction.date}"),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    "Price: ${transaction.transactionItems.map((e) => e['quantity'] * e['price']).reduce((value, element) => value + element)}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({
    Key? key,
    required this.transaction,
    required this.transactionItems,
  }) : super(key: key);
  final List transactionItems;
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(
        12,
      ),
      child: Column(
        children: [
          Card(
            child: Container(
              width: double.infinity,
              color: Colors.amber[100],
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.shopName),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("Date: ${transaction.date}"),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                      "Price: ${transaction.transactionItems.map((e) => e['quantity'] * e['price']).reduce((value, element) => value + element)}"),
                ],
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final item in transactionItems)
                    Card(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Product name: ${item['name']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Quantity: ${item['quantity']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Unit Price: ${item['price']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Total: ${item['quantity'] * item['price']}"),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}
