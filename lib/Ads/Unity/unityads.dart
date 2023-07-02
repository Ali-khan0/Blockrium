import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../../view_models/controller/Ads_viewModel/adx_viewmodel.dart';
import '../AppLovin/applovin.dart';

final AdxManagerController adxManagerController = AdxManagerController();

class UnityAdManater {
  static Future<void> loadUnityAdINT() async {
    await UnityAds.load(
      placementId: 'Interstitial_Android',
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  static Future<void> loadUnityAdRWD() async {
    await UnityAds.load(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
    adxManagerController.createInterstitialAd();
  }

  static Future<void> showIntAd() async {
    UnityAds.showVideoAd(
      placementId: 'Interstitial_Android',
      onStart: (placementId) => loadUnityAdINT(),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) => print('Video Ad $placementId completed'),
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }

  static Future<void> showRwdAd() async {
    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => loadUnityAdRWD(),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => adxManagerController.showInterstitialAd(),
      onComplete: (placementId) => adxManagerController.showInterstitialAd(),
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
    // randomRewards(customsetstate);
  }
}
// import 'package:flutter/material.dart';
// import 'package:unity_ads_plugin/unity_ads_plugin.dart';

// import '../../utils/utils.dart';

// class UnityManager {
//   static Future<void> loadUnityIntAd() async {
//     await UnityAds.load(
//       placementId: 'Interstitial_Android',
//       onComplete: (placementId) => print('Load Complete $placementId'),
//       onFailed: (placementId, error, message) =>
//           print('Load Failed $placementId: $error $message'),
//     );
//   }

//   static Future<void> showIntAd() async {
//     UnityAds.showVideoAd(
//         placementId: 'Interstitial_Android',
//         onStart: (placementId) => print('Video Ad $placementId started'),
//         onClick: (placementId) => print('Video Ad $placementId click'),
//         onSkipped: (placementId) => print('Video Ad $placementId skipped'),
//         onComplete: (placementId) async {
//           await loadUnityIntAd();
//         },
//         onFailed: (placementId, error, message) async {
//           await loadUnityIntAd();
//         });
//   }

//   static Future<void> loadUnityRewardedAd() async {
//     await UnityAds.load(
//       placementId: 'Rewarded_Android',
//       onComplete: (placementId) => print('Load Complete $placementId'),
//       onFailed: (placementId, error, message) =>
//           print('Load Failed $placementId: $error $message'),
//     );
//   }

//   static Future<void> showRewardedAd() async {
//     UnityAds.showVideoAd(
//         placementId: 'Rewarded_Android',
//         onStart: (placementId) => print('Video Ad $placementId started'),
//         onClick: (placementId) => print('Video Ad $placementId click'),
//         onSkipped: (placementId) => print('Video Ad $placementId skipped'),
//         onComplete: (placementId) async {
//           await loadUnityRewardedAd();
//         },
//         onFailed: (placementId, error, message) async {
//           await loadUnityRewardedAd();
//         });
//   }

//   static void showRewardedAda(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.white,
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 loadingData(),
//               ],
//             ),
//           ),
//         );
//       },
//     );

//     loadUnityRewardedAd().then((value) {
//       Navigator.pop(context); // Hide the loading dialog

//       UnityAds.showVideoAd(
//         placementId: 'Rewarded_Android',
//         onStart: (placementId) => print('Video Ad $placementId started'),
//         onClick: (placementId) => print('Video Ad $placementId click'),
//         onSkipped: (placementId) => print('Video Ad $placementId skipped'),
//         onComplete: (placementId) async {
//           await loadUnityRewardedAd();
//           // Utils.snackbar("Rewards added to wallet");
//         },
//         onFailed: (placementId, error, message) async {
//           // showDialog(
//           //   context: context,
//           //   builder: (BuildContext context) {
//           //     return AlertDialog(
//           //       // title: Text("Error"),
//           //       content: loadingError(),
//           //       actions: <Widget>[
//           //         TextButton(
//           //           child: Text('Close'),
//           //           onPressed: () {
//           //             Navigator.of(context).pop();
//           //           },
//           //         ),
//           //         TextButton(
//           //           child: Text('Retry'),
//           //           onPressed: () {
//           //             Navigator.of(context).pop();
//           //             showRewardedAda(context);
//           //           },
//           //         ),
//           //       ],
//           //     );
//           //   },
//           // );
//           await loadUnityRewardedAd();
//         },
//       );
//     });
//   }
// }
