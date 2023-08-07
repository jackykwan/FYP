import 'package:customer_fyp/dto/item.dart';
import 'package:customer_fyp/dto/stock.dart';

final dummyItems = [
  const Item(id: "123"),
  const Item(id: "12312342"),
  const Item(id: "1234"),
  const Item(id: "12533"),
  const Item(id: "121243"),
  const Item(id: "1251243"),
];

final dummyItems2 = [
  const Item(id: "12fqw3"),
  const Item(id: "12fdsaf312342"),
  const Item(id: "12vcx34"),
  const Item(id: "12vzxv533"),
  const Item(id: "121afweqf243"),
  const Item(id: "1251fqwe243"),
];

final dummyStocks = [
  Stock(
    name: "Ice cream",
    price: 10,
    items: dummyItems,
  ),
  Stock(
    name: "Lemon team",
    price: 4.5,
    items: dummyItems2,
  ),
];
