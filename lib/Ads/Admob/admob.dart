import 'dart:async';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  // static String get bannerAdUnitId => Platform.isAndroid
  //     ? "ca-app-pub-4779440453496971/4286452459"
  //     : "ca-app-pub-4779440453496971/4286452459";

  // static initialize() {
  //   if (MobileAds.instance == null) {
  //     MobileAds.instance.initialize();
  //   }
  // }

//   static Future<BannerAd?> createBannerAd() async {
//     BannerAd ad = new BannerAd(
//       size: AdSize.largeBanner,
//       adUnitId: bannerAdUnitId,
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) => print("Ad Loaded Banner"),
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//         },
//         onAdOpened: (ad) => print("ad Opened Banner"),
//         onAdClosed: (ad) => print("Banner Ad CLosed"),
//       ),
//       request: AdRequest(),
//     );

//     final Completer<BannerAd?> completer = Completer<BannerAd?>();

//     ad.load().then((value) {
//       completer.complete(ad);
//     }).catchError((error) {
//       completer.complete(null);
//     });

//     return completer.future;
//   }
}

class AdManager {
  // BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  // RewardedAd? _rewardedAd;
  // RewardedAd? _rewardedAd1;
  // RewardedAd? _rewardedAd3;

  // void loadBannerAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: Platform.isIOS
  //         ? "ca-app-pub-3940256099942544/6300978111"
  //         : "ca-app-pub-3940256099942544/6300978111",
  //     size: AdSize.banner,
  //     request: const AdRequest(),
  //     listener: const BannerAdListener(),
  //   );

  //   _bannerAd?.load();
  // }

  // void loadRewardedAd() {
  //   RewardedAd.load(
  //       adUnitId: Platform.isIOS
  //           ? "ca-app-pub-3940256099942544/5224354917"
  //           : "ca-app-pub-3940256099942544/5224354917",
  //       // test id
  //       // ? "ca-app-pub-3940256099942544/5224354917"
  //       // : "ca-app-pub-3940256099942544/5224354917",
  //       request: const AdRequest(),
  //       rewardedAdLoadCallback:
  //           RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
  //         _rewardedAd = ad;
  //       }, onAdFailedToLoad: (LoadAdError error) {
  //         _rewardedAd = null;
  //       }));
  // }

  // void loadRewardedAdReward1() {
  //   RewardedAd.load(
  //       adUnitId: Platform.isIOS
  //           ? "ca-app-pub-3940256099942544/5224354917"
  //           : "ca-app-pub-3940256099942544/5224354917",
  //       // test id
  //       // ? "ca-app-pub-3940256099942544/5224354917"
  //       // : "ca-app-pub-3940256099942544/5224354917",
  //       request: const AdRequest(),
  //       rewardedAdLoadCallback:
  //           RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
  //         _rewardedAd1 = ad;
  //       }, onAdFailedToLoad: (LoadAdError error) {
  //         _rewardedAd1 = null;
  //       }));
  // }

  // void loadRewardedAdReward3() {
  //   RewardedAd.load(
  //       adUnitId: Platform.isIOS
  //           ? "ca-app-pub-3940256099942544/5224354917"
  //           : "ca-app-pub-3940256099942544/5224354917",
  //       // test id
  //       // ? "ca-app-pub-3940256099942544/5224354917"
  //       // : "ca-app-pub-3940256099942544/5224354917",
  //       request: const AdRequest(),
  //       rewardedAdLoadCallback:
  //           RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
  //         _rewardedAd3 = ad;
  //       }, onAdFailedToLoad: (LoadAdError error) {
  //         _rewardedAd3 = null;
  //       }));
  // }

  void loadInterstitialAd() {
    String interstitialAdId = Platform.isIOS
        ? "/22925651469/Mix2ad_app_Blockrium_interstitial"
        : "ca-app-pub-3940256099942544/1033173712";

    InterstitialAd.load(
        adUnitId: interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (InterstitialAd ad) {
                ad.dispose();
                loadInterstitialAd();
              },
              onAdFailedToShowFullScreenContent:
                  (InterstitialAd ad, AdError error) {
                ad.dispose();
                loadInterstitialAd();
              },
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void addAds(
      // bool interstitial, bool bannerAd, bool rewarded
      ) {
    // if (false) {
    //   loadInterstitialAd();
    // }

    // if (false) {
    // loadBannerAd();
    // }

    // if (true) {
    // loadRewardedAd();

    // loadRewardedAdReward1();
    // loadRewardedAdReward3();
    // }
  }

  void showInterstitial() {
    _interstitialAd?.show();
  }

  // BannerAd? getBannerAd() {
  //   return _bannerAd;
  // }

  // void showNoification(hours, title, body) async {
  //   // Create a Bitmap image from a file
  //   // final String imagePath =
  //   //     'assets/splash1.png'; // replace with the path of your image
  //   // final DrawableResourceAndroidBitmap largeIcon =
  //   //     DrawableResourceAndroidBitmap("assets/splash1.png");
  //   AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
  //     "MaticLegend", "Clound Mining",
  //     priority: Priority.max,
  //     importance: Importance.max,
  //     enableVibration: true,
  //     // largeIcon: largeIcon,
  //     //  sound: RawResourceAndroidNotificationSound('my_ringtone'),
  // );

  //   DarwinNotificationDetails iosDetails =
  //       DarwinNotificationDetails(presentAlert: true, presentSound: true);

  //   NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidDetails, iOS: iosDetails);
  //   DateTime scheduleDate = tz.TZDateTime.now(tz.getLocation('Asia/Kolkata'))
  //       .add(Duration(minutes: hours));
  //   await notificationsPlugin.zonedSchedule(
  //       0,
  //       title,
  //       body,
  //       tz.TZDateTime.from(
  //         scheduleDate,
  //         tz.getLocation('Asia/Kolkata'),
  //       ),
  //       notificationDetails,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.wallClockTime,
  //       androidAllowWhileIdle: true);
  // }

  // Future newmining(setstate) async {
  //   // void getsharedpref() async {
  //   final String? id;

  //   final prefs = await SharedPreferences.getInstance();
  //   final String? token;
  //   id = prefs.getString('userid');
  //   token = prefs.getString('remToken');

  //   if (token != null) {
  //     // print("not null");

  //     var response = await http.post(
  //       Uri.parse(AppUrl.newminingEndPoint),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     if (response.statusCode == 200) {
  //       newminingdata = jsonDecode(response.body.toString());
  //       print(newminingdata["message"].toString());
  //       Get.snackbar(newminingdata["message"].toString(), "");
  //       showNoification(10, "Your Dear User, Your Mining Has Been Ended",
  //           "Restart Your Mining Now");
  //       setstate();
  //       // print(token);
  //     } else {
  //       print("====== not geting new mining data data");
  //     }
  //   }
  // }

  // var newminingdata;
  // void showRewardedAd(setstate) {
  //   if (_rewardedAd != null) {
  //     _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
  //         onAdShowedFullScreenContent: (RewardedAd ad) {
  //       print("Ad onAdShowedFullScreenContent");
  //     }, onAdDismissedFullScreenContent: (RewardedAd ad) {
  //       ad.dispose();
  //       loadRewardedAd();

  //     }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
  //       ad.dispose();
  //       loadRewardedAd();
  //     });

  //     _rewardedAd!.setImmersiveMode(true);
  //     _rewardedAd!.show(
  //         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
  //       // newmining();
  //       print("================= ${reward.amount} ${reward.type}");
  //     });
  //   }
  // }

  // void showRewardedAd1() {
  //   if (_rewardedAd1 != null) {
  //     _rewardedAd1!.fullScreenContentCallback = FullScreenContentCallback(
  //         onAdShowedFullScreenContent: (RewardedAd ad) {
  //       print("Ad onAdShowedFullScreenContent");
  //     }, onAdDismissedFullScreenContent: (RewardedAd ad) {
  //       ad.dispose();
  //       loadRewardedAdReward1();

  //     }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
  //       ad.dispose();
  //       loadRewardedAdReward1();
  //     });

  //     _rewardedAd1!.setImmersiveMode(true);
  //     _rewardedAd1!.show(
  //         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
  //       // randomRewards();
  //       print("================= ${reward.amount} ${reward.type}");
  //     });
  //   }
  // }

  // showRewardedAd3() {
  //   if (_rewardedAd3 != null) {
  //     _rewardedAd3!.fullScreenContentCallback = FullScreenContentCallback(
  //         onAdShowedFullScreenContent: (RewardedAd ad) {
  //       print("Ad onAdShowedFullScreenContent");
  //     }, onAdDismissedFullScreenContent: (RewardedAd ad) {
  //       ad.dispose();
  //       loadRewardedAdReward3();

  //     }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
  //       ad.dispose();
  //       loadRewardedAdReward3();
  //     });

  //     _rewardedAd3!.setImmersiveMode(true);
  //     _rewardedAd3!.show(
  //         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
  //       print("================= ${reward.amount} ${reward.type}");
  //       // randomRewards();
  //     });
  //   }
  // }

  void disposeAds() {
    // _bannerAd?.dispose();
    _interstitialAd?.dispose();
    // _rewardedAd?.dispose();
    // _rewardedAd1?.dispose();
    // _rewardedAd3?.dispose();
  }
}

class AdmobSErvice {
  static String get bannerAdUnitId => Platform.isAndroid
      ? "/22925651469/Mix2ad_app_Blockrium_banner"
      // ? "ca-app-pub-3940256099942544/6300978111"
      : "/22925651469/Mix2ad_app_Blockrium_banner";

  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }


  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
        size: AdSize.largeBanner,
        adUnitId: bannerAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) => print("Ad Loaded Banner"),
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
          onAdOpened: (ad) => print("ad Opened Banner"),
          onAdClosed: (ad) => print("Banner Ad CLosed"),
        ),
        request: AdRequest());

    return ad;
  }
}
