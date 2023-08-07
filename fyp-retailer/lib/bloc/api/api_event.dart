import 'package:client_fyp/view_models/checkout_item.dart';
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
  final String id;
  final int quantity;

  const AddStockEvent(
    this.name,
    this.price,
    this.id,
    this.quantity,
  );

  @override
  List<Object?> get props => [
        name,
        price,
        id,
        quantity,
      ];
}

class CheckTransaction extends ApiEvent {
  final String id;

  const CheckTransaction({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetUserEvent extends ApiEvent {
  const GetUserEvent();

  @override
  List<Object?> get props => [];
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
  final String shopName;

  const ApiRegisterEvent(
    this.email,
    this.password,
    this.shopName,
  );

  @override
  List<Object?> get props => [email, password];
}
