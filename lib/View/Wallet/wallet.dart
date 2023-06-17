import 'package:Blockrium/View/Wallet/transfer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Ads/Admob/admob.dart';
import '../../res/colors/app_colors.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          // toolbarHeight: 80,
          elevation: 0,
          // leadingWidth: 100,
          leading: Image(image: AssetImage("assets/blockrium3.png")),

          title: Text(
            "Wallet",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              children: [
                // accountDetails(w, h),

                Container(
                  height: h * 0.2,
                  width: w * 0.9,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                _showMyDialog(context, h, w);
                              },
                              child:
                                  walletButton("Deposit", "deposit2.png", w)),
                          InkWell(
                              onTap: () {
                                _showMyDialog(context, h, w);
                              },
                              child:
                                  walletButton("Withdraw", "widhrawal.png", w))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                // _showMyDialog(context, h, w);
                                transfer(w, h);
                              },
                              child:
                                  walletButton("Transfer", "transfer.png", w)),
                          InkWell(
                              onTap: () {
                                _showMyDialog(context, h, w);
                              },
                              child: walletButton("Stake", "stake2.png", w))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Transaction History",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Image(
                  image: AssetImage("assets/history2.png"),
                  height: h * 0.2,
                ),
                Text("Looks Like you haven't made any transactions"),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 50,
                    child: AdWidget(
                        key: UniqueKey(),
                        ad: AdmobSErvice.createBannerAd()..load()),
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.04,
                )
              ],
            ),
          ),
        ));
  }
}

Widget accountDetails(w, h) {
  return Column(children: [
    Text(
      "Account Details",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
    Container(
      height: h * 0.2,
      width: w,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(
                  1,
                  1,
                ))
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          Container(
            width: w * 0.45,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("250"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Widhrawal",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("200"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remaining Balance",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("50"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: w * 0.45,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Active Refral",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("2"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Base Rate",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("10 coins e/hr"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remaining Balance",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("50"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
  ]);
}

Widget walletButton(title, asset, w) {
  return Card(
    child: Container(
      height: 60,
      width: w * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage("assets/$asset"),
            width: 40,
          ),
          Text(
            title,
          )
        ],
      ),
      // decoration: BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.purple.withOpacity(0.2),
      //         spreadRadius: 2,
      //         blurRadius: 5,
      //         offset: Offset(0, 3),
      //       ),
      //     ],
      //     borderRadius: BorderRadius.all(Radius.circular(10)),
      //     gradient: LinearGradient(colors: [
      //       Color.fromARGB(66, 244, 67, 54),
      //       Color.fromARGB(76, 233, 30, 98),
      //       Color.fromARGB(71, 155, 39, 176)
      //       // Color.fromARGB(96, 76, 175, 79)
      //       // Colors.white
      //     ])),
    ),
  );
}

Future<void> _showMyDialog(context, h, w) async {
  return showDialog(
      context: context,
      builder: (_) => new Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: new Container(
                alignment: FractionalOffset.center,
                height: h * 0.8,
                width: w,
                child: new Image.asset(
                  'assets/comingsoon.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ));
}
