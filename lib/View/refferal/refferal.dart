import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../Ads/Admob/admob.dart';
import '../../View new/Widgets/custom_appbar.dart';
import '../../res/colors/app_colors.dart';
import '../../widget/widget.dart';

class ShareRefferal extends StatefulWidget {
  const ShareRefferal({
    Key? key,
    required this.refcode,
    required this.username,
  }) : super(key: key);
  final String refcode;
  final String username;

  @override
  State<ShareRefferal> createState() => _ShareRefferalState();
}

class _ShareRefferalState extends State<ShareRefferal> {
  void _copyTextToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.refcode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text copied to clipboard')),
    );
  }

  late ByteData _imageByteData;
  late File _imageFile;

  final String appLink =
      'https://play.google.com/store/apps/details?id=com.maticlegend.web3';

  GlobalKey _globalKey = GlobalKey();

  Future<Uint8List> _capturePng(_globalKey) async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<String> _saveImage(Uint8List imageBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/image.png');
    await file.writeAsBytes(imageBytes);
    return file.path;
  }

  void _shareImage(String imagePath) {
    Share.shareFiles([imagePath],
        text:
            "Get free mining and join a social DeFi network with Blockrium Network. Download The Blockrium App Now & Get Upto 100 BRC Use my \nreferral code: ${widget.refcode} \nAppLink: $appLink");
  }

  void _shareContainer() async {
    Uint8List imageBytes = await _capturePng(_globalKey);
    String imagePath = await _saveImage(imageBytes);
    _shareImage(imagePath);
  }

// todo

  // var _interstitialRetryAttempt1 = 0;

  // initializeInterstitialAdsRewardsRandomRewards() {
  //   AppLovinMAX.setInterstitialListener(InterstitialListener(
  //     onAdLoadedCallback: (ad) async {
  //       bool isReady =
  //           (await AppLovinMAX.isInterstitialReady("be06615f323317a6"))!;
  //       if (isReady) {
  //         AppLovinMAX.showInterstitial("be06615f323317a6");
  //       }
  //       // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
  //       debugdebugPrint('Interstitial ad loaded from ' + ad.networkName);

  //       // Reset retry attempt
  //       _interstitialRetryAttempt1 = 0;
  //     },
  //     onAdLoadFailedCallback: (adUnitId, error) {
  //       // Interstitial ad failed to load
  //       // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
  //       _interstitialRetryAttempt1 = _interstitialRetryAttempt1 + 1;

  //       int retryDelay = pow(2, min(6, _interstitialRetryAttempt1)).toInt();

  //       debugdebugPrint('Interstitial ad failed to load with code ' +
  //           error.code.toString() +
  //           ' - retrying in ' +
  //           retryDelay.toString() +
  //           's');

  //       Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
  //         AppLovinMAX.loadInterstitial("be06615f323317a6");
  //       });
  //     },
  //     onAdDisplayedCallback: (ad) {},
  //     onAdDisplayFailedCallback: (ad, error) {},
  //     onAdClickedCallback: (ad) {},
  //     onAdHiddenCallback: (ad) {
  //       // _shareContainer();
  //       // randomRewards(customsetstate);
  //     },
  //   ));

  //   // Load the first interstitial
  //   AppLovinMAX.loadInterstitial("be06615f323317a6");
  // }
  // final String _interstitial_ad_unit_id =
  //     Platform.isAndroid ? "be06615f323317a6" : "be06615f323317a6";

  // var _interstitialRetryAttempt = 0;

  // void initializeInterstitialAds() {
  //   AppLovinMAX.setInterstitialListener(InterstitialListener(
  //     onAdLoadedCallback: (ad) {
  //       // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
  //       debugdebugPrint('Interstitial ad loaded from ' + ad.networkName);

  //       // Reset retry attempt
  //       _interstitialRetryAttempt = 0;
  //     },
  //     onAdLoadFailedCallback: (adUnitId, error) {
  //       // Interstitial ad failed to load
  //       // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
  //       _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

  //       int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();

  //       debugdebugPrint('Interstitial ad failed to load with code ' +
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
  //     onAdHiddenCallback: (ad) {
  //       _shareContainer();
  //     },
  //   ));

  //   // Load the first interstitial
  //   AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
  // }

  var _interstitialRetryAttempt1 = 0;

  bool isLoading = false; // Add this variable to track loading state
  initializeInterstitialAdsRewardsRandomRewards() {
    // AppLovinMAX.setInterstitialListener(InterstitialListener(
    //   onAdLoadedCallback: (ad) async {
    //     bool isReady =
    //         (await AppLovinMAX.isInterstitialReady("a61172581abfd50a"))!;
    //     if (isReady) {
    //       AppLovinMAX.showInterstitial("a61172581abfd50a");
    //     }
    //     // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
    //     debugdebugPrint('Interstitial ad loaded from ' + ad.networkName);

    //     // Reset retry attempt
    //     _interstitialRetryAttempt1 = 0;
    //   },
    //   onAdLoadFailedCallback: (adUnitId, error) {
    //     // Interstitial ad failed to load
    //     // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
    //     _interstitialRetryAttempt1 = _interstitialRetryAttempt1 + 1;

    //     int retryDelay = pow(2, min(6, _interstitialRetryAttempt1)).toInt();

    //     debugdebugPrint('Interstitial ad failed to load with code ' +
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
    //   onAdHiddenCallback: (ad) {
    _shareContainer();
    //   },
    // ));

    // // Load the first interstitial
    // AppLovinMAX.loadInterstitial("a61172581abfd50a");
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: SubScreenApbarBlack(
          title: "Invite friends",
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  // SizedBox(
                  //   height: h * 0.1,
                  //   width: w,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Image(
                      image: AssetImage("assets/shareappimg2.png"),
                      height: h * 0.15,
                    ),
                  ),
                  Text(
                    "Let's get started",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.purpleColor,
                        fontSize: 22),
                  ),
                  Text(
                    "Invite your friends with your invitation Code",
                    style: TextStyle(color: Colors.white),
                  ),
                  RepaintBoundary(
                    key: _globalKey,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: w * 0.9,
                      height: h * 0.3,
                      decoration: BoxDecoration(
                          // color: Color(0xff08004e),
                          // gradient: LinearGradient(colors: [
                          //   ui.Color.fromARGB(255, 149, 158, 165),
                          //   ui.Color.fromARGB(255, 183, 219, 248)
                          // ]),
                          image: DecorationImage(
                              image: AssetImage("assets/sharecardbg2.jpg")),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 8.0),
                                child: Row(
                                  children: [
                                    // Image(
                                    //   image: AssetImage("assets/logoname.png"),
                                    //   height: Get.height * 0.05,
                                    // ),
                                    // Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       "Matic",
                                    //       style: TextStyle(
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontSize: 16),
                                    //     ),
                                    //     Text(
                                    //       "Legend",
                                    //       style: TextStyle(
                                    //           color: Colors.blue,
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                              // Container(
                              //   // height: Get.height * 0.05,
                              //   // margin: EdgeInsets.all(10.0),
                              //   // width: Get.width * 0.3,
                              //   decoration: BoxDecoration(
                              //       gradient: LinearGradient(colors: [
                              //         // AppColor.redColor,
                              //         // AppColor.pinkColor,
                              //         // AppColor.purpleColor

                              //         ui.Color.fromARGB(108, 244, 67, 54),
                              //         ui.Color.fromARGB(103, 233, 30, 98),
                              //         ui.Color.fromARGB(111, 155, 39, 176)
                              //       ]),
                              //       // color: ui.Color.fromARGB(169, 49, 106, 213),
                              //       borderRadius: BorderRadius.only(
                              //           topLeft: Radius.circular(10),
                              //           bottomLeft: Radius.circular(10))),
                              //   child: Center(
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Text(
                              //         widget.username.toUpperCase(),
                              //         style: TextStyle(
                              //             color: Colors.white,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          Container(
                            height: Get.height * 0.1,
                            width: Get.width,
                            // decoration: BoxDecoration(
                            //     gradient: LinearGradient(colors: [
                            //       // AppColor.redColor,
                            //       // AppColor.pinkColor,
                            //       // AppColor.purpleColor
                            //       ui.Color.fromARGB(108, 244, 67, 54),
                            //       ui.Color.fromARGB(103, 233, 30, 98),
                            //       ui.Color.fromARGB(111, 155, 39, 176)
                            //     ]),
                            //     // color: ui.Color.fromARGB(169, 49, 106, 213),
                            //     borderRadius: BorderRadius.only(
                            //         topLeft: Radius.circular(10),
                            //         topRight: Radius.circular(10))),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 8.0),
                                //   child: AspectRatio(
                                //     aspectRatio: 1,
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //           color: Colors.white,
                                //           borderRadius: BorderRadius.all(
                                //               Radius.circular(10))),
                                //       child: QrImage(
                                //         data:
                                //             "https://play.google.com/store/apps/details?id=com.maticlegend.web3",
                                //         version: QrVersions.auto,
                                //         size: Get.height * 0.1,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 8.0),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceEvenly,
                                //     children: [
                                //       Text(
                                //         "Scan and Download MaticLegend \n10MLC New User Reward",
                                //         style: TextStyle(
                                //             fontWeight: FontWeight.bold,
                                //             color: Colors.white),
                                //       ),
                                //       Row(
                                //         children: [
                                //           Text(
                                //             "Refferal Code:  ",
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //                 color: Colors.white),
                                //           ),
                                //           Text(
                                //             "${widget.refcode} ",
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //                 color: Colors.blue),
                                //           ),
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                // )
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Text(
                                    widget.username.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xffe7e3e6)),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      height: h * 0.060,
                      width: w * 0.8,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: InkWell(
                                    onTap: () {
                                      _copyTextToClipboard();
                                    },
                                    child: Text(
                                      "Copy",
                                      style: TextStyle(color: Colors.purple),
                                    )),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            initialValue: widget.refcode,
                            readOnly: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: InkWell(
                      onTap: () {
                        // final RenderBox box =
                        //     context.findRenderObject() as RenderBox;
                        // final String appLink =
                        //     'https://play.google.com/store/apps/details?id=com.maticlegend.web3';
                        // final String referralCode = widget.refcode;
                        // final String shareText =
                        //     '''Get free mining and join a social DeFi network with MaticLegend Network. Download now  and get a 10MCL welcome bonus when you sign up with my referral link. Join now
                        //             ReferralCode: ${widget.refcode}
                        //             AppLink: $appLink
                        //             ''';
                        // Share.share(shareText,
                        //     sharePositionOrigin:
                        //         box.localToGlobal(Offset.zero) & box.size);
                        // showRewardedAdShare();
                        // initializeInterstitialAdsRewardsRandomRewards();
                        // initializeInterstitialAds();
                        initializeInterstitialAdsRewardsRandomRewards();
                        // Future.delayed(Duration(seconds: 1), () {
                        //   // Call your other function here
                        //   // ...
                        //   _shareContainer();
                        // });
                        // _shareContainer();
                      },
                      child: Container(
                          height: h * 0.060,
                          child: roundButton(h, w, "Invite", isLoading)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   GlobalKey _globalKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RepaintBoundary(
//           key: _globalKey,
//           child: Container(
//             width: 200,
//             height: 200,
//             color: Colors.blue,
//             child: Center(
//               child: Text(
//                 'Hello, world!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _exportImage,
//         child: Icon(Icons.save),
//       ),
//     );
//   }

// }
