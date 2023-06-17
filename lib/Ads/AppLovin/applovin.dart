import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/Profile/edit_profile.dart';
import '../../View/Resources/appurl.dart';
import '../../View/Resources/utils.dart';

var _interstitialRetryAttempt = 0;

initializeInterstitialAdsRewards(customsetstate) {
  // AppLovinMAX.setInterstitialListener(InterstitialListener(
  //   onAdLoadedCallback: (ad) async {
  //     bool isReady =
  //         (await AppLovinMAX.isInterstitialReady("45363c584e759a66"))!;
  //     if (isReady) {
  //       AppLovinMAX.showInterstitial("45363c584e759a66");
  //     }
  //     // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
  //     print('Interstitial ad loaded from ' + ad.networkName);

  //     // Reset retry attempt
  //     _interstitialRetryAttempt = 0;
  //   },
  //   onAdLoadFailedCallback: (adUnitId, error) {
  //     // Interstitial ad failed to load
  //     // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
  //     _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

  //     int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();

  //     print('Interstitial ad failed to load with code ' +
  //         error.code.toString() +
  //         ' - retrying in ' +
  //         retryDelay.toString() +
  //         's');

  //     Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
  //       AppLovinMAX.loadInterstitial("45363c584e759a66");
  //     });
  //   },
  //   onAdDisplayedCallback: (ad) {},
  //   onAdDisplayFailedCallback: (ad, error) {},
  //   onAdClickedCallback: (ad) {},
  //   onAdHiddenCallback: (ad) {
    
  randomRewards(customsetstate);
  //   },
  // ));

  // // Load the first interstitial
  // AppLovinMAX.loadInterstitial("45363c584e759a66");
}

var randomRewardsData;
Future randomRewards(customsetstate) async {
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
      customsetstate();
      // print(token);
    } else {
      print("====== not geting new mining data data");
    }
  }
}

var _interstitialRetryAttempt_2nd = 0;

initializeInterstitialAdsRewards_2nd(customsetstate) {
  // AppLovinMAX.setInterstitialListener(InterstitialListener(
  //   onAdLoadedCallback: (ad) async {
  //     bool isReady =
  //         (await AppLovinMAX.isInterstitialReady("cbd31ae313bb1dbb"))!;
  //     if (isReady) {
  //       AppLovinMAX.showInterstitial("cbd31ae313bb1dbb");
  //     }
  //     // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
  //     print('Interstitial ad loaded from ' + ad.networkName);

  //     // Reset retry attempt
  //     _interstitialRetryAttempt_2nd = 0;
  //   },
  //   onAdLoadFailedCallback: (adUnitId, error) {
  //     // Interstitial ad failed to load
  //     // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
  //     _interstitialRetryAttempt_2nd = _interstitialRetryAttempt_2nd + 1;

  //     int retryDelay = pow(2, min(6, _interstitialRetryAttempt_2nd)).toInt();

  //     print('Interstitial ad failed to load with code ' +
  //         error.code.toString() +
  //         ' - retrying in ' +
  //         retryDelay.toString() +
  //         's');

  //     Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
  //       AppLovinMAX.loadInterstitial("cbd31ae313bb1dbb");
  //     });
  //   },
  //   onAdDisplayedCallback: (ad) {},
  //   onAdDisplayFailedCallback: (ad, error) {},
  //   onAdClickedCallback: (ad) {},
  //   onAdHiddenCallback: (ad) {

  randomRewards(customsetstate);
  //   },
  // ));

  // // Load the first interstitial
  // AppLovinMAX.loadInterstitial("cbd31ae313bb1dbb");
}

var _interstitialRetryAttempt_3rd = 0;

initializeInterstitialAdsRewards_3rd(customsetstate) {
  // AppLovinMAX.setInterstitialListener(InterstitialListener(
  //   onAdLoadedCallback: (ad) async {
  //     bool isReady =
  //         (await AppLovinMAX.isInterstitialReady("a0a04b6b50a1507a"))!;
  //     if (isReady) {
  //       AppLovinMAX.showInterstitial("a0a04b6b50a1507a");
  //     }
  //     // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
  //     print('Interstitial ad loaded from ' + ad.networkName);

  //     // Reset retry attempt
  //     _interstitialRetryAttempt_3rd = 0;
  //   },
  //   onAdLoadFailedCallback: (adUnitId, error) {
  //     // Interstitial ad failed to load
  //     // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
  //     _interstitialRetryAttempt_3rd = _interstitialRetryAttempt_3rd + 1;

  //     int retryDelay = pow(2, min(6, _interstitialRetryAttempt_3rd)).toInt();

  //     print('Interstitial ad failed to load with code ' +
  //         error.code.toString() +
  //         ' - retrying in ' +
  //         retryDelay.toString() +
  //         's');

  //     Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
  //       AppLovinMAX.loadInterstitial("a0a04b6b50a1507a");
  //     });
  //   },
  //   onAdDisplayedCallback: (ad) {},
  //   onAdDisplayFailedCallback: (ad, error) {},
  //   onAdClickedCallback: (ad) {},
  //   onAdHiddenCallback: (ad) {
      randomRewards(customsetstate);
  //   },
  // ));

  // // Load the first interstitial
  // AppLovinMAX.loadInterstitial("a0a04b6b50a1507a");
}

// void dailyReward() async {
//   // void getsharedpref() async {
//   // final String? id;
//   var coints = "2";
//   final prefs = await SharedPreferences.getInstance();
//   final String? token;
//   // id = prefs.getString('userid');
//   token = await prefs.getString('remToken').toString();

//   if (token != null) {

//     var response = await http.post(
//       Uri.parse(AppUrl.randomRewardsEndPoint),

//       headers: {'Authorization': 'Bearer $token'},
//     );
//     if (response.statusCode == 200) {
//       data = jsonDecode(response.body.toString());
//       Utils.snackbar(data["message"].toString(), "");
//     } else {
//       Utils.snackbar("Something went wrong", "");
//     }
//   }
// }

var _interstitialRetryAttempt1 = 0;

initializeInterstitialAdsRewardsRandomRewards(customsetstate) {
  // AppLovinMAX.setInterstitialListener(InterstitialListener(
  //   onAdLoadedCallback: (ad) async {
  //     bool isReady =
  //         (await AppLovinMAX.isInterstitialReady("d4ef0ab99a244ff0"))!;
  //     if (isReady) {
  //       AppLovinMAX.showInterstitial("d4ef0ab99a244ff0");
  //     }
  //     // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
  //     print('Interstitial ad loaded from ' + ad.networkName);

  //     // Reset retry attempt
  //     _interstitialRetryAttempt1 = 0;
  //   },
  //   onAdLoadFailedCallback: (adUnitId, error) {
  //     // Interstitial ad failed to load
  //     // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
  //     _interstitialRetryAttempt1 = _interstitialRetryAttempt1 + 1;

  //     int retryDelay = pow(2, min(6, _interstitialRetryAttempt1)).toInt();

  //     print('Interstitial ad failed to load with code ' +
  //         error.code.toString() +
  //         ' - retrying in ' +
  //         retryDelay.toString() +
  //         's');

  //     Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
  //       AppLovinMAX.loadInterstitial("d4ef0ab99a244ff0");
  //     });
  //   },
  //   onAdDisplayedCallback: (ad) {},
  //   onAdDisplayFailedCallback: (ad, error) {},
  //   onAdClickedCallback: (ad) {},
  //   onAdHiddenCallback: (ad) {
      randomRewards(customsetstate);
  //   },
  // ));

  // // Load the first interstitial
  // AppLovinMAX.loadInterstitial("d4ef0ab99a244ff0");
}
