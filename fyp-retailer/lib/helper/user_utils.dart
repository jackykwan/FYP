import 'package:client_fyp/dto/stock.dart';
import 'package:client_fyp/dto/user.dart';

class UserUtils {
  static Stock getStockByStockId({required User user, required String id}) {
    return user.stocks!.where((stock) => stock.id == id).first;
  }
}
