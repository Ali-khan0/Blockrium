import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:Blockrium/View/maintenance/maintenance.dart';
import 'package:Blockrium/res/colors/app_colors.dart';
import 'package:Blockrium/version.dart';
import 'package:Blockrium/widget/wallet_widget.dart';
import 'package:Blockrium/widget/widget.dart';
import 'package:adcolony_flutter/adcolony_flutter.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:webview_flutter/webview_flutter.dart';
import 'Ads/Admob/admob.dart';
import 'Ads/Admob/admob_keys.dart';
import 'Ads/AppLovin/applovin.dart';
import 'Ads/Unity/unityads.dart';
import 'View/HomePage/Widget/maticupdatedetail.dart';
import 'View/HomePage/Widget/newsfull.dart';
import 'View/HomePage/Widget/widget.dart';
import 'View/HomePage/newsdetail.dart';
import 'View/HomePage/update_full.dart';
import 'View/Resources/appurl.dart';
import 'View/account_suspend/accountsuspend.dart';
import 'View/refferal/refferal.dart';
import 'main.dart';

class NewChanges extends StatefulWidget {
  const NewChanges({super.key});

  @override
  State<NewChanges> createState() => _NewChangesState();
}

class _NewChangesState extends State<NewChanges> {
  var intval = 0;
  int? date;
  var userid = "";
  var usrtoken = "";

  Future<String> getValue() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getString("userid");
    final userToken = prefs.getString("remToken");
    usrtoken = userId.toString();
    userid = userToken.toString();

    return prefs.getString('userid').toString();
  }

  var walletdata;
  Future userWallet() async {
    // void getsharedpref() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      // print("not null");

      var response = await get(
        Uri.parse(AppUrl.userWallet),
        // body: {
        //   "name": name,
        //   // "password": password,
        // },
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        walletdata = jsonDecode(response.body.toString());
      } else {
        print("====== not geting wallet data");
      }
    }
  }

  var stagedata;
  Future appStage() async {
    var response = await get(
      Uri.parse(AppUrl.appStageEndPoint),
    );
    if (response.statusCode == 200) {
      stagedata = jsonDecode(response.body.toString());
    } else {
      print("====== not geting App Stage data");
    }
  }

  var getmining;
  var kolkataTime;

  Future kolkatatime() async {
    final response = await http.get(
      Uri.parse(
        AppUrl.getMiningEndPoint,
      ),
    );
    if (response.statusCode == 200) {
      kolkataTime = jsonDecode(response.body.toString());
    } else {
      print("====== not getting current time of kolkata");
    }
    // }
  }

  late int differenceInHours = 24;
  Future getMining() async {
    // void getsharedpref() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      print("not null");
      final response = await http.get(
        Uri.parse(
          AppUrl.getMiningEndPoint,
        ),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        getmining = jsonDecode(response.body.toString());
        print(getmining["message_title"]);
        print(getmining["Mining_Details"]["created_at"]);
        var createdAt = getmining["Mining_Details"]["created_at"];
        final kolkata = tz.getLocation('Asia/Kolkata');
        final now = tz.TZDateTime.now(kolkata);
        print("Time zone package ============ $now");

        DateTime myDatetime = DateTime.parse(createdAt);
        Duration difference = now.difference(myDatetime);
        differenceInHours = difference.inHours == null ? 0 : difference.inHours;
        print("===============Hours =========Hours $differenceInHours");

        var a = 24;
        var b = int.parse(getmining["Mining_Details"]["hour_count"]);
        var calculate = a - b;

        miningDiff = calculate;
      } else {
        print("====== Mining fail data");
      }
    }
  }

  var dataProfile;
  Future getProfile() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      print("not null");
      final response = await http.get(
        Uri.parse(
          AppUrl.getuserProfile,
        ),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        dataProfile = jsonDecode(response.body.toString());
        print(dataProfile["message"]);
      } else {
        print("====== not geting data");
      }
    }
  }

  var randomRewardsStatus;
  Future getRewardsStatus() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      print("not null");
      final response = await http.get(
        Uri.parse(
          AppUrl.randomRewardsStatusEndPoint,
        ),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        randomRewardsStatus = jsonDecode(response.body.toString());
        print(randomRewardsStatus["message"]);
      } else {
        print("====== not geting RandomREwardsData");
      }
    }
  }

  // NotificationsSerives notificationsSerives = NotificationsSerives();
  var version;
  var versiondata;
  var isactive;
  var isactivedata;
  var ismaintenancedata;
  var ismaintenance;

  final String interstitialAdUnitId =
      '/22925651469/Mix2ad_app_Blockrium_interstitial';
  late InterstitialAd interstitialAd;

  loadInterstitialAd() async {
    final AdRequest request = AdRequest();
    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print("admob INT ad loaded");
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd() async {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print("AdMob interstitial ad dismissed");
          // Load a new interstitial ad when the previous one is dismissed
          loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('Failed to show interstitial ad: $error');
        },
      );

      await interstitialAd!.show().then((value) => loadInterstitialAd());
    } else {
      print('Interstitial ad is not ready.');
    }
  }

  @override
  void dispose() {
    interstitialAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getValue();
    getProfile();
    getRewardsStatus();
    appStage();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await UnityAdManater.loadUnityAdRWD();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadInterstitialAd();
    });
    getversion().then((value) {
      if (version != null && version <= 14) {
        // 13
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VersionCheck(
                      versiondata: versiondata,
                    )));
      }
    });
// retrieveStartTime();

    getSuspendData().then((value) {
      if (isactive == "1") {
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AccountSuspend()));
      }
    });
    getMaintenaceData().then((value) {
      if (ismaintenance != "5") {
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MaintenancePage()));
      }
    });
    userWallet();
    getMining();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   getGiftData().then((value) {
    //     if (isgift == "") {
    //     } else {
    //       showDialogNotification(isgift, _customSetstate, giftBody);
    //     }
    //   });
    // });
  }

  var difference = 0;
  var difinHours = 0;
  int? miningDiff;

  var data;
  var newsdata;

  Future<void> getNewsApi() async {
    final response =
        await http.get(Uri.parse("https://maticlegend.com/api/get-news"));
    if (response.statusCode == 200) {
      newsdata = jsonDecode(response.body.toString());
    } else {}
  }

  Future<void> getBanners() async {
    final response =
        await http.get(Uri.parse("https://maticlegend.com/api/banners"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  Future<void> getversion() async {
    final response =
        await http.get(Uri.parse("https://maticlegend.com/api/app-version"));
    if (response.statusCode == 200) {
      var versionbody = jsonDecode(response.body.toString());
      versiondata = jsonDecode(response.body.toString());
      version = int.parse(versionbody["app_version"][0]["version"].toString());

      print("====vsersion ==== vsrion $version");
    } else {}
  }

  Future<void> getSuspendData() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    final response = await http.get(
        Uri.parse("https://maticlegend.com/api/auth/is-active"),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var isActiveBody = jsonDecode(response.body.toString());
      isactivedata = jsonDecode(response.body.toString());
      isactive = isActiveBody["is_active"];
    } else {
      print("====Account suspend not working");
    }
  }

  Future<void> getMaintenaceData() async {
    final response = await http.get(
      Uri.parse("https://maticlegend.com/api/app-maintenance"),
    );

    if (response.statusCode == 200) {
      var isMaintenanceBody = jsonDecode(response.body.toString());
      ismaintenancedata = jsonDecode(response.body.toString());
      ismaintenance = isMaintenanceBody["app_maintenance"][0]["id"].toString();
      print("ismaintenance data is here ========= : $ismaintenance");
    } else {
      print("====Account suspend not working");
    }
  }

  var giftBody;
  var isgift;
  Future<void> getGiftData() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    final response = await http.get(Uri.parse(AppUrl.getNotificationEndPoint),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      // var isGiftBody = jsonDecode(response.body.toString());
      giftBody = jsonDecode(response.body.toString());
      isgift = giftBody["notifications"];
    } else {
      print("====Account suspend not working");
    }
  }

  void showNoification(hours, title, body) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "Blockrium",
      "Clound Mining",
      priority: Priority.max,
      importance: Importance.max,
      enableVibration: true,
    );

    DarwinNotificationDetails iosDetails =
        DarwinNotificationDetails(presentAlert: true, presentSound: true);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    DateTime scheduleDate = tz.TZDateTime.now(tz.getLocation('Asia/Kolkata'))
        .add(Duration(hours: hours));
    await notificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.from(
          scheduleDate,
          tz.getLocation('Asia/Kolkata'),
        ),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
  }

  void initializeInterstitialAds_Mining() {
    newmining();
    // UnityAdManater.showRwdAd();
    showInterstitialAd();
  }

  var randomRewardsData;
  Future randomRewards() async {
    // void getsharedpref() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      // print("not null");

      var response = await http.post(
        Uri.parse(AppUrl.randomRewardsEndPoint),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        randomRewardsData = jsonDecode(response.body.toString());
        print(randomRewardsData["message"].toString());
        Get.snackbar(randomRewardsData["message"].toString(),
            "${randomRewardsData["reward"].toString()} Coins Added to Wallet");
        _customSetstate();

        // UnityAdManater.showRwdAd();
        showInterstitialAd();
        // print(token);
      } else {
        print("====== not geting new mining data data");
      }
    }
  }

  var randomRewardsData2;
  Future randomRewards2() async {
    // void getsharedpref() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      // print("not null");

      var response = await http.post(
        Uri.parse(AppUrl.randomRewardsEndPoint),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        randomRewardsData2 = jsonDecode(response.body.toString());
        print(randomRewardsData2["message"].toString());
        Get.snackbar(randomRewardsData2["message"].toString(),
            "${randomRewardsData2["reward"].toString()} Coins Added to Wallet");
        _customSetstate();

        // UnityAdManater.showRwdAd();
        showInterstitialAd();
        // print(token);
      } else {
        print("====== not geting new mining data data");
      }
    }
  }

  var randomRewardsData3;
  Future randomRewards3() async {
    // void getsharedpref() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      // print("not null");

      var response = await http.post(
        Uri.parse(AppUrl.randomRewardsEndPoint),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        randomRewardsData3 = jsonDecode(response.body.toString());
        print(randomRewardsData3["message"].toString());
        Get.snackbar(randomRewardsData3["message"].toString(),
            "${randomRewardsData3["reward"].toString()} Coins Added to Wallet");
        _customSetstate();

        // UnityAdManater.showRwdAd();
        showInterstitialAd();
        // print(token);
      } else {
        print("====== not geting new mining data data");
      }
    }
  }

  Future newmining() async {
    // void getsharedpref() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      // print("not null");

      var response = await http.post(
        Uri.parse(AppUrl.newminingEndPoint),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        newminingdata = jsonDecode(response.body.toString());
        print(newminingdata["message"].toString());
        Get.snackbar(newminingdata["message"].toString(), "");
        showNoification(25, "Your Dear User, Your Mining Has Been Ended",
            "Restart Your Mining Now");
        // UnityAdManater.showRwdAd();
        showInterstitialAd();
        // Future.delayed(Duration(seconds: 2), () {
        // UnityAdManater.showIntAd();
        setState(() {});
        // });
        // print(token);
      } else {
        print("====== not geting new mining data data");
      }
    }
  }

  var newminingdata;

  void _customSetstate() {
    setState(() {});
  }

  // var randomRewardsData;
  // Future randomRewards() async {
  //   // void getsharedpref() async {
  //   final String? id;

  //   final prefs = await SharedPreferences.getInstance();
  //   final String? token;
  //   id = prefs.getString('userid');
  //   token = prefs.getString('remToken');

  //   if (token != null) {
  //     // print("not null");

  //     var response = await http.post(
  //       Uri.parse(AppUrl.randomRewardsEndPoint),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     if (response.statusCode == 200) {
  //       randomRewardsData = jsonDecode(response.body.toString());
  //       print(randomRewardsData["message"].toString());
  //       Get.snackbar(randomRewardsData["message"].toString(),
  //           "${randomRewardsData["reward"].toString()} Coins Added to Wallet");
  //       // fun();
  //       setState(() {});
  //       // print(token);
  //     } else {
  //       print("====== not geting new mining data data");
  //     }
  //   }
  // }
  Shader linearGradient = LinearGradient(
    colors: [AppColor.redColor, AppColor.pinkColor, AppColor.purpleColor],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // backgroundColor: Colors.transparent,
            title: Text(
              "Blockrium",
              style: TextStyle(
                  foreground: Paint()..shader = linearGradient,
                  fontWeight: FontWeight.bold),
            ),

            leading: Image(image: AssetImage("assets/blockrium3.png")),

            pinned: true,
            expandedHeight: Get.height * 0.35,
            flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder(
                  future: userWallet(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError) {
                      return Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 241, 241, 241),
                          highlightColor: Color.fromARGB(37, 187, 214, 248),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 150,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ));
                    } else {
                      return walletWidget(
                          walletdata["wallet_balance"].toString(),
                          context,
                          h,
                          w);
                    }
                  }),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
                child: FutureBuilder(
                    future: getMining(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 241, 241, 241),
                            highlightColor: Color.fromARGB(37, 187, 214, 248),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 150,
                                  width: w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                            ));
                      } else {
                        return Container(
                          height: h * 0.2,
                          width: w,
                          decoration: BoxDecoration(
                              // color: Colors.green,
                              image: DecorationImage(
                                  // image: AssetImage("assets/miningbg.jpg"),
                                  image: AssetImage("assets/Header.gif"),
                                  fit: BoxFit.cover,
                                  opacity: 0.8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  // color: Colors.red,
                                  height: 40,
                                  width: Get.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Mining Will Stop After",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 140,
                                        // color: Colors.pink,
                                        child: FutureBuilder(
                                            future: getMining(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  child: LoadingAnimationWidget
                                                      .beat(
                                                    color: Colors.blue.shade300,
                                                    size: 25,
                                                  ),
                                                );
                                              } else {
                                                return Center(
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.all(0),
                                                    shrinkWrap: true,
                                                    itemCount: 1,
                                                    // data["data"].length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var a = 24;
                                                      var b = differenceInHours;

                                                      var calculate = a - b;
                                                      return Center(
                                                        child: SlideCountdown(
                                                          textStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              gradient:
                                                                  LinearGradient(
                                                                      colors: [
                                                                    AppColor
                                                                        .redColor,
                                                                    AppColor
                                                                        .pinkColor,
                                                                    AppColor
                                                                        .purpleColor
                                                                  ])
                                                                  
                                                                  ),
                                                          onChanged: (value) {},
                                                          duration: Duration(
                                                            hours:
                                                                //  5,
                                                                calculate,
                                                            minutes: 0,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                FutureBuilder(
                                    future: getMining(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return WaveLinearProgressIndicator(
                                          value: 1.0,
                                          // color: Colors.amber,
                                          labelDecoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                AppColor.redColor,
                                                AppColor.pinkColor,
                                                AppColor.purpleColor
                                              ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          waveBackgroundColor:
                                              AppColor.pinkColor,

                                          // Color.fromARGB(78, 130, 98, 170),
                                          enableBounceAnimation: true,
                                          waveColor: AppColor.purpleColor,
                                          backgroundColor: Colors.grey[150],
                                          // minHeight: 20,
                                        );
                                      } else {
                                        return ListView.builder(
                                          padding: EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          itemCount: 1,
                                          // data["data"].length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var aa = 24;
                                            var bb = differenceInHours;

                                            var calculate = bb / aa * 100 / 100;
                                            return WaveLinearProgressIndicator(
                                              value:
                                                  // 0.5,
                                                  differenceInHours >= 24
                                                      ? 0.0
                                                      : calculate,
                                              // color: Colors.amber,
                                              labelDecoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        AppColor.redColor,
                                                        AppColor.pinkColor,
                                                        AppColor.purpleColor
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50))),
                                              waveBackgroundColor:
                                                  AppColor.pinkColor,

                                              // Color.fromARGB(78, 130, 98, 170),
                                              enableBounceAnimation: true,
                                              waveColor: AppColor.purpleColor,
                                              backgroundColor: Colors.grey[150],
                                              // minHeight: 20,
                                            );
                                          },
                                        );
                                      }
                                    }),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 90,
                                      // color: Colors.pink,
                                      child: FutureBuilder(
                                          future: getMining(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    LoadingAnimationWidget.beat(
                                                  color: Colors.blue.shade300,
                                                  size: 25,
                                                ),
                                              );
                                            } else {
                                              return ListView.builder(
                                                padding: EdgeInsets.all(0),
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                // data["data"].length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      // newmining();
                                                      // getmining["Mining_Details"]
                                                      //             [
                                                      //             "button_status"] ==
                                                      //         "0"
                                                      //     ?
                                                      // newmining();
                                                      // setState(() {});
                                                      differenceInHours >= 24
                                                          ? initializeInterstitialAds_Mining()
                                                          :
                                                          // initializeInterstitialAdsMining();
                                                          Get.snackbar(
                                                              "Mining Already Initialized",
                                                              "Please wait for 24 hours");
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 90,
                                                      child: Center(
                                                        child: Text(
                                                          // getmining["Mining_Details"]
                                                          //             [
                                                          //             "button_status"] ==
                                                          //         "0"
                                                          //     ?
                                                          differenceInHours >=
                                                                  24
                                                              ? "Start Mining"
                                                              : "Initialized ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.4),
                                                              spreadRadius: 2,
                                                              blurRadius: 8,
                                                            ),
                                                          ],
                                                          gradient: differenceInHours >=
                                                                  24
                                                              ? LinearGradient(
                                                                  colors: [
                                                                      AppColor
                                                                          .redColor,
                                                                      AppColor
                                                                          .pinkColor,
                                                                      AppColor
                                                                          .purpleColor
                                                                    ])
                                                              : LinearGradient(
                                                                  colors: [
                                                                      Colors
                                                                          .grey,
                                                                      Colors
                                                                          .grey
                                                                    ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          }),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       showInterstitialAd();
              //     },
              //     child: Text(
              //       "SHOW INT ADS",
              //       style: TextStyle(color: Colors.black),
              //     )),
              // Center(
              //   child: _bannerAd != null
              //       ? SizedBox(
              //           width: _bannerAd!.size.width.toDouble(),
              //           height: _bannerAd!.size.height.toDouble(),
              //           child: AdWidget(ad: _bannerAd!),
              //         )
              //       : Container(),
              // ),
// _bannerAd != null
//   Align(
//     alignment: Alignment.bottomCenter,
//     child: SafeArea(
//       child: SizedBox(
//         width: _bannerAd!.size.width.toDouble(),
//         height: _bannerAd!.size.height.toDouble(),
//         child: AdWidget(ad: _bannerAd!),
//       ),
//     ),
//   ):Container(),

              FutureBuilder(
                  future: getRewardsStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError) {
                      return Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 241, 241, 241),
                          highlightColor: Color.fromARGB(37, 187, 214, 248),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 150,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ));
                    } else {
                      return rewardsContainer2(
                          w,
                          h,
                          int.parse(
                              randomRewardsStatus["data"]["status"].toString()),
                          _customSetstate,
                          // initializeInterstitialAdsRewards,
                          // initializeInterstitialAdsRewards_2nd,
                          // initializeInterstitialAdsRewards_3rd
                          // randomRewards(_customSetstate).then(
                          //     (value) => AdColony.request(zones[0], listener)),
                          randomRewards,
                          randomRewards2,
                          randomRewards3
                          // randomRewards(_customSetstate).then(
                          //     (value) => AdColony.request(zones[0], listener)),

                          // randomRewards(_customSetstate).then(
                          //     (value) => AdColony.request(zones[0], listener)),
                          );
                    }
                  }),

              // ElevatedButton(onPressed: randomRewards, child: Text("1")),
              // ElevatedButton(onPressed: randomRewards2, child: Text("2")),
              // ElevatedButton(onPressed: randomRewards3, child: Text("3")),
              attendanceContainer(w, h),

              InkWell(
                  onTap: () {
                    Get.to(ShareRefferal(
                      refcode: dataProfile["user"]["refferal_code"].toString(),
                      username: dataProfile["user"]["name"].toString(),
                    ));
                  },
                  child: shareContainer(w, h)),
              ListTile(
                leading: Text(
                  "Crypto News",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: InkWell(
                  onTap: () {
                    Get.to(NewsFull());
                  },
                  child: Text(
                    "See All",
                    style: TextStyle(fontSize: 17, color: Colors.purple),
                  ),
                ),
              ),

              Container(
                height: h * 0.350,
                child: FutureBuilder(
                    future: getNewsApi(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingAnimationWidget.beat(
                          color: Colors.blue.shade300,
                          size: 35,
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return Center();
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: newsdata["userData"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(NewsDetailPage(
                                    image: newsdata["userData"][index]["image"]
                                        .toString(),
                                    title: newsdata["userData"][index]["title"]
                                        .toString(),
                                    date: newsdata["userData"][index]
                                            ["created_at"]
                                        .toString(),
                                    para:
                                        //  "",
                                        newsdata["userData"][index]
                                                ["description"]
                                            .toString(),
                                    url:
                                        // "",
                                        newsdata["userData"][index]["link"]
                                            .toString(),
                                    author: newsdata["userData"][index]
                                            ["categories"]
                                        .toString(),
                                  ));
                                },
                                child: maticUpdate(
                                    w,
                                    h,
                                    newsdata["userData"][index]["image"]
                                        .toString(),
                                    newsdata["userData"][index]["title"]
                                        .toString(),
                                    newsdata["userData"][index]["created_at"]
                                        .toString()
                                        
                                        ),
                              ),
                            );
                          },
                        );
                      }
                    }),
              ),
              ListTile(
                leading: Text(
                  "Mining Rate",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              // FutureBuilder(
              //     future: appStage(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting ||
              //           snapshot.hasError) {
              //         return Shimmer.fromColors(
              //             baseColor: Color.fromARGB(255, 241, 241, 241),
              //             highlightColor: Color.fromARGB(37, 187, 214, 248),
              //             child: Padding(
              //               padding: const EdgeInsets.all(4.0),
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(10),
              //                 child: Container(
              //                   height: Get.height * 0.3,
              //                   width: Get.width,
              //                   decoration: BoxDecoration(
              //                       color: Colors.white,
              //                       borderRadius:
              //                           BorderRadius.all(Radius.circular(20))),
              //                 ),
              //               ),
              //             ));
              //       } else {
              //         return miningRateContainer(w, h, stagedata);
              //       }
              //     }),

              ListTile(
                leading: Text(
                  "Blockrium Update",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: InkWell(
                  onTap: () {
                    Get.to(MaticUpdateFull());
                  },
                  child: Text(
                    "See All",
                    style: TextStyle(fontSize: 17, color: Colors.purple),
                  ),
                ),
              ),
              // todo: matic news

              Container(
                height: h * 0.350,
                child: FutureBuilder(
                    future: getBanners(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingAnimationWidget.beat(
                          color: Colors.blue.shade300,
                          size: 35,
                        );
                      } else {
                        return
                            // Text(data["data"][0]["title"].toString());
                            ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data["userData"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(MaticUpdateDetail(
                                      image: data["userData"][index]["image"]
                                          .toString(),
                                      title: data["userData"][index]["title"]
                                          .toString(),
                                      date: data["userData"][index]["date"]
                                          .toString(),
                                      para: data["userData"][index]["paragraph"]
                                          .toString()));
                                },
                                child: maticUpdate(
                                    w,
                                    h,
                                    data["userData"][index]["image"].toString(),
                                    data["userData"][index]["title"].toString(),
                                    data["userData"][index]["date"].toString()),
                              ),
                            );
                          },
                        );
                      }
                    }),
              ),
              // Add your scrollable content here
              // ListTile(
              //   title: Text(
              //     "Network",
              //     style: TextStyle(fontSize: 20),
              //   ),
              // ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     networkCard(
              //         "assets/iref.png", "20", "My Team", "No. Of Members"),
              //     networkCard(
              //         "assets/iref.png", "20", "Attendance", "No. Of Members"),
              //   ],
              // ),

              // ListTile(
              //   title: Text(
              //     "Hottest Airdrops",
              //     style: TextStyle(fontSize: 20),
              //   ),
              // ),
              // ListView.builder(
              //   padding: EdgeInsets.all(0),
              //   itemCount: airdrops.length,
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemBuilder: (BuildContext context, int index) {
              //     return ListTile(
              //       leading: CircleAvatar(
              //         backgroundImage: NetworkImage(airdrops[index].toString()),
              //       ),
              //       title: Text(
              //         names[index].toString(),
              //       ),
              //       subtitle: Text(" Value: ~\$2.5 + ref"),
              //       trailing: Text("🔥 1265"),
              //     );
              //   },
              // ),
            ]),
          ),
        ],
      ),
    );
  }
}

Widget balanceButtonWidget(title, asset) {
  return Container(
    height: Get.height * 0.1,
    width: Get.width * 0.22,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromARGB(171, 130, 98, 170),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(
          image: AssetImage(asset),
          height: Get.height * 0.06,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}

Widget networkCard(assets, title, maintitle, subtitle) {
  return Card(
    child: Container(
      height: Get.height * 0.2,
      width: Get.width * 0.440,
      decoration: BoxDecoration(
          color: Color(0xffffaf8f2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          ListTile(
            leading: Image(
              image: AssetImage(assets),
              height: Get.height * 0.05,
            ),
            title: Text(
              maintitle,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
  );
}
