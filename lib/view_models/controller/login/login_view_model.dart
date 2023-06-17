import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../View/bottomnav.dart';
import '../../../repository/login_repository/login_repository.dart';

import '../../../utils/utils.dart';
import '../user_preference/user_preference_view_model.dart';

class LoginViewModel extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  RxBool isLoading = false.obs; 
  void loginfunc(context) async {
    try {
      isLoading.value = true; 

      var response = await post(
        Uri.parse("https://maticlegend.com/api/auth/login"),
        body: {
          "email": emailController.value.text,
          "password": passwordController.value.text,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        final tokenData = data["token"]["original"];
        final userId = tokenData["user"]["id"].toString();
        final userName = tokenData["user"]["name"].toString();
        final userRefCode = tokenData["user"]["refferal_code"].toString();
        final accessToken = tokenData["access_token"].toString();
        final profileImage = tokenData["user"]["user_image"].toString();
        final email = tokenData["user"]["email"].toString();
        final phoneNumber = tokenData["user"]["phone_number"].toString();
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

        
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);

        Utilsnew.snackbar(data["message"], data["message_title"]);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MyBottomNavbar(),
          ),
        );
      } else {
        var data = jsonDecode(response.body.toString());

        if (response.statusCode == 401) {
          Utilsnew.snackbar("Please Check Email & Password", "Unauthorized");
        } else if (response.statusCode == 400) {
          Utilsnew.snackbar("Bad Request", data["error"]);
        } else if (response.statusCode == 403) {
          Utilsnew.snackbar("Forbidden", data["error"]);
        } else if (response.statusCode == 404) {
          Utilsnew.snackbar("Not Found", data["error"]);
        } else if (response.statusCode == 500) {
          Utilsnew.snackbar(
              "Internal Server Error", "Something went wrong on the server");
        } else {
          Utilsnew.snackbar("Something Went Wrong", "");
        }
      }
    } catch (e) {
      Utilsnew.snackbar("Something Went Wrong", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
