import 'dart:convert';
import 'package:Blockrium/View%20new/authentication/signup2.dart';
import 'package:Blockrium/res/colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../view_models/controller/signup/signup_view_model.dart';
import '../../widget/widget.dart';
import '../../View/Resources/appurl.dart';
import '../../View/Resources/utils.dart';
import '../../View/Terms & Policy & About us/terms_policy.dart';
import '../../View/bottomnav.dart';
import 'Widget/widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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

  Map selectedCountry = {};
  final GlobalKey<FormState> signup_formkey = GlobalKey<FormState>();
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: Column(
                        children: [
                          Form(
                            key: signup_formkey,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, bottom: 15.0),
                                  child: Text(
                                    "Get Started",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                buildtextfield(signupViewModel.nameCTL.value,
                                    "Full Name", Icons.person),
                                SizedBox(
                                  height: h * 0.010,
                                  width: w,
                                ),
                                buildtextfield(
                                    signupViewModel.usernameCTL.value,
                                    "Username ",
                                    Icons.assignment_ind_rounded),
                                SizedBox(
                                  height: h * 0.010,
                                  width: w,
                                ),
                                buildphonetextfield(
                                    signupViewModel.phoneCTL.value,
                                    "Phone Number",
                                    Icons.phone),
                                SizedBox(
                                  height: h * 0.010,
                                  width: w,
                                ),
                                
                                // buildrefferaltextfield(refferalCTL,
                                //     "Refferal Number ( Optional )", Icons.numbers),
                                // SizedBox(
                                //   height: h * 0.005,
                                //   width: w,
                                // ),
                                buildEmailfield2(
                                    signupViewModel.emailCTL.value),

                               
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h * 0.020,
                            width: w,
                          ),
                          InkWell(
                              onTap: () {
                                debugPrint(signupViewModel
                                            .refferalCTL.value.text.isEmpty ==
                                        true
                                    ? null
                                    : signupViewModel.refferalCTL.value.text);
                                final isValid =
                                    signup_formkey.currentState?.validate();
                                // if (selectedCountry.isNotEmpty) {
                                //   Get.to(SignUpPage2(
                                //       country: selectedCountry["code"]));
                                // } else {
                                //   Utils.snackbar(
                                //       "Please Select Your Country", "");
                                // }
                                 Get.to(SignUpPage2());
                              },
                              child: roundButton(h, w, "Next",
                                  signupViewModel.isLoading.value)),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  "Already have an Account?  ",
                                  style: TextStyle(
                                    color: Color(0xffA4A4A4),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.purpleColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: h * 0.02,
                          //   width: w,
                          // ),
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
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
