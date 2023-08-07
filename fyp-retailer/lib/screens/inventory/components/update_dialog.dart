import 'package:client_fyp/bloc/api/api_bloc.dart';
import 'package:client_fyp/bloc/api/api_event.dart';
import 'package:client_fyp/dto/stock.dart';
import 'package:client_fyp/helper/responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

class UpdateDialog extends StatefulWidget {
  const UpdateDialog({
    super.key,
    required this.apiBloc,
    required this.stock,
  });
  final Stock stock;
  final ApiBloc apiBloc;

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  late final TextEditingController nameController =
      TextEditingController(text: widget.stock.name!);
  late final TextEditingController priceController =
      TextEditingController(text: widget.stock.price!.toString());
  late final TextEditingController quantityController =
      TextEditingController(text: widget.stock.quantity!.toString());

  void _handleSave() {
    if (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        quantityController.text.isNotEmpty) {
      widget.apiBloc.add(AddStockEvent(
        nameController.text,
        double.parse(priceController.text),
        widget.stock.id!,
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
