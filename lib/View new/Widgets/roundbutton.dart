import 'package:Blockrium/res/Colorsnew/appcolors.dart';
import 'package:flutter/material.dart';

Widget roundButton(title, w, h) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.pinkColor,
              AppColor.purpleColor,
            ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Center(
      child: Text(
        title,
        style: TextStyle(color: AppColor.whiteColor),
      ),
    ),
  );
}

Widget initilizedMining(title, w, h) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.pinkColor.withOpacity(0.2),
              AppColor.purpleColor.withOpacity(0.2),
            ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Center(
      child: Text(
        title,
        style: TextStyle(color: AppColor.whiteColor),
      ),
    ),
  );
}

Widget rewardClaimedButton(title, w, h) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.pinkColor.withOpacity(0.2),
              AppColor.purpleColor.withOpacity(0.2),
            ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Center(
      child: Text(
        title,
        style: TextStyle(color: AppColor.whiteColor),
      ),
    ),
  );
}
