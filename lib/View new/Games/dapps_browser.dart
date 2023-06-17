import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/utils.dart';
import 'browser.dart';
import 'dapps_assset.dart';
import 'full_list_dapps.dart';

class DappsBrowser extends StatefulWidget {
  const DappsBrowser({super.key});

  @override
  State<DappsBrowser> createState() => _DappsBrowserState();
}

class _DappsBrowserState extends State<DappsBrowser> {
  @override
  void initState() {
    super.initState();
    selectedEngineName = searchEngines[1]['name'];
  }

  // var _interstitialRetryAttempt1 = 0;

  initializeInterstitialAdsDappsOpenApp(jsonname, index) async {
    // AppLovinMAX.setInterstitialListener(InterstitialListener(
    //   onAdLoadedCallback: (ad) async {
    //     bool isReady =
    //         (await AppLovinMAX.isInterstitialReady("ebc7271ad1a92134"))!;
    //     if (isReady) {
    //       AppLovinMAX.showInterstitial("ebc7271ad1a92134");
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
    //       AppLovinMAX.loadInterstitial("ebc7271ad1a92134");
    //     });
    //   },
    //   onAdDisplayedCallback: (ad) {},
    //   onAdDisplayFailedCallback: (ad, error) {},
    //   onAdClickedCallback: (ad) {},
    //   onAdHiddenCallback: (ad) async {
    if (1 == 1) {
      // Launch the URL in a browser, ignoring the app
      await launch(jsonname[index]["url"],
          forceWebView: true, enableJavaScript: true);
      print(jsonname[index]["url"]);
    } else {
      // If the app can't launch the URL, show an error message
      throw Utilsnew.snackbar("Something went wrong", "Unable to get the data");
    }
    // randomRewards(customsetstate);
    //   },
    // ));

    // Load the first interstitial
    // AppLovinMAX.loadInterstitial("ebc7271ad1a92134");
  }

  final List<Map<String, dynamic>> searchEngines = [
    {
      'name': 'DuckDuckGo',
      'icon': 'assets/duck.png',
    },
    {
      'name': 'presearch',
      'icon': 'assets/presearch.png',
    },
  ];
  late String selectedEngineName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        elevation: 0,
        // leadingWidth: 100,
        leading: Image(image: AssetImage("assets/blockrium3.png")),

        title: Text(
          "Decentralized Apps",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(12.0),
              height: Get.height * 0.2,
              width: Get.width,
              decoration: BoxDecoration(
                  // color: Color.fromARGB(43, 244, 67, 54),
                  image: DecorationImage(
                      image: AssetImage("assets/dapps.jpg"), fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    // Get.to(BrowserApp(
                    //   engine: selectedEngineName,
                    // ));
                  },
                  child: SizedBox(
                    width: Get.width * 0.70,
                    height: Get.height * 0.05,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(),
                          hintText: "   Search on ${selectedEngineName}"),
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: selectedEngineName,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  onChanged: (value) {
                    setState(() {
                      selectedEngineName = value!;
                    });
                  },
                  items: searchEngines.map<DropdownMenuItem<String>>(
                      (Map<String, dynamic> engine) {
                    return DropdownMenuItem<String>(
                      value: engine['name'],
                      child: Image.asset(
                        engine['icon'],
                        width: 24,
                        height: 24,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // ElevatedButton(
            //     onPressed: () {
            //       // search(webcontroller,"presearch","presearch");

            //     },
            //     child: Text("go")),
            customlistile("Popular Dapps", popular),
            Container(
              // color: Colors.red,
              width: Get.width,
              height: Get.height * 0.1,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                // physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: popular.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: InkWell(
                      onTap: () {
                        // showRewardedAdShare(popular, index);
                        initializeInterstitialAdsDappsOpenApp(popular, index);
                      },
                      child: Column(
                        children: [
                          Container(
                            height: Get.height * 0.07,
                            width: Get.width * 0.12,
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                image: DecorationImage(
                                    image:
                                        NetworkImage(popular[index]["image"]))),
                          ),
                          Text(popular[index]["name"])
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // todo;
            customlistile("Arbitrum", arbitrum),
            Container(
              // height: Get.height * 0.1,
              // color: Colors.red,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // scrollDirection: Axis.horizontal,
                itemCount: arbitrum.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // showRewardedAdShare(arbitrum, index)
                      initializeInterstitialAdsDappsOpenApp(arbitrum, index);
                      // if (1 == 1) {
                      //   // Launch the URL in a browser, ignoring the app
                      //   await launch(arbitrum[index]["url"],
                      //       forceWebView: true, enableJavaScript: true);
                      // } else {
                      //   // If the app can't launch the URL, show an error message
                      //   throw Utils.snackbar(
                      //       "Something went wrong", "Unable to get the data");
                      // }
                    },
                    child: customListile2(
                        arbitrum[index]["name"],
                        arbitrum[index]['description'],
                        arbitrum[index]['image']),
                  );
                },
              ),
            ),
            // todo;
            customlistile("Avalanche", avalance),
            Container(
              height: Get.height * 0.1,
              // color: Colors.red,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // scrollDirection: Axis.horizontal,
                itemCount: avalance.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // if (1 == 1) {
                      //   // Launch the URL in a browser, ignoring the app
                      //   await launch(avalance[index]["url"],
                      //       forceWebView: true, enableJavaScript: true);
                      // } else {
                      //   // If the app can't launch the URL, show an error message
                      //   throw Utils.snackbar(
                      //       "Something went wrong", "Unable to get the data");
                      // showRewardedAdShare(avalance, index)
                      initializeInterstitialAdsDappsOpenApp(avalance, index);
                    },
                    child: customListile2(
                        avalance[index]["name"],
                        avalance[index]['description'],
                        avalance[index]['image']),
                  );
                },
              ),
            ),

            // todo;
            customlistile("BSC", bsc),
            Container(
              height: Get.height * 0.3,
              // color: Colors.red,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      // if (1 == 1) {
                      //   // Launch the URL in a browser, ignoring the app
                      //   await launch(bsc[index]["url"],
                      //       forceWebView: true, enableJavaScript: true);
                      // } else {
                      //   // If the app can't launch the URL, show an error message
                      //   throw Utils.snackbar(
                      //       "Something went wrong", "Unable to get the data");
                      // }
                      // showRewardedAdShare(bsc, index)
                      initializeInterstitialAdsDappsOpenApp(bsc, index);
                    },
                    child: customListile2(bsc[index]["name"],
                        bsc[index]['description'], bsc[index]['image']),
                  );
                },
              ),
            ),
            // todo;
            customlistile("Ethereum", ethereum),
            Container(
              height: Get.height * 0.3,
              // color: Colors.red,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      // if (1 == 1) {
                      //   // Launch the URL in a browser, ignoring the app
                      //   await launch(ethereum[index]["url"],
                      //       forceWebView: true, enableJavaScript: true);
                      // } else {
                      //   // If the app can't launch the URL, show an error message
                      //   throw Utils.snackbar(
                      //       "Something went wrong", "Unable to get the data");
                      // }
                      // showRewardedAdShare(ethereum, index)
                      initializeInterstitialAdsDappsOpenApp(ethereum, index);
                    },
                    child: customListile2(
                        ethereum[index]["name"],
                        ethereum[index]['description'],
                        ethereum[index]['image']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customlistile(title, jsonname) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    ),
    trailing: InkWell(
      onTap: () {
        Get.to(FullListOfDapps(appbartitle: title, jsonname: jsonname));
      },
      child: Text(
        "View All",
        style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget customListile2(title, subtitle, leading) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle),
    leading: Image(image: NetworkImage(leading)),
  );
}
