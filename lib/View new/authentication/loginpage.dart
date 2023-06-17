import 'dart:convert';
import 'package:Blockrium/View%20new/authentication/signup.dart';
import 'package:Blockrium/res/colors/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../res/appurl.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/login/login_view_model.dart';
import '../../widget/glowingbutton.dart';
import '../../widget/widget.dart';
import '../../View/Profile/edit_profile.dart';
import '../../View/Terms & Policy & About us/terms_policy.dart';
import '../../View/bottomnav.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final GlobalKey<FormState> login_formkey = GlobalKey<FormState>();
bool _passwordVisible = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<LoginViewModel>(
        init: LoginViewModel(),
        builder: (loginViewModel) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.1,
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
                      height: Get.height * 0.77,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white.withOpacity(0.07),
                          image: DecorationImage(
                              image: AssetImage("assets/bg2.png"),
                              fit: BoxFit.cover)),
                      child: Form(
                        key: login_formkey,
                        // autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15.0),
                              child: Text(
                                "Welcome Back",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            buildEmailfield2(
                                loginViewModel.emailController.value),
                            SizedBox(
                              height: h * 0.020,
                              width: w,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
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
                                      controller: loginViewModel
                                          .passwordController.value,
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
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: Color(0xffA4A4A4),
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Get.to(EditProfile(
                                        appbartitle: "Forgot Password",
                                      ));
                                    },
                                    child: Text(
                                      "Forgot Password?   ",
                                      style: TextStyle(
                                        color: Color(0xffA4A4A4),
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.040,
                              width: w,
                            ),
                            InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                onTap: () {
                                  final isValid =
                                      login_formkey.currentState!.validate();

                                  if (isValid) {
                                    loginViewModel.loginfunc(context);
                                  }
                                  // final isValid = login_formkey.currentState?.validate();
                                  // Get.to(MyBottomNavbar());
                                },
                                child: Obx(() =>
                                    // roundButton(h, w, "Sign In",
                                    //     loginViewModel.isLoading.value)
                                    GlowingButtonAuth(
                                        text: "Sign-In",
                                        loading:
                                            loginViewModel.isLoading.value))),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Don't have an Account?  ",
                                    style: TextStyle(
                                      color: Color(0xffA4A4A4),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(SignUpPage());
                                    },
                                    child: Text(
                                      "SignUp",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.purpleColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: h * 0.02,
                              width: w,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PolicyTerms()),
                                );
                              },
                              child: Text(
                                "Privacy & Policy",
                                style: TextStyle(color: AppColor.purpleColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
