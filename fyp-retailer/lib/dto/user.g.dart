// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String?,
      shopName: json['shopName'] as String?,
      token: json['token'] as String?,
      stocks: (json['stocks'] as List<dynamic>?)
          ?.map((e) => Stock.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      walletAmount: (json['walletAmount'] as num?)?.toDouble(),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'token': instance.token,
      'email': instance.email,
      'shopName': instance.shopName,
      'stocks': instance.stocks,
      'id': instance.id,
      'walletAmount': instance.walletAmount,
      'transactions': instance.transactions,
    };
