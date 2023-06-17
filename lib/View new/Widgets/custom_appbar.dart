
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubScreenApbarBlack extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const SubScreenApbarBlack({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.white.withOpacity(0.4)),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
      ),
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            // height: Get.height * 0.1,
            color: Colors.transparent,
          ),
        ),
      ),
      backgroundColor: Color(0xff1B232A).withAlpha(200),
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}




class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: Padding(
      //   padding: const EdgeInsets.all(12.0),
      //   child: InkWell(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Container(
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.all(Radius.circular(5)),
      //           color: Colors.white.withOpacity(0.4)),
      //       child: Icon(
      //         Icons.arrow_back_ios_new,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            // height: Get.height * 0.1,
            color: Colors.transparent,
          ),
        ),
      ),
      backgroundColor: Color(0xff1B232A).withAlpha(200),
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
