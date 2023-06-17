import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../View/Resources/appurl.dart';
import '../../../data/response/status.dart';

class BottomNavController extends GetxController {
  var currentIndex = RxInt(0);
  var versiondata = {}.obs;
  var version = RxInt(0);

  void updateIndex(int value) {
    currentIndex.value = value;
    debugPrint(currentIndex.value.toString());
  }

  Future<void> getversion() async {
    final response =
        await http.get(Uri.parse("https://maticlegend.com/api/app-version"));
    if (response.statusCode == 200) {
      var versionbody = jsonDecode(response.body.toString());
      versiondata.value = jsonDecode(response.body.toString());
      version.value =
          int.parse(versionbody["app_version"][0]["version"].toString());

      print("====version ==== version ${version.value}");
    } else {
      // Handle error case
    }
  }

  var isactivedata = {}.obs;
  var isactive = RxString("1");

  Future<void> getSuspendData() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    final response = await http.get(
        Uri.parse("https://maticlegend.com/api/auth/is-active"),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var isActiveBody = jsonDecode(response.body.toString());
      isactivedata.value = jsonDecode(response.body.toString());
      isactive.value = isActiveBody["is_active"];
      debugPrint("account active status code: ${isactive.value}");
    } else {
      print("====Account suspend not working");
    }
  }

  var giftBody = {}.obs;
  var isgift = RxString("");
  Future<void> getGiftData() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    final response = await http.get(Uri.parse(AppUrl.getNotificationEndPoint),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      giftBody.value = jsonDecode(response.body.toString());
      isgift.value = giftBody["notifications"];
    } else {
      debugPrint("==== unable to get the gift status");
    }
  }

var ismaintenancedata = {}.obs;
var ismaintenance = RxBool(false);
  Future<void> getMaintenaceData() async {
    final response = await http.get(
      Uri.parse("https://maticlegend.com/api/app-maintenance"),
    );

    if (response.statusCode == 200) {
      var isMaintenanceBody = jsonDecode(response.body.toString());
      ismaintenancedata.value = jsonDecode(response.body.toString());
      ismaintenance.value = isMaintenanceBody["app_status"];
      print("ismaintenance data is here ========= : $ismaintenance");
    } else {
      print("====maintennance API not working");
    }
  }

}
