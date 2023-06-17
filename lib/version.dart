import 'package:flutter/material.dart';
// import 'package:flutter_install_apk/flutter_install_apk.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'View/Resources/utils.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:package_info/package_info.dart';
import 'package:dio/dio.dart';

import 'widget/glowingbutton.dart';

class VersionCheck extends StatefulWidget {
  const VersionCheck({
    Key? key,
    required this.versiondata,
  }) : super(key: key);
  final versiondata;

  @override
  State<VersionCheck> createState() => _VersionCheckState();
}

class _VersionCheckState extends State<VersionCheck> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image(
              image: AssetImage("assets/blockrium.png"),
            ),
          ),
          title: Text(
            "Blockrium",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Image(
                  image: AssetImage("assets/updateavail.png"),
                  height: Get.height * 0.4,
                ),
                Text(
                  widget.versiondata["app_version"][0]["title"].toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.white),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                // ElevatedButton(
                //     onPressed: () async {
                //       if (1 == 1) {
                //         await launch(
                //             widget.versiondata["app_version"][0]["link"]
                //                 .toString(),
                //             forceWebView: false);
                //       } else {
                //         throw Utils.snackbar(
                //             "Something went wrong", "Unable to get the data");
                //       }
                //     },
                //     child: Text("Download Now!")),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  onTap: () async {
                    if (1 == 1) {
                      await launch(
                          widget.versiondata["app_version"][0]["link"]
                              .toString(),
                          forceWebView: false);
                    } else {
                      throw Utils.snackbar(
                          "Something went wrong", "Unable to get the data");
                    }
                  },
                  child: GlowingButtonAuth(
                    text: "Download Now!",
                    loading: false,
                  ),
                )
                // ElevatedButton(
                //     onPressed: () {
                //       downloadAndInstallApk(
                //           'https://maticlegend.com/api/apk/download');
                //     },
                //     child: Text("data"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
