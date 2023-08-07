class CheckoutItem {
  final String name;
  double price;
  int quantity;

  CheckoutItem({
    required this.name,
    this.price = -1,
    this.quantity = -1,
  });
}
