import 'package:client_fyp/dto/stock.dart';
import 'package:client_fyp/screens/inventory/components/add_stock_dialog.dart';
import 'package:client_fyp/screens/inventory/components/update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/api/api_bloc.dart';
import '../../bloc/api/api_state.dart';
import '../../components/header.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiBloc, ApiState>(
      builder: (context, state) {
        final stocks = state.login.user?.stocks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            const Header(
              title: "Inventories",
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: ((_) => Column(
                          children: [
                            AddStockDialog(
                              apiBloc: BlocProvider.of<ApiBloc>(context),
                            ),
                          ],
                        )),
                  ),
                  icon: const Icon(
                    Icons.add_outlined,
                  ),
                ),
              ],
            ),
            if (stocks == null) const CircularProgressIndicator(),
            if (stocks != null)
              for (final stock in stocks) ItemRow(stock: stock),
          ],
        );
      },
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.stock,
  });
  final Stock stock;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stock.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text("\$ ${stock.price}"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("${stock.quantity ?? 0}x"),
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () async {
                      // final itemId = await BarcodeUtils.scanBarcodeNormal();
                      // ignore: use_build_context_synchronously
                      // context
                      //     .read<ApiBloc>()
                      //     .add(AddItemEvent(stock.id!, itemId));
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: ((_) => Column(
                              children: [
                                UpdateDialog(
                                  apiBloc: BlocProvider.of<ApiBloc>(context),
                                  stock: stock,
                                ),
                              ],
                            )),
                      );
                    },
                    child: const Icon(
                      Icons.edit_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
