// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) => Stock(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'items': instance.items,
      'id': instance.id,
    };
