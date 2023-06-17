import 'dart:io';
import 'dart:math';
import 'package:Blockrium/res/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../View/Resources/utils.dart';

class NewsDetailPageNew extends StatefulWidget {
  const NewsDetailPageNew({
    Key? key,
    required this.image,
    required this.title,
    required this.date,
    required this.para,
    required this.url,
    // required this.author,
  }) : super(key: key);
  final String image;
  final String title;
  final String date;
  final String para;
  final String url;
  // final String author;

  @override
  State<NewsDetailPageNew> createState() => _NewsDetailPageNewState();
}

_launchURL(link) async {
  // Define the URL to be launched
  var url = link;
  // Check if the app can launch the URL
  if (await canLaunch(url)) {
    // Launch the URL in a browser, ignoring the app
    await launch(url, forceWebView: true);
  } else {
    // If the app can't launch the URL, show an error message
    throw Utils.snackbar("Something went wrong", "Unable to get the data");
  }
}

// _launchURL() async {
//   // Define the URL to be launched
//   const url = 'https://flutter.dev';
//   // Check if the app can launch the URL
//   if (await canLaunch(url)) {
//     // Launch the URL
//     await launch(url);
//   } else {
//     // If the app can't launch the URL, show an error message
//     throw 'Could not launch $url';
//   }
// }

class _NewsDetailPageNewState extends State<NewsDetailPageNew> {
  @override
  void initState() {
    super.initState();
    // initializeBannerAds();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    //    String dateString = date;
    // DateTime date = DateTime.parse(dateString);
    // DateTime.parse(date)
    // String formattedDate = DateFormat('yMdTHm').format(date);
    // print(formattedDate);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black.withOpacity(0.4)),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h * 0.3,
                width: w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.image), fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Date:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      DateFormat(
                        'd-M-y',
                      ).format(DateTime.parse(
                        widget.date,
                      )),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "Category:",
              //         style: TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //     // Padding(
              //     //   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              //     //   child: Text(widget.author),
              //     // ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  """${widget.para}""",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      initializeInterstitialAds();

                      // _launchURL(widget.url);
                      if (1 == 1) {
                        // Launch the URL in a browser, ignoring the app
                        await launch(widget.url, forceWebView: true);
                      } else {
                        // If the app can't launch the URL, show an error message
                        throw Utils.snackbar(
                            "Something went wrong", "Unable to get the data");
                      }
                    },
                    child: Container(
                      height: 40,
                      width: w * 0.8,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white
                                .withOpacity(0.2), // red as border color
                          ),
                          gradient: LinearGradient(colors: [
                            AppColor.purpleColor.withOpacity(0.2),
                            AppColor.pinkColor.withOpacity(0.2)
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          "Read More",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final String _interstitial_ad_unit_id =
      Platform.isAndroid ? "7ffc76cf6231308c" : "7ffc76cf6231308c";

  var _interstitialRetryAttempt = 0;

  void initializeInterstitialAds() {
    //   AppLovinMAX.setInterstitialListener(InterstitialListener(
    //     onAdLoadedCallback: (ad) async {
    //       bool isReady =
    //           (await AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id))!;
    //       if (isReady) {
    //         AppLovinMAX.showInterstitial(_interstitial_ad_unit_id);
    //       }
    //       // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
    //       print('Interstitial ad loaded from ' + ad.networkName);

    //       // Reset retry attempt
    //       _interstitialRetryAttempt = 0;
    //     },
    //     onAdLoadFailedCallback: (adUnitId, error) {
    //       // Interstitial ad failed to load
    //       // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
    //       _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

    //       int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();

    //       print('Interstitial ad failed to load with code ' +
    //           error.code.toString() +
    //           ' - retrying in ' +
    //           retryDelay.toString() +
    //           's');

    //       Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
    //         AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
    //       });
    //     },
    //     onAdDisplayedCallback: (ad) {},
    //     onAdDisplayFailedCallback: (ad, error) {},
    //     onAdClickedCallback: (ad) {},
    //     onAdHiddenCallback: (ad) {},
    //   ));

    //   // Load the first interstitial
    //   AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
  }
}
