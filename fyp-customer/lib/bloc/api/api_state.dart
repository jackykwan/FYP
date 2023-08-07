import 'package:customer_fyp/dto/transaction.dart';
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
  final bool isLoading;
  final Transaction? transaction;

  const CheckingPaidState({
    required this.isLoading,
    this.transaction,
  });
  @override
  List<Object?> get props => [
        isLoading,
        transaction,
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
  final bool isPaymentLoading;

  const ApiState({
    required this.login,
    required this.register,
    required this.cartState,
    required this.checkingPaidState,
    required this.isPaymentLoading,
  });

  @override
  List<Object?> get props => [
        login,
        register,
        cartState,
        checkingPaidState,
        isPaymentLoading,
      ];

  ApiState copyWith({
    LoginState? login,
    BasicApiState? register,
    CheckingPaidState? checkingPaidState,
    bool? isPaymentLoading,
    CartState? cartState,
  }) {
    return ApiState(
      checkingPaidState: checkingPaidState ?? this.checkingPaidState,
      login: login ?? this.login,
      register: register ?? this.register,
      cartState: cartState ?? this.cartState,
      isPaymentLoading: isPaymentLoading ?? this.isPaymentLoading,
    );
  }

  bool get isLoggedIn {
    return login.user?.token != null;
  }
}
