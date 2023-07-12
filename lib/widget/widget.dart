import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_balloon/speech_balloon.dart';

import '../Ads/Admob/admob.dart';
import '../Ads/Unity/unityads.dart';
import '../View/HomePage/Attendance/attendance.dart';
import '../View/Resources/appurl.dart';
import '../res/colors/app_colors.dart';
import '../utils/utils.dart';
import 'glowingbutton.dart';

Widget roundButton(h, w, title, isLoading) {
  return Container(
    height: 50,
    width: w * 0.7,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        gradient: LinearGradient(colors: [
          Color(0xff9C3FE4),
          Color(0xffC65647),
        ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Center(
      child: isLoading
          ? LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 40,
            )
          : Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
    ),
  );
}
Widget followButton(h, w, title, isLoading) {
  return Container(
    height: h,
    width: w ,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        gradient: LinearGradient(colors: [
          Color(0xff9C3FE4),
          Color(0xffC65647),
        ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Center(
      child: isLoading
          ? LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 40,
            )
          : Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
    ),
  );
}

Widget roundButton2(h, w, title) {
  return Container(
    height: 60,
    width: w * 0.9,
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // red as border color
        ),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50))),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
      ),
    ),
  );
}

Widget buildEmailfield2(TextEditingController emailcontroller) {
  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else {
      return null;
    }
  }

  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Email",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xffA4A4A4),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(colors: [
                Color(0xffFFFFFF).withOpacity(0.2),
                Color(0xffFFFFFF).withOpacity(0.1),
              ])),
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
            ),

            validator: (value) => validateEmail(value),
            // obscureText: true,
            controller: emailcontroller,
            // cursorColor: pink,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Color(0xffA4A4A4),
                ),
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Color(0xffA4A4A4),
                ),
                border: InputBorder.none,
                hintText: "Email"),
          ),
        ),
      ],
    ),
  );
}

Widget customAppbar(w, h) {
  return Container(
    // height: 30,
    // width: w,
    child: ListTile(
      trailing: Icon(
        Icons.notifications,
        color: Colors.black,
      ),
      leading: Image(image: AssetImage("assets/blockrium.png")),
      title: Center(
        child: Text(
          "MaticLegend",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget deailContainer(h, w, balance) {
  return Container(
    height: 150,
    width: w,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/Header.png"),
            fit: BoxFit.cover,
            opacity: 0.8)
        // borderRadius: BorderRadius.all(Radius.circular(10)),
        // gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Colors.blue, Color(0xff426CB3)])
        ,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.4),
        //     spreadRadius: 2,
        //     blurRadius: 8,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // customAppbar(w, h),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Current Balance",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                "+0.5 e/hr",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                balance,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "MLC",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Text(
        //     "Coin ID : 12345678",
        //     style: TextStyle(color: Colors.blue),
        //   ),
        // ),
      ],
    ),
  );
}

Widget inviteContainer(w, h) {
  return Container(
    height: h * 0.150,
    width: w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.blue.shade100),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Start Inviting!",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Invite your Friends",
                style: TextStyle(fontSize: 15),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.people,
                    color: Colors.blue,
                  ),
                  Text("0")
                ],
              ),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_right,
            size: 50,
          ),
        ],
      ),
    ),
  );
}

Widget miningRateContainer2(w, h, stagedata) {
  return Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 1.0),
    height: h * 0.3,
    width: w,
    decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/miningrateimg2.png"),
          fit: BoxFit.cover,
        ),
        // color: Colors.green,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
        child: Column(
          children: [
            Text(
              stagedata["appStage"][0]["title"].toString(),
              style: TextStyle(
                  color: AppColor.purpleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            // Text(
            //   "MLC is on top",
            //   style: TextStyle(),
            // ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: 3, // rotate 270 degrees (90 degrees clockwise)
                  child: Text(
                    'BRC Mining Rate',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    chart(h * 0.15, w * 0.15, "0.5 e/hr", h, 1, "100k"),
                    chart(h * 0.10, w * 0.15, "0.4 e/hr", h, 0, "500k"),
                    chart(h * 0.07, w * 0.15, "0.3 e/hr", h, 0, "1M"),
                    chart(h * 0.02, w * 0.15, "0.1 e/hr", h, 0, "50M"),
                    chart(h * 0.007, w * 0.15, "", h, 0, "100M"),
                  ],
                ),
              ],
            ),
          ],
        )),
  );
}

Widget chart(h, w, hour, h2, index, download) {
  return Column(
    children: [
      // Container(
      //   height: h2 * 0.02,
      //   width: w * 0.8,
      //   color: Colors.purple,
      // ),
      index == 1
          ? SpeechBalloon(
              height: h2 * 0.03,
              nipHeight: h2 * 0.01,
              width: w * 0.7,
              borderRadius: 100,
              nipLocation: NipLocation.bottomLeft,
              borderColor: AppColor.purpleColor,
              color: Colors.white,
              borderWidth: 2,
              child: Center(child: Text("Now")),
            )
          : Text(""),
      Text(hour),
      Shimmer(
        direction: ShimmerDirection.ttb,
        period: Duration(seconds: 2),
        gradient: LinearGradient(
          colors: [Colors.red.shade200, Colors.purple.shade200],
          begin: Alignment(-1, -1),
          end: Alignment(1, 1),
          stops: [0, 1],
        ),
        child: Container(
          margin: EdgeInsets.only(left: 2.0),
          height: h,
          width: w,
          color: Colors.white,
        ),
      ),
      Text(download)
    ],
  );
}

Widget shareContainer(w, h) {
  return Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
    height: h * 0.1,
    width: w,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/shareappimg.png"),
            fit: BoxFit.cover,
            opacity: 0.8),
        // color: Colors.green,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Start Inviting",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Invite Your Friends & Earn 10 BRC",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Image(
                image: AssetImage("assets/stake2.png"),
                height: 80,
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 40,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget attendanceContainer(w, h) {
  return Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
    height: h * 0.180,
    width: w,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/attendancenewimg.jpg"),
            fit: BoxFit.cover,
            opacity: 0.8),
        // color: Colors.green,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daily Attendance",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Get your attendance rewards",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              InkWell(
                onTap: () {
                  Get.to(Attendance());
                },
                child: Container(
                  height: 40,
                  width: 90,
                  child: Center(
                    child: Text(
                      "Attendance",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      // color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 8,
                        ),
                      ],
                      gradient: LinearGradient(colors: [
                        AppColor.redColor,
                        AppColor.pinkColor,
                        AppColor.purpleColor
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                ),
              ),
            ],
          ),
          Image(
            image: AssetImage("assets/calendar.png"),
            height: 80,
          )
        ],
      ),
    ),
  );
}

Widget rewardsContainer(w, h, func) {
  return Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
    height: h * 0.180,
    width: w,
    decoration: BoxDecoration(
        // color: Colors.green,
        image: DecorationImage(
            image: AssetImage("assets/rewardsbg2.jpg"),
            fit: BoxFit.cover,
            opacity: 0.7),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daily Rewards!",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Get your daily rewards",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              InkWell(
                onTap: () {
                  func();
                },
                child: Container(
                  height: 40,
                  width: 90,
                  child: Center(
                    child: Text(
                      "Get Reward",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      // color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 8,
                        ),
                      ],
                      gradient: LinearGradient(colors: [
                        Colors.blue,
                        Colors.green.shade200,
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                ),
              ),
            ],
          ),
          Image(
            image: AssetImage("assets/reward3d2-min.png"),
            height: 80,
          )
        ],
      ),
    ),
  );
}

Widget rewardsContainer2(w, h, index, customsetstate, ad1, ad2, ad3) {
  return Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
    height: h * 0.3,
    width: w,
    decoration: BoxDecoration(
        // color: Colors.green,
        image: DecorationImage(
            image: AssetImage("assets/block.jpg"),
            fit: BoxFit.cover,
            opacity: 0.7),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.red,
                height: Get.height * 0.07,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Rewards!",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Get random coins rewards",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                height: Get.height * 0.04,
                width: Get.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(colors: [
                      AppColor.redColor,
                      AppColor.pinkColor,
                      AppColor.purpleColor,
                    ])),
                child: Center(
                  child: Text(
                    "${index} /3 Rewards",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          index == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    rewardsButtonUnLocked(index, ad1, ad2, ad3, customsetstate),
                    rewardsButtonLocked(index, "Claim first reward to Unlock"),
                    rewardsButtonLocked(index, "Unlock second reward to Unlock")
                  ],
                )
              : index == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        rewardsButton(index),
                        rewardsButtonUnLocked(
                            index, ad1, ad2, ad3, customsetstate),
                        rewardsButtonLocked(
                            index, "Claim second reward to Unlock")
                      ],
                    )
                  : index == 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            rewardsButton(index),
                            rewardsButton(index),
                            rewardsButtonUnLocked(
                                index, ad1, ad2, ad3, customsetstate),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            rewardsButton(index),
                            rewardsButton(index),
                            rewardsButton(index),
                          ],
                        )
        ],
      ),
    ),
  );
}

Widget rewardsButton(index) {
  return Container(
      height: Get.height * 0.180,
      width: Get.width * 0.27,
      decoration: BoxDecoration(
          color: Color.fromARGB(59, 68, 127, 255),
          border: Border.all(color: Colors.white),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(58, 180, 180, 180),
              Color.fromARGB(241, 160, 160, 160),
            ],
            // begin: const FractionalOffset(0.0, 0.0),
            // end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage("assets/coin.png"),
            height: Get.height * 0.07,
          ),
          Text(
            "Added to wallet",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            height: Get.height * 0.04,
            width: Get.width * 0.18,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                    colors: [Colors.grey.shade200, Colors.grey])),
            child: Center(
              child: Text(
                "Claimed",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ));
}

Widget rewardsButtonLocked(index, title) {
  return Container(
      height: Get.height * 0.180,
      width: Get.width * 0.27,
      decoration: BoxDecoration(
          color: Color.fromARGB(59, 68, 127, 255),
          border: Border.all(color: Colors.white),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(59, 68, 127, 255),
              Color.fromARGB(242, 33, 102, 252),
            ],
            // begin: const FractionalOffset(0.0, 0.0),
            // end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/lock.png"),
            height: Get.height * 0.07,
          ),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ));
}

Widget rewardsButtonUnLocked(index, ad1, ad2, ad3, customsetstate) {
  return Container(
      height: Get.height * 0.180,
      width: Get.width * 0.27,
      decoration: BoxDecoration(
          color: Color.fromARGB(59, 68, 127, 255),
          border: Border.all(color: Colors.white),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(59, 68, 127, 255),
              Color.fromARGB(242, 33, 102, 252),
            ],
            // begin: const FractionalOffset(0.0, 0.0),
            // end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage("assets/gift.png"),
            height: Get.height * 0.07,
          ),
          Text(
            "BRC Coins",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              // index == 0
              //     ? print("====0")
              //     : index == 1
              //         ? print("====1")
              //         : print("====2");
              index == 0
                  ? ad1()
                  : index == 1
                      ? ad2()
                      : ad3();
            },
            child: Container(
              height: Get.height * 0.04,
              width: Get.width * 0.18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(colors: [
                    AppColor.redColor,
                    AppColor.pinkColor,
                    AppColor.purpleColor
                  ])),
              child: Center(
                child: Text(
                  "Claim",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ));
}

Future<void> inviteDialog(context, h, w, link, refcode) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('Your Refral Code')),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Scan And Download MaticLegend"),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  child: QrImageView(
                    data: link,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
              Text("Copy the Refral Code From Below"),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: h * 0.060,
                  width: w * 0.2,
                  // color: Colors.red,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      initialValue: refcode,
                      readOnly: true,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

var data;
Future joinReferal(code) async {
  // void getsharedpref() async {
  final String? id;

  final prefs = await SharedPreferences.getInstance();
  final String? token;
  id = prefs.getString('userid');
  token = prefs.getString('remToken');

  if (token != null) {
    // print("not null");

    var response = await post(
      Uri.parse(AppUrl.joinRefferal),
      body: {"referred_by": code},
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      print(data["message"].toString());
      Get.snackbar(data["message"].toString(), "");
      // print(token);
    } else {
      print("====== not geting new mining data data");
    }
  }
}

Future<void> enterRefCodeDialog(
    context, h, w, TextEditingController joinrefealctrl, isrefferal) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black54,
        title: Center(
            child: Text(
          'I Have Refral Code',
          style: TextStyle(color: Colors.white),
        )),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              // Text("Enter the Refral Code"),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: h * 0.060,
                  width: w * 0.2,
                  // color: Colors.red,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Center(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: joinrefealctrl,

                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          label: Text("Enter Refferal Code"),
                          border: OutlineInputBorder()),
                      // initialValue: refcode,
                      // readOnly: true,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel")),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //   },
          //   child: Container(
          //     height: 30,
          //     width: 80,
          //     child: Center(
          //       child: Text("Cancel"),
          //     ),
          //     decoration: BoxDecoration(
          //         color: Colors.grey.shade100,
          //         borderRadius: BorderRadius.all(Radius.circular(5))),
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //   },
          //   child: Container(
          //     height: 30,
          //     width: 80,
          //     child: Center(
          //       child: Text("Join"),
          //     ),
          //     decoration: BoxDecoration(
          //         color: Colors.blue.shade100,
          //         borderRadius: BorderRadius.all(Radius.circular(5))),
          //   ),
          // ),
          TextButton(
              onPressed: () {
                if (joinrefealctrl.text.isEmpty) {
                  Get.snackbar("Please Enter Referal Code", "");
                } else {
                  isrefferal == false
                      ? joinReferal(joinrefealctrl.text)
                      : Utilsnew.snackbar("You already joined the refferal",
                          "you can't join the second one");
                  Navigator.of(context).pop();
                  joinrefealctrl.clear();
                }
              },
              child: Text("Join"))
        ],
      );
    },
  );
}

Widget attendance(w, h) {
  return Container(
    height: h * 0.180,
    width: w,
    decoration: BoxDecoration(
        // color: Colors.green,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: ElevatedButton(
        onPressed: () {
          Get.to(Attendance());
        },
        child: Text("Attendance")),
  );
}

var claimGiftData;
Future claimGift() async {
  // void getsharedpref() async {
  final String? id;

  final prefs = await SharedPreferences.getInstance();
  final String? token;
  id = prefs.getString('userid');
  token = prefs.getString('remToken');

  if (token != null) {
    // print("not null");

    var response = await http.post(
      Uri.parse(AppUrl.markReadNotificationEndPoint),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      claimGiftData = jsonDecode(response.body.toString());
      print(claimGiftData["message"].toString());
      Get.snackbar("Gift Claimed succesfully", '');
      // fun();
     
      // print(token);
    } else {
      print("====== not geting new mining data data");
    }
  }
}

void showDialogNotification(text,  giftbody) {
  Get.dialog(
    // barrierDismissible: false,
    AlertDialog(
      title: Column(
        children: [
          Text(
            'Congratulations!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'You Received a Gift',
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage("assets/party.gif"),
              height: Get.height * 0.2,
            ),
            Text(
              "${giftbody["Coin"]} BRC",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(text),
            // ElevatedButton(
            //   onPressed: () {
            //     Get.back();
            //     claimGift();
            //   },
            //   child: Text('Claim Gift'),
            // ),
            GestureDetector(
               onTap: () {
                Get.back();
                claimGift();
              },
              child: GlowingButton(text: "Claim",))
          ],
        ),
      ),
      // actions: [
      //   ElevatedButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     child: Text('Claim Gift'),
      //   ),
      // ],
    ),
  );
}
