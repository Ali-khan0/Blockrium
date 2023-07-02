import 'dart:convert';

import 'package:Blockrium/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Blockrium/res/colors/app_colors.dart';

import '../../view_models/controller/signup/signup_view_model.dart';
import '../../widget/widget.dart';
import '../../View/Resources/appurl.dart';
import '../../View/Resources/utils.dart';
import '../../View/Terms & Policy & About us/terms_policy.dart';
import '../../View/bottomnav.dart';
import 'Widget/widget.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({
    Key? key,
    // required this.name,
    // required this.username,
    // required this.phone,
    // required this.email,
    // required this.country,
  }) : super(key: key);
  // final String name;
  // final String username;
  // final String phone;
  // final String email;
  // final String country;
  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  @override
  bool _passwordVisible2 = false;

  final GlobalKey<FormState> signup_formkey = GlobalKey<FormState>();
  Map selectedCountry = {};
  var countryData;
  Future<void> countryApi() async {
    final response =
        await http.get(Uri.parse("https://maticlegend.com/api/get-countries"));
    if (response.statusCode == 200) {
      countryData = jsonDecode(response.body.toString());
      debugPrint(countryData);
    } else {
      debugPrint("not getting data of Country");
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<SignupViewModel>(
        init: SignupViewModel(),
        builder: (signupViewModel) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
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
                      ],
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
                        key: signup_formkey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15.0),
                              child: Text(
                                "Almost Done",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            buildrefferaltextfield(
                                signupViewModel.refferalCTL.value,
                                "Refferal Number ( Optional )",
                                Icons.code),
                            SizedBox(
                              height: h * 0.010,
                              width: w,
                            ),
                            SizedBox(
                              height: h * 0.010,
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
                                      fontSize: 16,
                                      color: Color(0xffA4A4A4),
                                    ),
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
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
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
                                      obscureText: !_passwordVisible2,
                                      controller:
                                          signupViewModel.passwordCTL.value,
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            color: Color(0xffA4A4A4),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.key_sharp,
                                            color: Color(0xffA4A4A4),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible2
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: Color(0xffA4A4A4),
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _passwordVisible2 =
                                                    !_passwordVisible2;
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    " Confirm Password",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffA4A4A4),
                                    ),
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
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
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
                                      obscureText: !_passwordVisible2,
                                      controller: signupViewModel
                                          .passwordConfirmationCTL.value,
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            color: Color(0xffA4A4A4),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.key_sharp,
                                            color: Color(0xffA4A4A4),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible2
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: Color(0xffA4A4A4),
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _passwordVisible2 =
                                                    !_passwordVisible2;
                                              });
                                            },
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Confirm Password"),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: h * 0.010,
                              width: w,
                            ),
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    height: Get.height * 0.5,
                                    // color: Colors.greenAccent,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(132, 0, 0, 0),
                                        border: Border.all(
                                            color: Colors.white, width: 1)),
                                    child: FutureBuilder(
                                        future: countryApi(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return loading(w, h);
                                            // LoadingAnimationWidget.beat(
                                            //   color: Colors.blue.shade300,
                                            //   size: 35,
                                            // );
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.none) {
                                            return Center();
                                          } else {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              // scrollDirection: Axis.horizontal,
                                              // physics: NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  countryData["countries"]
                                                      .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var newindex = index + 1;
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedCountry = {
                                                        "name": countryData[
                                                                    "countries"]
                                                                [index]["name"]
                                                            .toString(),
                                                        "code": countryData[
                                                                    "countries"]
                                                                [index]["code"]
                                                            .toString(),
                                                        "flag": countryData[
                                                                    "countries"]
                                                                [index]["flag"]
                                                            .toString()
                                                      };
                                                    });
                                                    Get.back();
                                                  },
                                                  child: ListTile(
                                                    title: Text(
                                                      countryData["countries"]
                                                              [index]["name"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffA4A4A4),
                                                      ),
                                                    ),
                                                    subtitle: Row(
                                                      children: [
                                                        Text(
                                                          countryData["countries"]
                                                                      [index]
                                                                  ["code"]
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffA4A4A4),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        SvgPicture.network(
                                                          height:
                                                              Get.height * 0.02,
                                                          countryData['countries']
                                                                      [index]
                                                                  ['flag']
                                                              .toString(),
                                                          placeholderBuilder:
                                                              (context) =>
                                                                  CircularProgressIndicator(),
                                                        )
                                                      ],
                                                    ),
                                                    leading: Text(
                                                      newindex.toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffA4A4A4),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        }),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    trailing: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xffA4A4A4),
                                    ),
                                    leading: selectedCountry.isEmpty
                                        ? Icon(
                                            Icons.flag,
                                            color: AppColor.purpleColor,
                                          )
                                        : SvgPicture.network(
                                            height: Get.height * 0.03,
                                            selectedCountry['flag'].toString(),
                                          ),
                                    title: Text(
                                      selectedCountry.isEmpty
                                          ? "Select Country"
                                          : selectedCountry["name"],
                                      style: TextStyle(
                                        color: Color(0xffA4A4A4),
                                      ),
                                    ),
                                    subtitle: Text(
                                      selectedCountry.isEmpty
                                          ? ""
                                          : selectedCountry["code"],
                                      style: TextStyle(
                                        color: Color(0xffA4A4A4),
                                      ),
                                    ),
                                  ),
                                  // Divider()
                                ],
                              ),
                            ),
                            SizedBox(
                              height: h * 0.010,
                              width: w,
                            ),
                            SizedBox(
                              height: h * 0.050,
                              width: w,
                            ),
                            InkWell(
                                onTap: () {
                                  final isValid =
                                      signup_formkey.currentState?.validate();

                                  if (isValid == true) {
                                    if (selectedCountry.isNotEmpty) {
                                      signupViewModel.singupfunc(
                                          selectedCountry["code"], context);
                                    } else {
                                      Utils.snackbar(
                                          "Please Select Your Country", "");
                                    }
                                  } else {
                                    debugPrint("form is not valid");
                                  }
                                },
                                child: Obx(() => roundButton(
                                    h,
                                    w,
                                    "Create Account",
                                    signupViewModel.isLoading.value))),

                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => PolicyTerms()),
                            //     );
                            //   },
                            //   child: Text(
                            //     "Privacy & Policy",
                            //     style: TextStyle(color: AppColor.purpleColor),
                            //   ),
                            // )
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
