import 'package:customer_fyp/dto/checkout_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/api/api_repository.dart';
import '../../repositories/user_preference/user_preference_repository.dart';
import 'api_event.dart';
import 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiRepository apiRepository;
  final UserPreferenceRepository userPreferenceRepository;

  ApiBloc({
    required this.apiRepository,
    required this.userPreferenceRepository,
  }) : super(const ApiState(
          login: LoginState(),
          register: BasicApiState(),
          cartState: CartState(),
          isPaymentLoading: false,
          checkingPaidState: CheckingPaidState(isLoading: false),
        )) {
    on<ApiRegisterEvent>(_registerEvent);
    on<ApiLoginEvent>(_loginEvent);
    on<ClearCartEvent>(_clearCartEvent);
    on<AddStockEvent>(_addStockEvent);
    on<AddItemEvent>(_addItemEvent);
    on<CreateCheckoutEvent>(_createCheckoutEvent);
    on<CheckTransaction>(_checkTransaction);
    on<ApiTopUpEvent>(_topUpEvent);
    on<PaymentEvent>(_paymentEvent);
  }

  _clearCartEvent(ClearCartEvent event, Emitter<ApiState> emit) async {
    emit(state.copyWith(cartState: const CartState()));
  }

  _registerEvent(ApiRegisterEvent event, Emitter<ApiState> emit) async {
    emit(state.copyWith(register: const BasicApiState(isLoading: true)));
    final response = await apiRepository.register(
      email: event.email,
      password: event.password,
    );
    if (response.error == null) {
      const registerState = BasicApiState(isLoading: false);
      emit(state.copyWith(register: registerState));
    } else {
      final registerState =
          BasicApiState(error: response.error, isLoading: false);
      emit(state.copyWith(register: registerState));
    }
  }

  _topUpEvent(ApiTopUpEvent event, Emitter<ApiState> emit) async {
    final response = await apiRepository.topUp(
      amount: event.amount,
    );
    if (response.error == null) {
      emit(state.copyWith(
          login: LoginState(
        user: response.result,
      )));
    } else {
      final registerState =
          BasicApiState(error: response.error, isLoading: false);
      emit(state.copyWith(register: registerState));
    }
  }

  _loginEvent(ApiLoginEvent event, Emitter<ApiState> emit) async {
    emit(state.copyWith(login: const LoginState(isLoading: true)));
    final response = await apiRepository.login(
      email: event.email,
      password: event.password,
    );
    if (response.error == null) {
      final loginState = LoginState(
        isLoading: false,
        user: response.result,
      );
      emit(state.copyWith(login: loginState));
    } else {
      final loginState = LoginState(error: response.error, isLoading: false);
      emit(state.copyWith(login: loginState));
    }
  }

  _createCheckoutEvent(
      CreateCheckoutEvent event, Emitter<ApiState> emit) async {
    final transactionItems = event.items
        .map((item) => {
              'price': item.price,
              'quantity': item.quantity,
              'name': item.name,
            })
        .toList();
    final CheckoutRequest checkoutRequest = CheckoutRequest(
        transactionId: event.id, transactionItems: transactionItems);

    await apiRepository.createCheckout(checkoutRequest: checkoutRequest);
  }

  _checkTransaction(CheckTransaction event, Emitter<ApiState> emit) async {
    emit(state.copyWith(
        checkingPaidState: const CheckingPaidState(
      isLoading: true,
    )));
    final transaction = await apiRepository.getTransaction(
      id: event.id,
      shopId: event.shopId,
    );
    emit(state.copyWith(
        checkingPaidState: CheckingPaidState(
      isLoading: false,
      transaction: transaction.result,
    )));
  }

  _addStockEvent(AddStockEvent event, Emitter<ApiState> emit) async {
    emit(state.copyWith(login: const LoginState(isLoading: true)));
    final response = await apiRepository.addStock(
      name: event.name,
      price: event.price,
    );
    if (response.error == null) {
      final loginState = LoginState(
        isLoading: false,
        user: response.result,
      );
      emit(state.copyWith(login: loginState));
    } else {
      final loginState = LoginState(error: response.error, isLoading: false);
      emit(state.copyWith(login: loginState));
    }
  }

  _addItemEvent(AddItemEvent event, Emitter<ApiState> emit) async {
    emit(state.copyWith(login: const LoginState(isLoading: true)));
    final response = await apiRepository.addItem(
      stockId: event.stockId,
      itemId: event.itemId,
    );
    if (response.error == null) {
      final loginState = LoginState(
        isLoading: false,
        user: response.result,
      );
      emit(state.copyWith(login: loginState));
    } else {
      final loginState = LoginState(error: response.error, isLoading: false);
      emit(state.copyWith(login: loginState));
    }
  }

  _paymentEvent(PaymentEvent event, Emitter<ApiState> emit) async {
    emit(state.copyWith(isPaymentLoading: true));
    final response = await apiRepository.payTransaction(
      customerId: event.customerId,
      shopId: event.shopId,
      transactionId: event.transactionId,
    );
    if (response.error == null) {
      final loginState = LoginState(
        isLoading: false,
        user: response.result,
      );
      emit(state.copyWith(
        login: loginState,
        isPaymentLoading: false,
      ));
    } else {
      final loginState = LoginState(error: response.error, isLoading: false);
      emit(state.copyWith(login: loginState));
    }
  }

  // _clearState(ApiClearState event, Emitter<ApiState> emit) {
  //   final initialState = ApiState(
  //     login: const LoginState(),
  //     otp: const BasicApiState(),
  //     register: const BasicApiState(),
  //     linkedInToken: const BasicApiState(),
  //     userCreate: const BasicApiState(),
  //     appConfig: const AppConfigState(),
  //     isAppInit: true,
  //     biometric: state.biometric,
  //     isAutoLogin: false,
  //     requestResetPassword: const BasicApiState(),
  //     updateProfile: const UpdateProfileState(),
  //     resetPassword: const BasicApiState(),
  //     deleteAccount: const BasicApiState(),
  //     updateInfo: const BasicApiState(),
  //     socialAccountState: const SocialAccountState(),
  //   );
  //   userPreferenceRepository.clearAll();
  //   apiRepository.clearHeaders();
  //   emit(initialState);
  // }
}
