import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spaces_coffee/controller/error_controller.dart';
import 'package:spaces_coffee/model/recent_order_model.dart';
import 'package:spaces_coffee/services/api_client.dart';
import 'package:spaces_coffee/utils/utils.dart';

import '../constants/constants.dart';
import '../model/authenticated_user.dart';
import 'package:http/http.dart' as http;

import '../services/api_exception.dart';
import '../services/local/shared_pref.dart';

class ProfileController extends GetxController with ErrorController {
  @override
  void onInit() async {
    getRecentOrder();
    getAuthenticatedUser();
    super.onInit();
  }

  Rx<RecentOrderModel> recentOrderData = RecentOrderModel().obs;
  RxBool isLoading = false.obs;
  RxInt selectedStep = 1.obs;

  var imagePath = '';
  final ImagePicker picker = ImagePicker();

  ///image picker code for profile picture ...........

  void pickedImage(ImageSource imgCam) async {
    final XFile? image = await picker.pickImage(source: imgCam);
    imagePath = image!.path;
    update(['imgPathUpdate']);
  }

  AuthenticatedUser? authenticatedUser;

  void selectedStepChange() {
    if (recentOrderData.value.data?.status == 'confirm') {
      selectedStep.value = 2;
    } else if (recentOrderData.value.data?.status == 'ready') {
      selectedStep.value = 3;
    } else if (recentOrderData.value.data?.status == 'success') {
      selectedStep.value = 4;
    } else {
      selectedStep.value = 1;
    }
  }

  Future<void> getRecentOrder() async {
    String endPoint = 'order';
    isLoading.value = true;
    var response = await ApiClient()
        .get(endPoint, header: Utils().apiHeader)
        .catchError((e) {
      print(e.toString());
    });
    if (response == null) return;
    recentOrderData.value = recentOrderModelFromJson(response);
    isLoading.value = false;
    update(['updateProfile']);
    return;
  }

  Future<bool> getAuthenticatedUser() async {
    String endPoint = 'user';
    isLoading.value = true;
    var response = await ApiClient()
        .get(endPoint, header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message);
    });
    isLoading.value = false;
    authenticatedUser = authenticatedUserFromJson(response);
    isLoading.value = false;
    update(['profileUpdate']);
    return true;
  }

  Future updateUserProfile(
    String fName,
    String lName,
    String email,
    String phone,
  ) async {
    var uri = Uri.parse("${baseUrl}profile");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      request.headers.addAll(Utils().apiHeader);
      if (imagePath.isNotEmpty) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('image', imagePath);
        request.files.add(multipartFile);
      }

      Map<String, String> _fields = Map();
      _fields.addAll(<String, String>{
        "first_name": fName,
        "last_name": lName,
        "email": email,
        "phone": phone,
        '_method': 'PUT',
      });
      request.fields.addAll(_fields);
      http.StreamedResponse response = await request.send();
      var res = await http.Response.fromStream(response);
      print(res.statusCode);
      print(res.body);
      Utils.showSnackBar(jsonDecode(res.body)['message']);
      await getAuthenticatedUser();
    } on SocketException {
      throw ProcessDataException("No internet connection", uri.toString());
    } on TimeoutException {
      throw ProcessDataException("Not responding in time", uri.toString());
    } catch (e) {
      Utils.showSnackBar(e.toString());
      print(e);
    }
  }

  Future<bool> logOut() async {
    Utils.showLoading();
    var response = await ApiClient()
        .post('logout', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message);
    });
    Utils.hidePopup();
    print(token);
    print(Utils().apiHeader);
    if (response == null) return false;
    Utils.showSnackBar(jsonDecode(response)["message"]);
    await SharedPref().saveValue('token', '');
    token = '';
    return true;
  }
}
