import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spaces_coffee/controller/error_controller.dart';
import 'package:spaces_coffee/model/cart_item_model.dart';

import '../services/local/shared_pref.dart';

class CartController extends GetxController with ErrorController{
  List<CartItemModel> localCartItems = [];
  var prefDataList;
  @override
  void onInit() {
    showSharedPreferenceData();
    super.onInit();
  }

  String? item;
  addCartItem(CartItemModel cartItem){
    localCartItems.add(cartItem);
    List<String> temp = [];
    for (var element in localCartItems) {
      temp.add(cartItemModelToJson(element));
    }
    SharedPref().saveList('carts', temp);
  }

  Future<void> removeItemAtIndex(int index) async {
    if (index >= 0 && index < prefDataList.length) {
      prefDataList.removeAt(index);
      await SharedPref().saveList('carts', prefDataList);
      update(['cartItemUpdate']);
    }
  }


  void showSharedPreferenceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefDataList = prefs.getStringList('carts');

    if (prefDataList != null) {
      for (item in prefDataList) {
        var x= cartItemModelFromJson(item!);
        localCartItems.add(x);
        update(['cartItemUpdate']);
      }
    } else {
      print('No data stored in SharedPreferences.');
    }
  }

}