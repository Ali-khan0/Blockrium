import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../res/Colorsnew/appcolors.dart';
import '../../utils/utils.dart';

class StreakPage extends StatefulWidget {
  const StreakPage({super.key});

  @override
  State<StreakPage> createState() => _StreakPageState();
}

var minerData;
Future<void> getMiners() async {
  final String? id;
  final prefs = await SharedPreferences.getInstance();
  final String? token;
  id = prefs.getString('userid');
  token = prefs.getString('remToken');
  if (id != null) {
    final response = await http
        .get(Uri.parse("https://maticlegend.com/api/top-miners?userId=$id"));
    if (response.statusCode == 200) {
      minerData = jsonDecode(response.body.toString());
      print(minerData);
    } else {
      print("not getting data of TOp miners");
    }
  }
}

var refferalData;
Future<void> refferalMiners() async {
  final String? id;
  final prefs = await SharedPreferences.getInstance();
  final String? token;
  id = prefs.getString('userid');
  token = prefs.getString('remToken');
  if (id != null) {
    final response = await http
        .get(Uri.parse("https://maticlegend.com/api/top-refferals?userId=$id"));
    if (response.statusCode == 200) {
      refferalData = jsonDecode(response.body.toString());
      print(refferalData);
    } else {
      print("not getting data of TOp Refferal");
    }
  }
}

class _StreakPageState extends State<StreakPage> {
  @override
  void initState() {
    super.initState();
    getMiners();
    refferalMiners();
  }

  var active = "miners";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // brightness: Brightness.light,
          // toolbarHeight: 80,
          scrolledUnderElevation: 0,
          backgroundColor: Color(0xff1B232A).withAlpha(200), elevation: 0,
          // leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white.withOpacity(0.4)),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text(
            "Top Users",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 15.0),
          //     child: Padding(
          //       padding: EdgeInsets.only(right: 15.0),
          //       child: Image(
          //         image: AssetImage("assets/notification.png"),
          //         height: 35,
          //       ),
          //     ),
          //   ),
          // ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.08),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   height: Get.height * 0.08,
                  //   width: Get.width * 0.5,
                  //   color: Colors.red,
                  // )
                  InkWell(
                    onTap: () {
                      setState(() {
                        active = "miners";
                      });
                    },
                    child: Text(
                      "Top Miners",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: active == "miners"
                              ? AppColor.purpleColor
                              : Colors.white54),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        active = "refferal";
                      });
                    },
                    child: Text(
                      "Top Referrals",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: active == "refferal"
                              ? AppColor.purpleColor
                              : Colors.white54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: active == "miners"
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      // color: Colors.white54,
                      child: Column(
                        children: [
                          FutureBuilder(
                              future: getMiners(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return loading(Get.width, Get.height);
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
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // var newindex = index + 1;
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white38),
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  AppColor.purpleColor
                                                      .withOpacity(0.2),
                                                  AppColor.pinkColor
                                                      .withOpacity(0.2)
                                                ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: ListTile(
                                            trailing: Text(
                                              "${minerData["data"]["authUserMiner"]["total"].toString()} BRC",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            title: Row(
                                              children: [
                                                Text(
                                                  minerData["data"]
                                                              ["authUserMiner"]
                                                          ["name"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  minerData["data"][
                                                                  "authUserMiner"]
                                                              ["position"] <=
                                                          5
                                                      ? "🔥"
                                                      : "",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            leading: Text(
                                              minerData["data"]["authUserMiner"]
                                                      ["position"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      );
                                    },
                                  );
                                }
                              }),
                          FutureBuilder(
                              future: getMiners(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: Get.height * 0.8,
                                    child: Center(
                                        child: loading(Get.width, Get.height)),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Center();
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    // scrollDirection: Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        minerData["data"]["top50Miners"].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // var newindex = index + 1;
                                      return ListTile(
                                          trailing: Text(
                                            "${minerData["data"]["top50Miners"][index]["total"].toString()} BRC",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          title: Row(
                                            children: [
                                              Text(
                                                minerData["data"]["top50Miners"]
                                                        [index]["name"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(minerData["data"]
                                                              ["top50Miners"]
                                                          [index]["position"] <=
                                                      5
                                                  ? "🔥"
                                                  : "")
                                            ],
                                          ),
                                          leading: Text(
                                            minerData["data"]["top50Miners"]
                                                    [index]["position"]
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ));
                                    },
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            :

            // todo reffeal
            SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      // color: Colors.white54,
                      child: Column(
                        children: [
                          FutureBuilder(
                              future: refferalMiners(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: loading(Get.width, Get.height));
                             
                                } else if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Center();
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                  
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white38),
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  AppColor.purpleColor
                                                      .withOpacity(0.2),
                                                  AppColor.pinkColor
                                                      .withOpacity(0.2)
                                                ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: ListTile(
                                            trailing: Text(
                                              "${refferalData["data"]["authUserMiner"]["total"].toString()} BRC",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            title: Row(
                                              children: [
                                                Text(
                                                  refferalData["data"]
                                                              ["authUserMiner"]
                                                          ["name"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  refferalData["data"][
                                                                  "authUserMiner"]
                                                              ["position"] <=
                                                          5
                                                      ? "🔥"
                                                      : "",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            leading: Text(
                                              refferalData["data"]
                                                          ["authUserMiner"]
                                                      ["position"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      );
                                    },
                                  );
                                }
                              }),
                          FutureBuilder(
                              future: getMiners(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: Get.height * 0.8,
                                    child: Center(
                                        child: loading(Get.width, Get.height)),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Center();
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    // scrollDirection: Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: refferalData["data"]
                                            ["top50Miners"]
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // var newindex = index + 1;
                                      return ListTile(
                                          trailing: Text(
                                            "${refferalData["data"]["top50Miners"][index]["total"].toString()} BRC",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          title: Row(
                                            children: [
                                              Text(
                                                refferalData["data"]
                                                            ["top50Miners"]
                                                        [index]["name"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(refferalData["data"]
                                                              ["top50Miners"]
                                                          [index]["position"] <=
                                                      5
                                                  ? "🔥"
                                                  : "")
                                            ],
                                          ),
                                          leading: Text(
                                            refferalData["data"]["top50Miners"]
                                                    [index]["position"]
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ));
                                    },
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
