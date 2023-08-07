import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction extends Equatable {
  final String id;
  final List<Map<String, dynamic>> transactionItems;
  final String date;
  final String? customerId;
  final String shopId;
  final bool isPaid;
  final String? shopName;

  const Transaction({
    this.customerId,
    required this.date,
    required this.id,
    required this.isPaid,
    required this.shopId,
    required this.transactionItems,
    this.shopName,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => [
        customerId,
        date,
        id,
        isPaid,
        shopId,
        transactionItems,
      ];
}
