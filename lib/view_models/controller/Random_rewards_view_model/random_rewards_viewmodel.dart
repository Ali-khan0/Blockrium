import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../View/Resources/appurl.dart';
import '../Wallet_view_model/wallet_view_model.dart';

class RandomRewardsController extends GetxController {
  final walletViewModel = Get.put(WalletViewModel());

  var randomRewardsStatus = {}.obs;
  var rewardsStatus = RxString("0");
  Future getRewardsStatus() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      print("not null");
      final response = await http.get(
        Uri.parse(
          AppUrl.randomRewardsStatusEndPoint,
        ),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        randomRewardsStatus.value = jsonDecode(response.body.toString());
        rewardsStatus.value = randomRewardsStatus["data"]["status"].toString();
        debugPrint(
            "randomRewards==== ${randomRewardsStatus.value["message"].toString()}");
      } else {
        debugPrint("====== not geting RandomREwardsData");
      }
    }
  }

  var randomRewardsData = {}.obs;
  Future randomRewardsAdd() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    var response = await http.post(
      Uri.parse(AppUrl.randomRewardsEndPoint),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      randomRewardsData.value = jsonDecode(response.body.toString());
      print(randomRewardsData["message"].toString());
      Get.snackbar(randomRewardsData["message"].toString(),
          "${randomRewardsData["reward"].toString()} Coins Added to Wallet");
      getRewardsStatus();
      walletViewModel.userWallet();
      // UnityAdManater.showRwdAd();
    } else {
      print("====== not geting new mining data data");
    }
  }
}
