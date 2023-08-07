import 'backend_error.dart';

class ApiResponse<T> {
  final T? result;
  final BackEndError? error;

  const ApiResponse({this.result, this.error});
}
