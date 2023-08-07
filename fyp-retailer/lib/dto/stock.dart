import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item.dart';

part 'stock.g.dart';

@JsonSerializable()
class Stock extends Equatable {
  final String? name;
  final double? price;
  final int? quantity;
  final String? id;

  const Stock({
    this.name,
    this.price,
    this.quantity,
    this.id,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);

  @override
  List<Object?> get props => [
        name,
        price,
        id,
        quantity,
      ];
}
