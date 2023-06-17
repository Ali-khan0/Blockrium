import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../Ads/Admob/admob.dart';
import 'webview.dart';

class FullGamepage2 extends StatefulWidget {
  const FullGamepage2({
    Key? key,
    required this.cat,
    required this.bg,
  }) : super(key: key);
  final String cat;
  final String bg;

  @override
  State<FullGamepage2> createState() => _FullGamepage2State();
}

class _FullGamepage2State extends State<FullGamepage2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGamesRecom();
  }

  var dataRecom;
  Future getGamesRecom() async {
    print("not null");
    final response = await http.get(
      Uri.parse(
        "https://maticlegend.com/api/recommended-games",
      ),
    );
    if (response.statusCode == 200) {
      dataRecom = jsonDecode(response.body.toString());
    } else {
      print("====== not geting data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.srcATop),
              image: AssetImage(widget.bg),
              fit: BoxFit.cover)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          backgroundColor: Colors.white.withAlpha(200),

          // toolbarHeight: 80,
          elevation: 0,
          // leadingWidth: 100,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new)),

          title: Text(
            widget.cat,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                FutureBuilder(
                  future: getGamesRecom(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 241, 241, 241),
                          highlightColor: Color.fromARGB(37, 187, 214, 248),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: Get.height * 0.3,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ));
                      // Center(
                      //   child: LoadingAnimationWidget.beat(
                      //     color: Colors.purple.shade300,
                      //     size: 35,
                      //   ),
                      // );
                    } else {
                      final List<dynamic> games =
                          dataRecom['recommended_games'];
                      final List<dynamic> filteredGames = games
                          // .where((game) => game['gamecategory'] == widget.cat)
                          .toList();

                      return GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          crossAxisCount: 5,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: filteredGames.length,
                        itemBuilder: (BuildContext context, int index) {
                          final gamename =
                              filteredGames[index]['gamename'].toString();
                          final gamelogo =
                              filteredGames[index]['logo'].toString();
                          final gameLink =
                              filteredGames[index]['url'].toString();
                          return InkWell(
                            onTap: () {
                              Get.to(WebViewScreen(
                                url: gameLink,
                              ));
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    gamelogo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  gamename,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 50,
            child: AdWidget(
                key: UniqueKey(), ad: AdmobSErvice.createBannerAd()..load()),
          ),
        ),
      ),
    );
  }
}
