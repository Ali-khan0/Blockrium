import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdxManagerController extends GetxController {
  final adUnitIdINT = Platform.isAndroid
      ? '/7047,22946396544/apl/mix2ad3223/maticlegend.web3/interstitialinapp'
      : '/7047,22946396544/apl/mix2ad3223/maticlegend.web3/interstitialinapp';
  InterstitialAd? interstitialAd;
  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: adUnitIdINT,
      request:const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd = null;
          createInterstitialAd();
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          createInterstitialAd();
        },
      );
      interstitialAd!.show();
    }
  }
}
