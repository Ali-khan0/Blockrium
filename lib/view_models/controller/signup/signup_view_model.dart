import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../View/Resources/appurl.dart';
import '../../../View/bottomnav.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_preference_view_model.dart';

class SignupViewModel extends GetxController {
  final emailCTL = TextEditingController().obs;
  final nameCTL = TextEditingController().obs;
  final passwordCTL = TextEditingController().obs;
  final usernameCTL = TextEditingController().obs;
  final phoneCTL = TextEditingController().obs;
  final refferalCTL = TextEditingController().obs;
  final passwordConfirmationCTL = TextEditingController().obs;

  RxBool isLoading = false.obs;

  void singupfunc(countrycode, context) async {
    try {
      isLoading.value = true;

      var response = await post(Uri.parse(AppUrl.signUpEndPoint), body: {
        "username": usernameCTL.value.text,
        "name": nameCTL.value.text,
        "phone_number": phoneCTL.value.text,
        "email": emailCTL.value.text,
        "password": passwordCTL.value.text,
        "password_confirmation": passwordConfirmationCTL.value.text,
        "refferal_code": refferalCTL.value.text.isEmpty == true
            ? "null"
            : refferalCTL.value.text,
        "country": countrycode
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data["user"]["remember_token"]);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        final tokenData = data["user"];
        final userId = tokenData["id"].toString();
        final userName = tokenData["name"].toString();
        final userRefCode = tokenData["refferal_code"].toString();
        final accessToken = data["token"].toString();
        final profileImage = tokenData["user_image"].toString();
        final email = tokenData["email"].toString();
        final phoneNumber = tokenData["phone_number"].toString();

        saveTokenId(
          "remToken",
          accessToken,
          "userid",
          userId,
          "name",
          userName,
          "profileimg",
          profileImage,
          "phone",
          phoneNumber,
          "email",
          email,"refCode",userRefCode
        ).then((value) {
          print("""
          Name: $userName
          UserId: $userId
          phone number: $phoneNumber
          email: $email
          profileImage: $profileImage
          Token: $accessToken
        """);
        });

        Utilsnew.snackbar(data["message"], "");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MyBottomNavbar(),
          ),
        );
      } else {
        String errorMessage = '';

        var data = jsonDecode(response.body.toString());
        if (response.statusCode == 400) {
          errorMessage = 'Bad Request: ${data.toString()}';
        } else if (response.statusCode == 401) {
          errorMessage = 'Unauthorized: ${data.toString()}';
        } else if (response.statusCode == 500) {
          errorMessage = 'Internal Server Error: ${data.toString()}';
        } else {
          errorMessage = 'Something went wrong. Please try again later.';
        }

        Utilsnew.snackbar(errorMessage, "");
      }
    } catch (e) {
      Utilsnew.snackbar("Something went wrong", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
