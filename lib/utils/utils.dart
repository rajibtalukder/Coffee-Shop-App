import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';
import '../constants/font_constants.dart';

class Utils {

  var apiHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };

  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  static void hidePopup() {
    Get.back();
  }

  static void showSnackBar(String message, {bool? err}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: err==true?red:black,
        message: message,
        //icon: const Icon(Icons.info_outline,color: white),
        isDismissible: true,
        duration: const Duration(seconds: 3),
        messageText: Text(
          message,style: TextStyle(color: white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    if (password.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  static bool validatePhone(String? value) {
    RegExp phoneRegex = RegExp(r'^\d{11}$');

    if (value == null || value.isEmpty) {
      return false;
    }

    if (!phoneRegex.hasMatch(value)) {
      return false;
    }

    return true;
  }

  static bool isIDValid(String id) {
    if (id.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }


}
