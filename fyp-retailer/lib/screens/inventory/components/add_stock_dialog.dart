import 'package:client_fyp/bloc/api/api_bloc.dart';
import 'package:client_fyp/bloc/api/api_event.dart';
import 'package:client_fyp/helper/barcode_utils.dart';
import 'package:client_fyp/helper/responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

class AddStockDialog extends StatefulWidget {
  const AddStockDialog({
    super.key,
    required this.apiBloc,
  });

  final ApiBloc apiBloc;

  @override
  State<AddStockDialog> createState() => _AddStockDialogState();
}

class _AddStockDialogState extends State<AddStockDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String id = "";

  void _handleSave() {
    if (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        id.isNotEmpty &&
        quantityController.text.isNotEmpty) {
      widget.apiBloc.add(AddStockEvent(
        nameController.text,
        double.parse(priceController.text),
        id,
        int.parse(quantityController.text),
      ));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(
          16.responsiveW,
        ),
        alignment: Alignment.center,
        width: 800.responsiveW,
        height: 400.responsiveH,
        child: Column(
          children: [
            ItemRow(controller: nameController, name: 'Product Name'),
            ItemRow(controller: priceController, name: 'Price'),
            ItemRow(controller: quantityController, name: 'Quantity'),
            ElevatedButton(
              onPressed: () async {
                final code = await BarcodeUtils.scanBarcodeNormal();
                if (code.isNotEmpty) {
                  id = code;
                }
              },
              child: const Text("Scan Barcode"),
            ),
            SizedBox(
              height: 32.responsiveH,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _handleSave,
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.controller,
    required this.name,
  });
  final TextEditingController controller;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.responsiveW,
        vertical: 8.responsiveH,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            name,
          ),
          SizedBox(
            width: 16.responsiveW,
          ),
          Expanded(
            child: TextField(
              keyboardType: name != "Product Name"
                  ? name == "Price"
                      ? const TextInputType.numberWithOptions(
                          decimal: true, signed: false)
                      : TextInputType.number
                  : null,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
