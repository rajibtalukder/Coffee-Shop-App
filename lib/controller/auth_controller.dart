import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spaces_coffee/controller/error_controller.dart';
import 'package:spaces_coffee/model/authenticated_user.dart';

import '../constants/constants.dart';
import '../services/api_client.dart';
import '../services/api_exception.dart';
import '../services/local/shared_pref.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController with ErrorController{

  @override
  void onInit() async {
    getAuthenticatedUser();
    super.onInit();
  }
  RxBool isLoading = false.obs;
  AuthenticatedUser? authenticatedUser;
  ///login..........
  bool isEmailOrPhoneValid = true;
  bool isPasswordValid = true;

  validateLogIn(String email, String pass) {
    isEmailOrPhoneValid = Utils.isEmailValid(email);
    isPasswordValid = Utils.isPasswordValid(pass);
  }
  ///signup...........
  bool isNameValid = true;
  bool isNumberValid = true;
  bool isSignInPasswordValid = true;
  bool isSignInConfirmPasswordValid = true;
  bool isPasswordMatch = true;



  validateSignIn(String name, String phone, String pass, String confirmPass) {
    isSignInPasswordValid = Utils.isPasswordValid(pass);
    isSignInConfirmPasswordValid = Utils.isPasswordValid(confirmPass);
    isPasswordMatch = pass == confirmPass;
    isNumberValid = Utils.validatePhone(phone);
    isNameValid = name.isNotEmpty;
  }

  Future<bool> login(String email, String pass) async {
    Utils.showLoading();
    validateLogIn(email, pass);
    if (!isPasswordValid || !isEmailOrPhoneValid) {
      Utils.hidePopup();
      Utils.showSnackBar('Invalid data..!');
      return false;
    }
    var body = {
      "email": email,
      "password": pass,
    };
    var response = await ApiClient()
        .post('login', payloadObj: body, header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message);
    });
    Utils.hidePopup();
    if (response == null) return false;
    Utils.showSnackBar(jsonDecode(response)["message"]);
    await SharedPref().saveValue('token', jsonDecode(response)["token"]);
    token = jsonDecode(response)['token'];
    return true;
  }

  Future<bool> signUp(String name, String email,
      String phone, String pass, String confirmPass) async {
    Utils.showLoading();
    validateSignIn(name, phone, pass, confirmPass);
    if (!isPasswordValid || !isEmailOrPhoneValid) return false;
    var body = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": confirmPass,
      //'token': token,
    };
    var response = await ApiClient()
        .post('register', payloadObj: body, header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message);
    });
    if (response == null) return false;
    Utils.showSnackBar(jsonDecode(response)["message"]);
    await SharedPref().saveValue('token', jsonDecode(response)["token"]);
    token = jsonDecode(response)['token'];
    Utils.hidePopup();
    print(token);
    return true;
  }

  Future<bool>getAuthenticatedUser()async{
    String endPoint = 'user';
    isLoading.value=true;
    var response = await ApiClient()
        .get(endPoint, header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message);
    });
    authenticatedUser = authenticatedUserFromJson(response);
    isLoading.value=false;
    update(['profileUpdate']);
    return true;
  }

}