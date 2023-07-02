import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdxManagerController extends GetxController{
 final adUnitIdINT = Platform.isAndroid
      ? '/21902364955,22948000438/CM_Blockrium_Network_InApp_Finance_Top/CM_Blockrium_Network_InApp_Finance_Interstitial'
      : '/21902364955,22948000438/CM_Blockrium_Network_InApp_Finance_Top/CM_Blockrium_Network_InApp_Finance_Interstitial';

   InterstitialAd? interstitialAd;
    void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: AdRequest(),
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