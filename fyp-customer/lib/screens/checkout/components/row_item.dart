import 'package:customer_fyp/view_models/checkout_item.dart';
import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    Key? key,
    required this.quantityOnChange,
    required this.checkoutItem,
  }) : super(key: key);

  final Function(int, String) quantityOnChange;
  final CheckoutItem checkoutItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(checkoutItem.name)),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "HK \$${checkoutItem.price}",
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "HK \$${(checkoutItem.price * checkoutItem.quantity).toStringAsFixed(2)}",
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  checkoutItem.quantity.toString(),
                ),
                const SizedBox(
                  width: 8,
                ),

                // const SizedBox(
                //   width: 8,
                // ),
                // InkWell(
                //   onTap: () {
                //     quantityOnChange(
                //       1,
                //       checkoutItem.id,
                //     );
                //   },
                //   child: const Icon(
                //     Icons.add_outlined,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
