import 'package:customer_fyp/dto/stock.dart';
import 'package:customer_fyp/dto/user.dart';

class UserUtils {
  static Stock getStockByStockId({required User user, required String id}) {
    return user.stocks!.where((stock) => containItem(stock, id)).first;
  }

  static bool containItem(Stock stock, String id) {
    return stock.items!.where((element) => element.id == id).isNotEmpty;
  }
}
