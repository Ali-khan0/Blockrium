import 'package:Blockrium/View%20new/authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/widget.dart';
import 'loginpage.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    bool isLoading = false; // Add this variable to track loading state

    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: h * 0.650,
            width: w,
            decoration: BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
                    image: AssetImage("assets/loginbg3.png"),
                    fit: BoxFit.fitHeight)),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: roundButton(h, w, "Login", isLoading)),
          Text("OR"),
          InkWell(
              onTap: () {
                Get.to(SignUpPage());
              },
              child: roundButton2(h, w, "SignUp")),
          Text(
            "Privacy & Policy",
            style: TextStyle(color: Colors.blue),
          )
        ],
      ),
    );
  }
}
