// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutRequest _$CheckoutRequestFromJson(Map<String, dynamic> json) =>
    CheckoutRequest(
      transactionId: json['transactionId'] as String,
      transactionItems: (json['transactionItems'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$CheckoutRequestToJson(CheckoutRequest instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'transactionItems': instance.transactionItems,
    };
