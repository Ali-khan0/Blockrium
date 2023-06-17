import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/utils.dart';
import 'dapps_browser.dart';

class FullListOfDapps extends StatefulWidget {
  const FullListOfDapps({
    Key? key,
    required this.appbartitle,
    required this.jsonname,
  }) : super(key: key);
  final String appbartitle;
  final List jsonname;

  @override
  State<FullListOfDapps> createState() => _FullListOfDappsState();
}

class _FullListOfDappsState extends State<FullListOfDapps> {

  

  var _interstitialRetryAttempt1 = 0;

  initializeInterstitialAdsRewardsRandomRewards(index) async{
    // AppLovinMAX.setInterstitialListener(InterstitialListener(
    //   onAdLoadedCallback: (ad) async {
    //     bool isReady =
    //         (await AppLovinMAX.isInterstitialReady("a61172581abfd50a"))!;
    //     if (isReady) {
    //       AppLovinMAX.showInterstitial("a61172581abfd50a");
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
    //       AppLovinMAX.loadInterstitial("a61172581abfd50a");
    //     });
    //   },
    //   onAdDisplayedCallback: (ad) {},
    //   onAdDisplayFailedCallback: (ad, error) {},
    //   onAdClickedCallback: (ad) {},
    //   onAdHiddenCallback: (ad) async {
    //     // randomRewards(customsetstate);
        if (1 == 1) {
          // Launch the URL in a browser, ignoring the app
          await launch(widget.jsonname[index]["url"],
              forceWebView: true, enableJavaScript: true);
        } else {
          // If the app can't launch the URL, show an error message
          throw Utilsnew.snackbar(
              "Something went wrong", "Unable to get the data");
        }
    //   },
    // ));

    // // Load the first interstitial
    // AppLovinMAX.loadInterstitial("a61172581abfd50a");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 40,
          ),
        ),
        // toolbarHeight: 80,
        elevation: 0,
        // leadingWidth: 100,
        // leading: Image(image: AssetImage("assets/blockrium.png")),
        // backgroundColor: Colors.white,
        title: Text(
          widget.appbartitle,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        itemCount: widget.jsonname.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // showRewardedAdShare(index)
              initializeInterstitialAdsRewardsRandomRewards(index);
            },
            child: customListile2(
                widget.jsonname[index]["name"],
                widget.jsonname[index]['description'],
                widget.jsonname[index]['image']),
          );
        },
      ),
    );
  }
}
