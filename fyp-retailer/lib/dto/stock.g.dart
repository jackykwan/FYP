// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) => Stock(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'id': instance.id,
    };
