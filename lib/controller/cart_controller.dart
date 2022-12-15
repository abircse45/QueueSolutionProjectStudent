import 'package:food_app/database/database_helper.dart';
import 'package:food_app/model/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  DBHelper _dbHelper = DBHelper();

  var _counter = 0.obs;

  var _totalPrice = 0.0.obs;

  late Future<List<Cart>> _cartData;

  Future<List<Cart>?> getCart() async {
    return _cartData = _dbHelper.getCartList();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice.value = _totalPrice.value + productPrice;
    update();
  }

  void removeprice(double productPrice) {
    _totalPrice.value = _totalPrice.value - productPrice;
    update();
  }

  var items = 0.0.obs;

  Future<double?> getTotalPrice() async {
    await _dbHelper.getCartList().then((value) {
      value.forEach((element) {
        items.value += (element.productPrice * element.quantity!);
      });

      _totalPrice = items;
    });
  }

  Future<int?> getCounter() async {
    items.value = 0;
    await _dbHelper.getCartList().then((value) {
      _counter.value = value.length;
    });
  }
}
