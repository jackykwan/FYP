import 'package:json_annotation/json_annotation.dart';

part 'backend_error.g.dart';

@JsonSerializable()
class BackEndError {
  int? status;
  BackendErrorCode? errorCode;
  String? type;
  String? message;

  BackEndError({this.status, this.errorCode, this.type, this.message});

  factory BackEndError.fromJson(Map<String, dynamic> json) =>
      _$BackEndErrorFromJson(json);

  Map<String, dynamic> toJson() => _$BackEndErrorToJson(this);
}

enum BackendErrorCode {
  @JsonValue('ERR_LOGIN_FAILED')
  loginFailed,
  unknown
}
