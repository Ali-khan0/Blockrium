import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_balloon/speech_balloon.dart';

import '../../res/Colorsnew/appcolors.dart';

Widget miningRateContainer(context) {
  return Container(
    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
    width: MediaQuery.of(context).size.width,
    height: 240.0,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.purpleColor.withOpacity(0.3),
              AppColor.pinkColor.withOpacity(0.3)
            ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Earn the best this time",
              style: TextStyle(
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: RotatedBox(
                  quarterTurns: 3, // rotate 270 degrees (90 degrees clockwise)
                  child: Text(
                    '        BRC Mining Rate',
                    style: TextStyle(color: AppColor.whiteColor),
                  ),
                ),
              ),
              statsBar(context, 120.0, "0.5 e/hr", "100K", 1),
              statsBar(context, 90.0, "0.4 e/hr", "500K", 0),
              statsBar(context, 60.0, "0.3 e/hr", "1M", 0),
              statsBar(context, 30.0, "0.1 e/hr", "50M", 0),
              statsBar(context, 10.0, "", "100M", 0),
            ],
          )
        ],
      ),
    ),
  );
}

Widget statsBar(context, h, rate, downloads, index) {
  return Column(
    children: [
      index == 1
          ? SpeechBalloon(
              height: 20,
              nipHeight: 6,
              width: 50,
              borderRadius: 100,
              nipLocation: NipLocation.bottomLeft,
              borderColor: AppColor.purpleColor,
              color: AppColor.pinkColor.withOpacity(0.2),
              borderWidth: 2,
              child: Center(
                  child: Text(
                "Now",
                style: TextStyle(color: Colors.white),
              )),
            )
          : Text(""),
      Text(
        rate,
        style: TextStyle(color: AppColor.whiteColor),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white38),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.purpleColor.withOpacity(0.4),
                  AppColor.pinkColor.withOpacity(0.4)
                ]),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: h,
        width: MediaQuery.of(context).size.width * 0.15,
      ),
      Text(downloads,
          style: TextStyle(color: AppColor.whiteColor.withOpacity(0.7)))
    ],
  );
}
