import 'package:customer_fyp/view_models/checkout_item.dart';
import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object?> get props => [];
}

class ClearCartEvent extends ApiEvent {
  const ClearCartEvent();

  @override
  List<Object?> get props => [];
}

class ApiLoginEvent extends ApiEvent {
  final String email;
  final String password;

  const ApiLoginEvent(
    this.email,
    this.password,
  );

  @override
  List<Object?> get props => [email, password];
}

class AddStockEvent extends ApiEvent {
  final String name;
  final double price;

  const AddStockEvent(
    this.name,
    this.price,
  );

  @override
  List<Object?> get props => [name, price];
}

class CheckTransaction extends ApiEvent {
  final String id;
  final String shopId;

  const CheckTransaction({
    required this.id,
    required this.shopId,
  });

  @override
  List<Object?> get props => [id, shopId];
}

class AddItemEvent extends ApiEvent {
  final String stockId;
  final String itemId;

  const AddItemEvent(
    this.stockId,
    this.itemId,
  );

  @override
  List<Object?> get props => [stockId, itemId];
}

class CreateCheckoutEvent extends ApiEvent {
  final List<CheckoutItem> items;
  final String id;

  const CreateCheckoutEvent(this.items, this.id);

  @override
  List<Object?> get props => [items, id];
}

class ApiRegisterEvent extends ApiEvent {
  final String email;
  final String password;

  const ApiRegisterEvent(
    this.email,
    this.password,
  );

  @override
  List<Object?> get props => [email, password];
}

class ApiTopUpEvent extends ApiEvent {
  final double amount;

  const ApiTopUpEvent(
    this.amount,
  );

  @override
  List<Object?> get props => [amount];
}

class PaymentEvent extends ApiEvent {
  final String shopId;
  final String transactionId;
  final String customerId;

  const PaymentEvent(
    this.shopId,
    this.transactionId,
    this.customerId,
  );

  @override
  List<Object?> get props => [
        shopId,
        transactionId,
        customerId,
      ];
}
