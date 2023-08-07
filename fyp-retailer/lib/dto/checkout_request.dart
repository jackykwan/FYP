import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checkout_request.g.dart';

@JsonSerializable()
class CheckoutRequest extends Equatable {
  final String transactionId;
  final List<Map<String, dynamic>> transactionItems;

  const CheckoutRequest({
    required this.transactionId,
    required this.transactionItems,
  });

  factory CheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRequestToJson(this);

  @override
  List<Object?> get props => [
        transactionId,
        transactionItems,
      ];
}
