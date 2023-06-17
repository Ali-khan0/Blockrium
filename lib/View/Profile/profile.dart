import 'dart:convert';
import 'package:Blockrium/View/Profile/whitepaper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/colors/app_colors.dart';
import '../../widget/widget.dart';
import '../Notification/notification.dart';
import '../Resources/appurl.dart';
import '../Resources/utils.dart';
import '../Streak/streak.dart';
import '../Team/team.dart';
import '../Terms & Policy & About us/terms_policy.dart';
import '../../View new/authentication/loginpage.dart';
import '../refferal/refferal.dart';
import 'delete_acc_.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

var data;

final client = http.Client();

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();

    getProfile();
  }

  Future getProfile() async {
    // void getsharedpref() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');
// }
    print("userid ============ $id");

    print("remToken ============ $token");
    if (token != null) {
      print("not null");
      final response = await http.get(
        Uri.parse(
          AppUrl.getuserProfile,
        ),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        print(data["message"]);
      } else {
        print("====== not geting data");
      }
    }
  }

  void logout() async {
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
        Utils.snackbar("Logout Successfully", "");
        Get.offAll(LoginPage());
        // print(
        //     "account created successfully: Name: $name, password: $password, email: $email, gymLocation: $gymLoc ");
      } else {
        Utils.snackbar("Something went wrong", "");
        // Utils.scaffoldmessenger(context, "Failed to create Account");
      }
    } catch (e) {
      Utils.snackbar("Something went wrong", "");
      // Utils.scaffoldmessenger(context, "Something went wrong");
    }
  }

  TextEditingController joinRefealCTRL = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 80,
        elevation: 0,
        // leadingWidth: 100,
        leading: Image(image: AssetImage("assets/blockrium3.png")),

        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.red,
                    // image: DecorationImage(
                    //     opacity: 0.1,
                    //     image: AssetImage("assets/blockrium.png"),
                    //     fit: BoxFit.fitWidth)
                    ),
                height: h * 0.150,
                width: w * 0.95,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: h * 0.150,
                      width: w * 0.9,
                      child: FutureBuilder(
                          future: getProfile(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: LoadingAnimationWidget.beat(
                                  color: Colors.purple.shade300,
                                  size: 35,
                                ),
                              );
                            } else {
                              return

                                  // Text(data["data"][0]["title"].toString());
                                  ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                // data["data"].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 12.0, right: 20.0),
                                        child: CircleAvatar(
                                            radius: Get.height * 0.060,
                                            backgroundColor: Colors.white,
                                            backgroundImage:
                                                AssetImage("assets/avatar.jpg")
                                            //  data[
                                            //             "user"]["user_image"] ==
                                            //         "null"
                                            //     ? AssetImage("assets/avatar.jpg") : data["user"]["user_image"]
                                            // // NetworkImage( "https://www.shareicon.net/data/512x512/2016/07/26/802001_man_512x512.png"
                                            //     ),
                                            ),
                                      ),
                                      Container(
                                        height: h * 0.150,
                                        width: w * 0.550,
                                        // color: Colors.red,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data["user"]["name"]
                                                .toString()
                                                .toUpperCase()),
                                            Text(data["user"]["username"]
                                                .toString()),
                                            Text(data["user"]["email"]
                                                .toString()),
                                            InkWell(
                                              onTap: () {
                                                // print(data["message"].toString());
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProfile(
                                                            appbartitle:
                                                                "Update Password",
                                                          )),
                                                );
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 150,
                                                child: Center(
                                                  child:
                                                      Text("Update Password"),
                                                ),
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      AppColor.redColor,
                                                      AppColor.pinkColor,
                                                      AppColor.purpleColor,
                                                    ]),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 8,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  logout();
                },
                child: customListile("assets/signout1.png", "Signout",
                    "Signout from your account without loosing data ")),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamPage()),
                );
              },
              child: customListile(
                  "assets/team.png", "Team", "Chat with your team"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StreakPage()),
                );
              },
              child: customListile(
                  "assets/streak.png", "Top Users", "See who is on Top"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              child: customListile("assets/notification.png", "Notification",
                  "Get Update About the App"),
            ),
            InkWell(
                onTap: () {
                  Get.to(ShareRefferal(
                    refcode: data["user"]["refferal_code"].toString(),
                    username: data["user"]["name"].toString(),
                  ));
                  // inviteDialog(
                  //     context,
                  //     h,
                  //     w,
                  //     "https://play.google.com/store/apps/details?id=com.maticlegend.web3",
                  //     data["user"]["refferal_code"].toString());
                  // _showMyDialog(context, h, w);
                },
                child: customListile("assets/connect.png", "Referral Code",
                    "Get your referral Code")),
            InkWell(
              onTap: () {
                // _showMyDialog(context, h, w);
                print(data["is_referred_by"]);
                enterRefCodeDialog(
                    context, h, w, joinRefealCTRL, data["is_referred_by"]);
              },
              child: customListile("assets/iref.png", "I've referral Code",
                  "Enter the referral code you got"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PolicyTerms()),
                );
              },
              child: customListile("assets/privacy.png", "Privacy Policy",
                  "Blockrium Privacy & Policy"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WhitePaper()),
                );
              },
              child: customListile("assets/whitepaper.png", "White Paper",
                  "Blockrium White Paper"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteAccount()),
                );
              },
              child: customListile("assets/delete.png", "Delete Account",
                  "Request for deletion of account"),
            ),
            // InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => AboutUs()),
            //       );
            //     },
            //     child: customListile(
            //         Icons.info, "About Us", "Read about MaticLegend")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Join the Squad",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              width: w * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      if (1 == 1) {
                        await launch(
                            "https://twitter.com/maticLegend?t=K1rq9UxfIWUPvPRmid8PFA&s=09",
                            forceWebView: false);
                      } else {
                        throw Utils.snackbar(
                            "Something went wrong", "Unable to get the data");
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        "assets/twitter2.png",
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (1 == 1) {
                        await launch("https://t.me/maticlegend",
                            forceWebView: false);
                      } else {
                        throw Utils.snackbar(
                            "Something went wrong", "Unable to get the data");
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/telegram.png"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (1 == 1) {
                        await launch("https://discord.gg/cgPj5cTH",
                            forceWebView: false);
                      } else {
                        throw Utils.snackbar(
                            "Something went wrong", "Unable to get the data");
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/discord.png"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget customListile(icon, title, subtitle) {
  return ListTile(
    leading: Image(
      image: AssetImage(icon),
      height: 35,
    ),
    subtitle: Text(subtitle),
    trailing: Icon(
      Icons.keyboard_arrow_right,
      size: 30,
    ),
    title: Text(title),
  );
}

Future<void> showMyDialogCommingSoon(context, h, w) async {
  return showDialog(
      context: context,
      builder: (_) => new Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: new Container(
                alignment: FractionalOffset.center,
                height: h * 0.8,
                width: w,
                child: new Image.asset(
                  'assets/comingsoon.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ));
}
