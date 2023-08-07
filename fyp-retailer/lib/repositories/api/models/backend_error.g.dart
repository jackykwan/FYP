// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackEndError _$BackEndErrorFromJson(Map<String, dynamic> json) => BackEndError(
      status: json['status'] as int?,
      errorCode:
          $enumDecodeNullable(_$BackendErrorCodeEnumMap, json['errorCode']),
      type: json['type'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BackEndErrorToJson(BackEndError instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorCode': _$BackendErrorCodeEnumMap[instance.errorCode],
      'type': instance.type,
      'message': instance.message,
    };

const _$BackendErrorCodeEnumMap = {
  BackendErrorCode.loginFailed: 'ERR_LOGIN_FAILED',
  BackendErrorCode.unknown: 'unknown',
};
