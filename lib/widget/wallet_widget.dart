import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/Profile/profile.dart';
import '../new_changes.dart';

Widget walletWidget(balance, context, h, w) {
  return Stack(
    children: [
      Container(
        height: Get.height * 0.40,
        decoration: BoxDecoration(
            // color: Colors.red,
            image: DecorationImage(
                image: AssetImage("assets/1234567.png"), fit: BoxFit.cover),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
      ),
      Container(
        // width: 200,
        height: Get.height * 0.40,
        decoration: BoxDecoration(
          color: Color.fromARGB(36, 250, 250, 250),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            height: Get.height * 0.40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Color.fromARGB(41, 158, 158, 158).withOpacity(0.1),
              // borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Current Balance",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Text(
                        "+0.5 e/hr",
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "$balance BRC",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Image(
                        image: AssetImage("assets/coin.png"),
                        height: Get.height * 0.04,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          showMyDialogCommingSoon(context, h, w);
                        },
                        child: balanceButtonWidget(
                            "DEPOSIT", "assets/deposit2.png"),
                      ),
                      InkWell(
                          onTap: () {
                            showMyDialogCommingSoon(context, h, w);
                          },
                          child: balanceButtonWidget(
                              "WITHDRAW", "assets/widhrawal.png")),
                      InkWell(
                          onTap: () {
                            showMyDialogCommingSoon(context, h, w);
                          },
                          child: balanceButtonWidget(
                              "TRANSFER", "assets/transfer.png")),
                      InkWell(
                          onTap: () {
                            showMyDialogCommingSoon(context, h, w);
                          },
                          child: balanceButtonWidget(
                              "STAKE", "assets/stake2.png")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
