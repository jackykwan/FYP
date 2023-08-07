import 'package:equatable/equatable.dart';

import '../../dto/user.dart';
import '../../repositories/api/models/backend_error.dart';

class LoginState extends Equatable {
  final User? user;
  final bool isLoading;
  final BackEndError? error;

  const LoginState({
    this.isLoading = false,
    this.error,
    this.user,
  });

  @override
  List<Object?> get props => [
        isLoading,
        error,
        user,
      ];
}

class CartState extends Equatable {
  final String? name;
  final double? price;
  final String? stockId;

  const CartState({
    this.name,
    this.price,
    this.stockId,
  });

  @override
  List<Object?> get props => [
        name,
        price,
        stockId,
      ];
}

class CheckingPaidState extends Equatable {
  final bool isPaid;
  final bool isTimeout;
  final bool isLoading;

  const CheckingPaidState({
    required this.isPaid,
    required this.isLoading,
    required this.isTimeout,
  });
  @override
  List<Object?> get props => [
        isPaid,
        isLoading,
        isTimeout,
      ];
}

class BasicApiState extends Equatable {
  final bool isLoading;
  final BackEndError? error;

  const BasicApiState({this.isLoading = false, this.error});

  @override
  List<Object?> get props => [isLoading, error];
}

class ApiState extends Equatable {
  final LoginState login;
  final BasicApiState register;
  final CartState cartState;
  final CheckingPaidState checkingPaidState;

  const ApiState({
    required this.login,
    required this.register,
    required this.cartState,
    required this.checkingPaidState,
  });

  @override
  List<Object?> get props => [
        login,
        register,
        cartState,
        checkingPaidState,
      ];

  ApiState copyWith({
    LoginState? login,
    BasicApiState? register,
    CheckingPaidState? checkingPaidState,
    CartState? cartState,
  }) {
    return ApiState(
      checkingPaidState: checkingPaidState ?? this.checkingPaidState,
      login: login ?? this.login,
      register: register ?? this.register,
      cartState: cartState ?? this.cartState,
    );
  }

  bool get isLoggedIn {
    return login.user?.token != null;
  }
}
