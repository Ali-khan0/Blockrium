import 'package:Blockrium/res/Colorsnew/appcolors.dart';
import 'package:flutter/material.dart';


Widget newsContainer(context, image,title, date) {
  return Container(
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 4.0, top: 2.0, bottom: 2.0),
          height: 77,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(image: NetworkImage(image)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        Container(
          // color: Colors.yellow,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: AppColor.whiteColor.withOpacity(0.8),
                  // fontWeight: FontWeight.bold,
                  // fontSize: 17
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
