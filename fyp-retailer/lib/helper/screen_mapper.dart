import 'package:client_fyp/screens/record/record_screen.dart';

import '../screens/checkout/checkout_screen.dart';
import '../screens/inventory/inventory_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';

enum PageNavigator {
  inventory,
  checkout,
  record,
  unknown,
}

enum PageStatus {
  loginScreen,
  registerScreen,
  inventoryScreen,
  checkoutScreen,
  recordScreen,
}

final screenMapper = {
  PageStatus.loginScreen: const LoginScreen(),
  PageStatus.inventoryScreen: const InventoryScreen(),
  PageStatus.registerScreen: const RegisterScreen(),
  PageStatus.checkoutScreen: const CheckoutScreen(),
  PageStatus.recordScreen: const RecordScreen(),
};

final dropdownConvertor = {
  PageNavigator.inventory: PageStatus.inventoryScreen,
  PageNavigator.checkout: PageStatus.checkoutScreen,
  PageNavigator.record: PageStatus.recordScreen,
};

PageNavigator pageStatusToDropdown(PageStatus pageStatus) {
  return dropdownConvertor.keys.firstWhere(
      (key) => dropdownConvertor[key] == pageStatus,
      orElse: () => PageNavigator.unknown);
}

final dropdownStringConvertor = {
  PageNavigator.inventory: "Inventory",
  PageNavigator.checkout: "Checkout",
  PageNavigator.record: "Record",
  PageNavigator.unknown: "",
};
