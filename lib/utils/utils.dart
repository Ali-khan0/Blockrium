import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../View/Resources/appurl.dart';
import '../View new/authentication/loginpage.dart';

class Utilsnew {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static snackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }

  static shimmerCustom(double w, h) {
    Shimmer.fromColors(
        baseColor: Color.fromARGB(255, 241, 241, 241),
        highlightColor: Color.fromARGB(19, 245, 215, 225),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ));
  }

  static alertDialogLogout(context, func) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black87,
        title: Text(
          'Confirm Logout',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to logout from this device',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              'Confirm',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              Navigator.pop(context);

              final String? id;

              final prefs = await SharedPreferences.getInstance();
              final String? token;
              id = prefs.getString('userid');
              token = prefs.getString('remToken');
              try {
                var response = await post(
                  Uri.parse(AppUrl.logoutEndpoint),
                  body: {},
                  headers: {'Authorization': 'Bearer $token'},
                );
                if (response.statusCode == 200) {
                  var data = jsonDecode(response.body.toString());
                  // print(data["message"]);
                  //  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("isLoggedIn", false);
                  Utilsnew.snackbar("Logout Successfully", "");
                  Get.offAll(LoginPage());
                  // print(
                  //     "account created successfully: Name: $name, password: $password, email: $email, gymLocation: $gymLoc ");
                } else {
                  Utilsnew.snackbar("Something went wrong", "");
                  // Utils.scaffoldmessenger(context, "Failed to create Account");
                }
              } catch (e) {
                Utilsnew.snackbar("Something went wrong", "");
                // Utils.scaffoldmessenger(context, "Something went wrong");
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget loading(double w, h) {
  return Container(
    height: h,
    width: w,
    child: Center(
      child: Card(
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: AssetImage('assets/loading.gif')),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    ),
  );
}

Widget loadingData() {
  return Image.asset(
    "assets/loadingbg.gif",
    height: 100,
  );
}

// Widget loadingError() {
//   return SizedBox(
//     height: 150,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           AppIcons.fail,
//           height: 100,
//         ),
//         const Text(
//           "Unable to Load Please try again later",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ],
//     ),
//   );
// }
