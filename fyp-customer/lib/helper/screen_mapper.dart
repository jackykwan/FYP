import 'package:customer_fyp/screens/checkout/checkout_screen.dart';
import 'package:customer_fyp/screens/record/record_screen.dart';
import 'package:customer_fyp/screens/wallet/wallet_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';

enum PageNavigator {
  wallet,
  record,
  unknown,
}

enum PageStatus {
  loginScreen,
  registerScreen,
  walletScreen,
  checkoutScreen,
  recordScreen,
}

final screenMapper = {
  PageStatus.loginScreen: const LoginScreen(),
  PageStatus.walletScreen: const WalletScreen(),
  PageStatus.registerScreen: const RegisterScreen(),
  PageStatus.checkoutScreen: const CheckoutScreen(),
  PageStatus.recordScreen: const RecordScreen(),
};

final dropdownConvertor = {
  PageNavigator.wallet: PageStatus.walletScreen,
  PageNavigator.record: PageStatus.recordScreen,
};

PageNavigator pageStatusToDropdown(PageStatus pageStatus) {
  return dropdownConvertor.keys.firstWhere(
      (key) => dropdownConvertor[key] == pageStatus,
      orElse: () => PageNavigator.unknown);
}

final dropdownStringConvertor = {
  PageNavigator.wallet: "Wallet",
  PageNavigator.record: "Record",
  PageNavigator.unknown: "",
};
