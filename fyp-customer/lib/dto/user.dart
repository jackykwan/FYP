import 'package:customer_fyp/dto/stock.dart';
import 'package:customer_fyp/dto/transaction.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String? token;
  final String? email;
  final String? shopName;
  final List<Stock>? stocks;
  final String? id;
  final double? walletAmount;
  final List<Transaction>? transactions;

  const User({
    this.email,
    this.shopName,
    this.token,
    this.stocks,
    this.id,
    this.walletAmount,
    this.transactions,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        token,
        email,
        shopName,
        stocks,
        id,
        walletAmount,
        transactions,
      ];
}
