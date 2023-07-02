import 'dart:convert';

import 'package:Blockrium/res/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View new/Widgets/custom_appbar.dart';
import '../../widget/glowingbutton.dart';
import '../../widget/widget.dart';
import '../Resources/utils.dart';
import '../../View new/authentication/Widget/widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
    required this.appbartitle,
  }) : super(key: key);
  final String appbartitle;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

bool isLoading = false; // Add this variable to track loading state

class _EditProfileState extends State<EditProfile> {
  Future<void> changePass3(email, phone, pass, context) async {
    try {
      setState(() {
        isLoading = true; // Set isLoading to true when password change starts
      });

      var response = await post(
        Uri.parse("https://maticlegend.com/api/update-password"),
        body: {
          "email": email,
          "phone_number": phone,
          "new_password": pass,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Utils.snackbar(data["message"], "");
        Navigator.pop(context);
      } else if (response.statusCode == 422) {
        var data = jsonDecode(response.body);
        Utils.snackbar(data["errors"], "");
      }
    } catch (e) {
      debugPrint(e.toString());
      Utils.snackbar("Something went wrong", "");
    } finally {
      setState(() {
        isLoading =
            false; // Set isLoading to false when password change completes
      });
    }
  }

  bool _passwordVisible = false;

  TextEditingController email = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: SubScreenApbarBlack(
          title: "Forgot Password",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: h * 0.03,
                width: w,
              ),
              Container(
                height: h * 0.15,
                width: w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logoname.png"))),
              ),
              SizedBox(
                height: h * 0.05,
                width: w,
              ),
              Container(
                height: Get.height * 0.67,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white.withOpacity(0.07),
                    image: DecorationImage(
                        image: AssetImage("assets/bg2.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image(
                    //   image: AssetImage("assets/forgot.png"),
                    //   height: Get.height * 0.2,
                    // ),
                    // Text(
                    //   "To reset your password, please provide the following information",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold, color: Colors.white),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Text(
                        "Update Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildEmailfield2(email),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    buildphonetextfield(phone, "Phone Number", Icons.phone),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " Password",
                            style: TextStyle(
                                color: Color(0xffA4A4A4), fontSize: 16),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                gradient: LinearGradient(colors: [
                                  Color(0xffFFFFFF).withOpacity(0.2),
                                  Color(0xffFFFFFF).withOpacity(0.1),
                                ])),
                            child: TextFormField(
                              validator: ((txt) {
                                if (txt == null || txt.isEmpty) {
                                  return "Please Enter 6 digit Password";
                                }
                                if (txt.length < 6) {
                                  return "Password must has 6 characters";
                                } else {
                                  return null;
                                }
                              }),
                              obscureText: !_passwordVisible,
                              controller: newPass,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Color(0xffA4A4A4),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.key_rounded,
                                    color: Color(0xffA4A4A4),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xffA4A4A4),
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Password"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    // InkWell(
                    //     onTap: () {
                    //       if (email.text.isEmpty) {
                    //         Utils.snackbar("Email Required", "");
                    //       } else if (phone.text.isEmpty) {
                    //         Utils.snackbar("Phone Number Required", "");
                    //       } else if (newPass.text.isEmpty) {
                    //         Utils.snackbar("New Password Required", "");
                    //       } else {
                    //         debugPrint(email.text);
                    //         debugPrint(phone.text);
                    //         debugPrint(newPass.text);
                    //         changePass3(
                    //             email.text, phone.text, newPass.text, context);
                    //       }
                    //     },
                    //     child: roundButton(h, w, "Update Password", isLoading)),
                    InkWell(
                        onTap: () {
                          if (email.text.isEmpty) {
                            Utils.snackbar("Email Required", "");
                          } else if (phone.text.isEmpty) {
                            Utils.snackbar("Phone Number Required", "");
                          } else if (newPass.text.isEmpty) {
                            Utils.snackbar("New Password Required", "");
                          } else {
                            debugPrint(email.text);
                            debugPrint(phone.text);
                            debugPrint(newPass.text);
                            changePass3(
                                email.text, phone.text, newPass.text, context);
                          }
                        },
                        child: GlowingButtonAuth(
                            text: "Update Password", loading: isLoading))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
