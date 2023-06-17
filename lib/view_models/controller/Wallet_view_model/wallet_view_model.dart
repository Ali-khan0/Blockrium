import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../View/Resources/appurl.dart';
import '../../../View/Resources/utils.dart';
import '../../../main.dart';

class WalletViewModel extends GetxController {
  final joinRefealCTRL = TextEditingController().obs;
  var userName = RxString("");
  var profileImg = RxString("");
  var number = RxString("");
  var email = RxString("");
  var refcode = RxString("");

  Future<void> getNameSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("name");
    String? profileimg = prefs.getString("profileimg");
    String? numberR = prefs.getString("phone");
    String? emailL = prefs.getString("email");
    String? refCode = prefs.getString("refCode");
    userName.value = name ?? "";
    profileImg.value = profileimg ?? "";
    number.value = numberR ?? "";
    email.value = emailL ?? "";
    refcode.value = refCode ?? "";
  }

// todo ;  User Wallet Balance get

  var walletData = {}.obs;
  Future<void> userWallet() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('remToken');
    var response = await get(
      Uri.parse(AppUrl.userWallet),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      walletData.value = jsonDecode(response.body.toString());
    } else {
      debugPrint("====== not getting wallet data");
    }
  }

// todo; Start Mining
  var newminingdata = {}.obs;
  Future newmining() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token;

    token = prefs.getString('remToken');
    var response = await http.post(
      Uri.parse(AppUrl.newminingEndPoint),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      newminingdata.value = jsonDecode(response.body.toString());
      print(newminingdata.value["message"].toString());
      Utils.snackbar(newminingdata.value["message"].toString(), "");
      showNoification(25, "Your Dear User, Your Mining Has Been Ended",
          "Restart Your Mining Now");
      showInterstitialAd();
    } else {
      debugPrint("====== not geting new mining data");
    }
  }

// todo
//Get mining detail

  int? miningDiff;
  var getmining = Rx<Map<String, dynamic>>({});

  late int differenceInHours = 24;
  Future getMining() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token;

    token = prefs.getString('remToken');

    final response = await http.get(
      Uri.parse(
        AppUrl.getMiningEndPoint,
      ),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      getmining.value = jsonDecode(response.body.toString());
      print(getmining.value["message_title"]);
      print(getmining.value["Mining_Details"]["created_at"]);
      var createdAt = getmining.value["Mining_Details"]["created_at"];
      final kolkata = tz.getLocation('Asia/Kolkata');
      final now = tz.TZDateTime.now(kolkata);
      print("Time zone package ============ $now");

      DateTime myDatetime = DateTime.parse(createdAt);
      Duration difference = now.difference(myDatetime);
      differenceInHours = difference.inHours == null ? 0 : difference.inHours;
      print("===============Hours =========Hours $differenceInHours");

      var a = 24;
      var b = int.parse(getmining.value["Mining_Details"]["hour_count"]);
      var calculate = a - b;

      miningDiff = calculate;
    } else {
      print("====== Mining fail data");
    }
  }
}

var getmining = {}.obs;

late int differenceInHours = 0;
late int differenceInMinutes = 0;
late int differenceInSeconds = 0;

Future<void> getMining() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token;

  token = prefs.getString('remToken');

  final response = await http.get(
    Uri.parse(AppUrl.getMiningEndPoint),
    headers: {'Authorization': 'Bearer $token'},
  );
  if (response.statusCode == 200) {
    getmining.value = jsonDecode(response.body.toString());
    print(getmining.value["message_title"]);
    print(getmining.value["Mining_Details"]["created_at"]);
    var createdAt = getmining.value["Mining_Details"]["created_at"];
    final kolkata = tz.getLocation('Asia/Kolkata');
    final now = tz.TZDateTime.now(kolkata);
    print("Time zone package ============ $now");

    DateTime myDatetime = DateTime.parse(createdAt);
    Duration difference = now.difference(myDatetime);
    differenceInHours = difference.inHours == null ? 0 : difference.inHours;
    print("===============Hours =========Hours $differenceInHours");
  } else {
    print("====== Mining fail data");
  }
}

// todo; Ohter function data is here

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

// class MiningViewModel extends GetxController {
//   var getmining = {}.obs;

//   late int differenceInHours = 0;
//   late int differenceInMinutes = 0;
//   late int differenceInSeconds = 0;

//   Future<void> getMining() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? token;

//     token = prefs.getString('remToken');

//     final response = await http.get(
//       Uri.parse(AppUrl.getMiningEndPoint),
//       headers: {'Authorization': 'Bearer $token'},
//     );
//     if (response.statusCode == 200) {
//       getmining.value = jsonDecode(response.body.toString());
//       print(getmining.value["message_title"]);
//       print(getmining.value["Mining_Details"]["created_at"]);
//       var createdAt = getmining.value["Mining_Details"]["created_at"];
//       final kolkata = tz.getLocation('Asia/Kolkata');
//       final now = tz.TZDateTime.now(kolkata);
//       print("Time zone package ============ $now");

//       DateTime myDatetime = DateTime.parse(createdAt);
//       Duration difference = now.difference(myDatetime);
//       differenceInHours = difference.inHours == null ? 0 : difference.inHours;
//       print("===============Hours =========Hours $differenceInHours");
//     } else {
//       print("====== Mining fail data");
//     }
//   }
// }
