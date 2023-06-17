// import 'dart:convert';

// import 'dart:io';
// import 'dart:math';
// import 'package:connectivity/connectivity.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:intl/intl.dart';
// import 'package:maticlegend/View/Notification/notification.dart';
// import 'package:maticlegend/View/refferal/refferal.dart';
// import 'package:maticlegend/res/components/internet_exception.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:applovin_max/applovin_max.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:maticlegend/View/HomePage/Widget/newsfull.dart';
// import 'package:maticlegend/View/HomePage/Widget/widget.dart';
// import 'package:maticlegend/View/HomePage/newsdetail.dart';
// import 'package:maticlegend/View/HomePage/update_full.dart';
// import 'package:maticlegend/View/Resources/appurl.dart';
// import 'package:maticlegend/View/Resources/utils.dart';
// import 'package:maticlegend/widget/widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:slide_countdown/slide_countdown.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tzdata;

// import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';

// import '../../Ads/Admob/admob.dart';
// import '../../Ads/AppLovin/applovin.dart';
// import '../../version.dart';
// import '../../view_models/services/no_internet.dart';
// import 'Widget/maticupdatedetail.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var intval = 0;
//   int? date;
//   var userid = "";
//   var usrtoken = "";

//   Future<String> getValue() async {
//     final prefs = await SharedPreferences.getInstance();

//     final userId = prefs.getString("userid");
//     final userToken = prefs.getString("remToken");
//     usrtoken = userId.toString();
//     userid = userToken.toString();

//     return prefs.getString('userid').toString();
//   }

//   var walletdata;
//   Future userWallet() async {
//     // void getsharedpref() async {
//     final String? id;

//     final prefs = await SharedPreferences.getInstance();
//     final String? token;
//     id = prefs.getString('userid');
//     token = prefs.getString('remToken');

//     if (token != null) {
//       // print("not null");

//       var response = await get(
//         Uri.parse(AppUrl.userWallet),
//         // body: {
//         //   "name": name,
//         //   // "password": password,
//         // },
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200) {
//         walletdata = jsonDecode(response.body.toString());
//       } else {
//         print("====== not geting wallet data");
//       }
//     }
//   }

//   var getmining;
//   var kolkataTime;

//   Future kolkatatime() async {
//     final response = await http.get(
//       Uri.parse(
//         AppUrl.getMiningEndPoint,
//       ),
//     );
//     if (response.statusCode == 200) {
//       kolkataTime = jsonDecode(response.body.toString());
//     } else {
//       print("====== not getting current time of kolkata");
//     }
//     // }
//   }

//   late int differenceInHours = 24;
//   Future getMining() async {
//     // void getsharedpref() async {
//     final String? id;

//     final prefs = await SharedPreferences.getInstance();
//     final String? token;
//     id = prefs.getString('userid');
//     token = prefs.getString('remToken');

//     if (token != null) {
//       print("not null");
//       final response = await http.get(
//         Uri.parse(
//           AppUrl.getMiningEndPoint,
//         ),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200) {
//         getmining = jsonDecode(response.body.toString());
//         print(getmining["message_title"]);
//         print(getmining["Mining_Details"]["created_at"]);
//         var createdAt = getmining["Mining_Details"]["created_at"];
//         final kolkata = tz.getLocation('Asia/Kolkata');
//         final now = tz.TZDateTime.now(kolkata);
//         print("Time zone package ============ $now");

//         DateTime myDatetime = DateTime.parse(createdAt);
//         Duration difference = now.difference(myDatetime);
//         differenceInHours = difference.inHours == null ? 0 : difference.inHours;
//         print("===============Hours =========Hours $differenceInHours");

//         var a = 24;
//         var b = int.parse(getmining["Mining_Details"]["hour_count"]);
//         var calculate = a - b;

//         miningDiff = calculate;
//       } else {
//         print("====== Mining fail data");
//       }
//     }
//   }

//   var dataProfile;
//   Future getProfile() async {
//     final String? id;

//     final prefs = await SharedPreferences.getInstance();
//     final String? token;
//     id = prefs.getString('userid');
//     token = prefs.getString('remToken');

//     if (token != null) {
//       print("not null");
//       final response = await http.get(
//         Uri.parse(
//           AppUrl.getuserProfile,
//         ),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200) {
//         dataProfile = jsonDecode(response.body.toString());
//         print(dataProfile["message"]);
//       } else {
//         print("====== not geting data");
//       }
//     }
//   }

//   var version;
//   var versiondata;
//   final adManager = AdManager();
//   @override
//   void initState() {
//     adManager.addAds();
//     getValue();
//     getProfile();
//     getversion().then((value) {
//       if (version != null && version <= 2) {
//       } else {
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => VersionCheck(
//                       versiondata: versiondata,
//                     )));
//       }
//     });
// // retrieveStartTime();

//     userWallet();
//     getMining();

//     super.initState();
//   }

//   var difference = 0;
//   var difinHours = 0;
//   int? miningDiff;

//   var data;
//   var newsdata;

//   Future<void> getNewsApi() async {
//     final response = await http.get(Uri.parse(
//         "https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=COIN,CRYPTO:BTC,FOREX:USD&apikey=6BAFG5AAT28SL25P&sort=LATEST&topics=blockchain"));
//     if (response.statusCode == 200) {
//       newsdata = jsonDecode(response.body.toString());
//     } else {}
//   }

//   Future<void> getBanners() async {
//     final response =
//         await http.get(Uri.parse("https://maticlegend.com/api/banners"));
//     if (response.statusCode == 200) {
//       data = jsonDecode(response.body.toString());
//     } else {}
//   }

//   Future<void> getversion() async {
//     final response =
//         await http.get(Uri.parse("https://maticlegend.com/api/app-version"));
//     if (response.statusCode == 200) {
//       var versionbody = jsonDecode(response.body.toString());
//       versiondata = jsonDecode(response.body.toString());
//       version = int.parse(versionbody["app_version"][0]["version"].toString());

//       print("====vsersion ==== vsrion $version");
//     } else {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;

//     return SafeArea(
//       child: Scaffold(
//         // appBar: AppBar(
//         //   backgroundColor: Colors.transparent,
//         //   elevation: 0,
//         //   leadingWidth: 100,
//         //   leading: Padding(
//         //     padding: const EdgeInsets.only(right: 15.0),
//         //     child: Image(image: AssetImage("assets/blockrium.png")),
//         //   ),
//         //   title: Text(
//         //     "MaticLegend",
//         //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         //   ),
//         //   centerTitle: true,
//         //   actions: [
//         //     InkWell(
//         //       onTap: () {
//         //         Get.to(NotificationPage());
//         //       },
//         //       child: Padding(
//         //         padding: const EdgeInsets.only(right: 15.0),
//         //         child: Image(
//         //           image: AssetImage("assets/notification.png"),
//         //           height: 35,
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: [
//                 FutureBuilder(
//                     future: userWallet(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Shimmer.fromColors(
//                             baseColor: Color.fromARGB(255, 241, 241, 241),
//                             highlightColor: Color.fromARGB(37, 187, 214, 248),
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Container(
//                                   height: 150,
//                                   width: w,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20))),
//                                 ),
//                               ),
//                             ));
//                       } else {
//                         return deailContainer(
//                           h,
//                           w,
//                           walletdata["wallet_balance"].toString(),
//                         );
//                       }
//                     }),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 FutureBuilder(
//                     future: getMining(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Shimmer.fromColors(
//                             baseColor: Color.fromARGB(255, 241, 241, 241),
//                             highlightColor: Color.fromARGB(37, 187, 214, 248),
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Container(
//                                   height: 150,
//                                   width: w,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20))),
//                                 ),
//                               ),
//                             ));
//                       } else {
//                         return Container(
//                           height: h * 0.2,
//                           width: w,
//                           decoration: BoxDecoration(
//                               // color: Colors.green,
//                               image: DecorationImage(
//                                   // image: AssetImage("assets/miningbg.jpg"),
//                                   image: AssetImage("assets/Header.gif"),
//                                   fit: BoxFit.cover,
//                                   opacity: 0.8),
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.4),
//                                   spreadRadius: 2,
//                                   blurRadius: 8,
//                                 ),
//                               ],
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           child: Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   // crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "Mining Will Stop After",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                           color: Colors.white),
//                                     ),
//                                     Container(
//                                       height: 30,
//                                       width: 120,
//                                       // color: Colors.pink,
//                                       child: FutureBuilder(
//                                           future: getMining(),
//                                           builder: (context, snapshot) {
//                                             if (snapshot.connectionState ==
//                                                 ConnectionState.waiting) {
//                                               return Center(
//                                                 child:
//                                                     LoadingAnimationWidget.beat(
//                                                   color: Colors.blue.shade300,
//                                                   size: 25,
//                                                 ),
//                                               );
//                                             } else {
//                                               return ListView.builder(
//                                                 shrinkWrap: true,
//                                                 itemCount: 1,
//                                                 // data["data"].length,
//                                                 itemBuilder:
//                                                     (BuildContext context,
//                                                         int index) {
//                                                   var a = 24;
//                                                   var b = differenceInHours;

//                                                   var calculate = a - b;
//                                                   return Center(
//                                                     child: SlideCountdown(
//                                                       textStyle: TextStyle(
//                                                           color: Colors.black),
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           20)),
//                                                           color: Colors
//                                                               .blue.shade100),
//                                                       onChanged: (value) {},
//                                                       duration: Duration(
//                                                         hours:
//                                                             // differenceInHours,
//                                                             calculate,
//                                                         minutes: 0,
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                               );
//                                             }
//                                           }),
//                                     ),
//                                   ],
//                                 ),
//                                 FutureBuilder(
//                                     future: getMining(),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState ==
//                                           ConnectionState.waiting) {
//                                         return WaveLinearProgressIndicator(
//                                           value: 1.0,
//                                           // color: Colors.amber,
//                                           waveBackgroundColor:
//                                               Color.fromARGB(255, 85, 175, 197),
//                                           enableBounceAnimation: true,
//                                           waveColor: Colors.blue,
//                                           backgroundColor: Colors.grey[150],
//                                           // minHeight: 20,
//                                         );
//                                       } else {
//                                         return ListView.builder(
//                                           shrinkWrap: true,
//                                           itemCount: 1,
//                                           // data["data"].length,
//                                           itemBuilder: (BuildContext context,
//                                               int index) {
//                                             var aa = 24;
//                                             var bb = differenceInHours;

//                                             var calculate = bb / aa * 100 / 100;
//                                             return WaveLinearProgressIndicator(
//                                               value:
//                                                   // 0.5,
//                                                   calculate,
//                                               // color: Colors.amber,
//                                               waveBackgroundColor:
//                                                   Color.fromARGB(
//                                                       255, 85, 175, 197),
//                                               enableBounceAnimation: true,
//                                               waveColor: Colors.blue,
//                                               backgroundColor: Colors.grey[150],
//                                               // minHeight: 20,
//                                             );
//                                           },
//                                         );
//                                       }
//                                     }),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Container(
//                                       height: 40,
//                                       width: 90,
//                                       // color: Colors.pink,
//                                       child: FutureBuilder(
//                                           future: getMining(),
//                                           builder: (context, snapshot) {
//                                             if (snapshot.connectionState ==
//                                                 ConnectionState.waiting) {
//                                               return Center(
//                                                 child:
//                                                     LoadingAnimationWidget.beat(
//                                                   color: Colors.blue.shade300,
//                                                   size: 25,
//                                                 ),
//                                               );
//                                             } else {
//                                               return ListView.builder(
//                                                 shrinkWrap: true,
//                                                 itemCount: 1,
//                                                 // data["data"].length,
//                                                 itemBuilder:
//                                                     (BuildContext context,
//                                                         int index) {
//                                                   return InkWell(
//                                                     onTap: () {
//                                                       // newmining();
//                                                       // getmining["Mining_Details"]
//                                                       //             [
//                                                       //             "button_status"] ==
//                                                       //         "0"
//                                                       //     ?
//                                                       // newmining();
//                                                       // setState(() {});
//                                                       // adManager
//                                                       //     .showRewardedAd();
//                                                       // initializeInterstitialAdsMining();
//                                                       // : Get.snackbar(
//                                                       //     "Mining Already Initialized",
//                                                       //     "");
//                                                     },
//                                                     child: Container(
//                                                       height: 40,
//                                                       width: 90,
//                                                       child: Center(
//                                                         child: Text(
//                                                           // getmining["Mining_Details"]
//                                                           //             [
//                                                           //             "button_status"] ==
//                                                           //         "0"
//                                                           //     ?
//                                                           "Start Mining",
//                                                           // : "Initialized ",
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.white),
//                                                         ),
//                                                       ),
//                                                       decoration: BoxDecoration(
//                                                           boxShadow: [
//                                                             BoxShadow(
//                                                               color: Colors.grey
//                                                                   .withOpacity(
//                                                                       0.4),
//                                                               spreadRadius: 2,
//                                                               blurRadius: 8,
//                                                             ),
//                                                           ],
//                                                           gradient:
//                                                               LinearGradient(
//                                                                   colors: [
//                                                                 Colors.green
//                                                                     .shade200,
//                                                                 Colors.blue
//                                                               ]),
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           6))),
//                                                     ),
//                                                   );
//                                                 },
//                                               );
//                                             }
//                                           }),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//                     }),

//                 SizedBox(
//                   height: 10,
//                 ),

//                 // rewardsContainer2(w, h, initializeInterstitialAdsRewards),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 attendanceContainer(w, h),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 InkWell(
//                     onTap: () {
//                       Get.to(ShareRefferal(
//                         refcode:
//                             dataProfile["user"]["refferal_code"].toString(),
//                       ));
//                     },
//                     child: shareContainer(w, h)),
//                 ListTile(
//                   leading: Text(
//                     "Crypto News",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                   trailing: InkWell(
//                     onTap: () {
//                       Get.to(NewsFull());
//                     },
//                     child: Text(
//                       "See All",
//                       style: TextStyle(fontSize: 17, color: Colors.blue),
//                     ),
//                   ),
//                 ),

//                 Container(
//                   height: h * 0.350,
//                   child: FutureBuilder(
//                       future: getNewsApi(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return LoadingAnimationWidget.beat(
//                             color: Colors.blue.shade300,
//                             size: 35,
//                           );
//                         } else if (snapshot.connectionState ==
//                             ConnectionState.none) {
//                           return Center();
//                         } else {
//                           return ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: newsdata["feed"].length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Get.to(NewsDetailPage(
//                                       image: newsdata["feed"][index]
//                                               ["banner_image"]
//                                           .toString(),
//                                       title: newsdata["feed"][index]["title"]
//                                           .toString(),
//                                       date: newsdata["feed"][index]
//                                               ["time_published"]
//                                           .toString(),
//                                       para:
//                                           //  "",
//                                           newsdata["feed"][index]["summary"]
//                                               .toString(),
//                                       url:
//                                           // "",
//                                           newsdata["feed"][index]["url"]
//                                               .toString(),
//                                       author: "N/A",
//                                     ));
//                                   },
//                                   child: maticUpdate(
//                                       w,
//                                       h,
//                                       newsdata["feed"][index]["banner_image"]
//                                           .toString(),
//                                       newsdata["feed"][index]["title"]
//                                           .toString(),
//                                       newsdata["feed"][index]["time_published"]
//                                           .toString()),
//                                 ),
//                               );
//                             },
//                           );
//                         }
//                       }),
//                 ),
//                 ListTile(
//                   leading: Text(
//                     "MaticLegend Update",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                   trailing: InkWell(
//                     onTap: () {
//                       Get.to(MaticUpdateFull());
//                     },
//                     child: Text(
//                       "See All",
//                       style: TextStyle(fontSize: 17, color: Colors.blue),
//                     ),
//                   ),
//                 ),
//                 // todo: matic news

//                 Container(
//                   height: h * 0.350,
//                   child: FutureBuilder(
//                       future: getBanners(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return LoadingAnimationWidget.beat(
//                             color: Colors.blue.shade300,
//                             size: 35,
//                           );
//                         } else {
//                           return
//                               // Text(data["data"][0]["title"].toString());
//                               ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: data["userData"].length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Get.to(MaticUpdateDetail(
//                                         image: data["userData"][index]["image"]
//                                             .toString(),
//                                         title: data["userData"][index]["title"]
//                                             .toString(),
//                                         date: data["userData"][index]["date"]
//                                             .toString(),
//                                         para: data["userData"][index]
//                                                 ["paragraph"]
//                                             .toString()));
//                                   },
//                                   child: maticUpdate(
//                                       w,
//                                       h,
//                                       data["userData"][index]["image"]
//                                           .toString(),
//                                       data["userData"][index]["title"]
//                                           .toString(),
//                                       data["userData"][index]["date"]
//                                           .toString()),
//                                 ),
//                               );
//                             },
//                           );
//                         }
//                       }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
