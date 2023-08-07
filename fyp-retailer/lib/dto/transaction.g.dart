// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      customerId: json['customerId'] as String?,
      date: json['date'] as String,
      id: json['id'] as String,
      isPaid: json['isPaid'] as bool,
      shopId: json['shopId'] as String,
      transactionItems: (json['transactionItems'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      shopName: json['shopName'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionItems': instance.transactionItems,
      'date': instance.date,
      'customerId': instance.customerId,
      'shopId': instance.shopId,
      'isPaid': instance.isPaid,
      'shopName': instance.shopName,
    };
