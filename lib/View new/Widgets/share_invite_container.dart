import 'package:Blockrium/res/Colorsnew/appcolors.dart';
import 'package:flutter/material.dart';


Widget shareInviteCintainer(context,title, subtitle) {
  return InkWell(
    child: Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 80,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  
                  title,
                  style: TextStyle(
                  
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    // fontWeight: FontWeight.bold,
                    // fontSize: 17
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.whiteColor,
              size: 30,
            )
          ],
        ),
      ),
    ),
  );
}
