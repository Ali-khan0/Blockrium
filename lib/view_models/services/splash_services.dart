// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../res/routes/routes_name.dart';

// class SplashServices {
//   void islogin() async {
//     final prefs = await SharedPreferences.getInstance();

//     final userToken = prefs.getString("remToken");
//     // then((value) {

//     if (userToken.toString() == "null") {
//       print("login screen route working ${userToken}");
//       Timer(Duration(seconds: 6), () => Get.toNamed(RoutesName.loginScreen));
//     } else {
//       Timer(
//           Duration(seconds: 6), () => Get.toNamed(RoutesName.bottomnavigation));
//     }
//     // });
//   }
// }
