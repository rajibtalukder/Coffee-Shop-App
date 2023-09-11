import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spaces_coffee/model/food_menu_model.dart';

import '../services/api_client.dart';
import '../utils/utils.dart';
import 'error_controller.dart';

class HomeController extends GetxController with ErrorController {
  int foodMenuPageNumber = 1;
  Rx<FoodMenuModel> foodMenu = FoodMenuModel().obs;
  Rx<FoodMenuModel> filteredFoodMenu = FoodMenuModel().obs;
  List<FoodsDatum> filteredItems = [];
  Rx<bool> isLoading = false.obs;
  Rx<bool> haveMoreMenu = true.obs;
  var categorySelect = -1.obs;
  var sizeSelect = -1.obs;
  var itemQuantity = 1.obs;

  @override
  void onInit() {
    getFoodMenu();
    super.onInit();
  }

  void increase() {
    itemQuantity.value++;
  }

  void decrease() {
    if (itemQuantity.value <= 1) {
      return;
    }
    itemQuantity.value--;
  }

  void onSearch(String query) {
    filteredFoodMenu.value.data?.clear();
    foodMenu.value.data?.forEach((element) {
      if (element.name?.toLowerCase().contains(query) ?? false) {
        filteredFoodMenu.value.data?.add(element);
      }
    });
    update(['gridUpdate']);
  }

  void onSearchItems(String query, Foods? foods) {
    filteredItems = [];
    // print('-------------1');
    foods?.data?.forEach((element) {
      if (element.name?.toLowerCase().contains(query) ?? false) {
        // print('-------------2');
        // print(element.name);
        filteredItems.add(element.clone());
      }
      update(['categoryUpdate']);
    });
  }

  void loadMoreData() {
    if (isLoading.value || !haveMoreMenu.value) {
      return;
    }
    getFoodMenu();
  }

  Future<void> getFoodMenu() async {
    if (isLoading.value) {
      return;
    }

    isLoading.value = true;
    var endPoint = 'menu?page=$foodMenuPageNumber';

    try {
      var response = await ApiClient().get(endPoint, header: Utils().apiHeader);
      // print(endPoint);
      // print(response);
      if (response == null) return;
      var temp = foodMenuModelFromJson(response);

      if (temp.data!.isEmpty) {
        haveMoreMenu.value = false;
      } else {
        foodMenu.value.data ??= [];
        filteredFoodMenu.value.data ??= [];
        foodMenu.value.data!.addAll(temp.data ?? []);
        filteredFoodMenu.value.data!.addAll(temp.data ?? []);
        foodMenuPageNumber++;
      }
      update(['gridUpdate']);

      // print(foodMenu.value.data?.length);
    } catch (e) {
      // print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
