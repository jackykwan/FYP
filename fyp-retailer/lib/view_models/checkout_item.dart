class CheckoutItem {
  final String name;
  double price;
  int quantity;
  final String id;

  CheckoutItem({
    required this.name,
    this.price = -1,
    this.quantity = -1,
    required this.id,
  });
}
