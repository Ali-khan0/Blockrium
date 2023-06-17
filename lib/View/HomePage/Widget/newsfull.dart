import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:http/http.dart' as http;

import '../../../Ads/Admob/admob_keys.dart';
import '../newsdetail.dart';

class NewsFull extends StatefulWidget {
  const NewsFull({super.key});

  @override
  State<NewsFull> createState() => _NewsFullState();
}

class _NewsFullState extends State<NewsFull> {
  var newsdata;

  Future<void> getNewsApi() async {
    final response = await http.get(Uri.parse(
        "https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=COIN,CRYPTO:BTC,FOREX:USD&apikey=6BAFG5AAT28SL25P&sort=LATEST&topics=blockchain"));
    if (response.statusCode == 200) {
      newsdata = jsonDecode(response.body.toString());
    } else {
      print("====== not geting data");
    }
  }

  // BannerAd? _bannerAd;
  // bool _isLoaded = false;
  // void loadAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: admobBannerID,
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       // Called when an ad is successfully received.
  //       onAdLoaded: (ad) {
  //         debugPrint('$ad banner loaded.');
  //         setState(() {
  //           _isLoaded = true;
  //         });
  //       },
  //       // Called when an ad request failed.
  //       onAdFailedToLoad: (ad, err) {
  //         debugPrint('Banner Ad failed to load: $err');
  //         // Dispose the ad here to free resources.
  //         ad.dispose();
  //       },
  //     ),
  //   )..load();
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loadAd();
  // }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        // bottomNavigationBar: SizedBox(
        //   width: _bannerAd!.size.width.toDouble(),
        //   height: _bannerAd!.size.height.toDouble(),
        //   child: Center(
        //     child: _bannerAd != null
        //         ? SizedBox(
        //             width: _bannerAd!.size.width.toDouble(),
        //             height: _bannerAd!.size.height.toDouble(),
        //             child: AdWidget(ad: _bannerAd!),
        //           )
        //         : Container(),
        //   ),
        // ),
        appBar: AppBar(
          // toolbarHeight: 80,
          elevation: 0,
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
          backgroundColor: Colors.white,
          title: Text(
            "Crypto News",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getNewsApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.beat(
                    color: Colors.purple.shade300,
                    size: 35,
                  ),
                );
              } else {
                return
                    // Text(data["data"][0]["title"].toString());
                    ListView.builder(
                  itemCount: newsdata["feed"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          Get.to(NewsDetailPage(
                              image: newsdata["feed"][index]["banner_image"]
                                  .toString(),
                              title:
                                  newsdata["feed"][index]["title"].toString(),
                              date: newsdata["feed"][index]["time_published"]
                                  .toString(),
                              para: newsdata["feed"][index]["summary"]
                                  .toString()
                                  .toString(),
                              url: newsdata["feed"][index]["url"].toString(),
                              author: "N/A"
                              // newsdata["feed"][index]["authors"][0]
                              //     .toString()

                              ));
                        },
                        child: newsUpdate(
                            newsdata["feed"][index]["title"].toString(),
                            newsdata["feed"][index]["time_published"]
                                .toString(),
                            newsdata["feed"][index]["banner_image"].toString(),
                            w));
                  },
                );
              }
            }));
  }
}

Widget newsUpdate(title, date, image, w) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0.1,
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(date),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: SizedBox(
              width: w * 0.2, child: Image(image: NetworkImage(image))),
        ),
      ),
    ),
  );
}
