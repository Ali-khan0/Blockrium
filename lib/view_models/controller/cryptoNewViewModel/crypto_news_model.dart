import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/response/status.dart';
import '../../../models/Games_Model/all_games_model.dart';
import '../../../models/NewModel/newmodel.dart';
import '../../../repository/games_repo/all_games_repo.dart';
import '../../../repository/news_repo/news_repo.dart';

class NewsController extends GetxController {
  var sliderIndex = RxInt(0);

  void updateSlider(int value) {
    sliderIndex.value = value;
    debugPrint(value.toString());
  }

  List socilMediaLinks = [
    'assets/telegramprofile.jpg',
    'assets/twitterprofile.jpg',
    'assets/linkedin.jpg'
  ];

  List socialType = ["Telegram", "Twitter", "LinkedIn"];
  List socialLinks = [
    "https://t.me/blockrium",
    "https://twitter.com/Blockrium",
    "https://www.linkedin.com/company/blockrium/"
  ];

  final _api = NewsRepositry();

  final rxRequestStatus = Status.LOADING.obs;
  final allNewsList = NewsModel().obs;
  RxString error = "".obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setNewsList(NewsModel _value) => allNewsList.value = _value;
  void setError(String _value) => error.value = _value;
  void allNewsListApi() {
    _api.allNewsAPI().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setNewsList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshallNewsListApi() {
    setRxRequestStatus(Status.LOADING);
    _api.allNewsAPI().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setNewsList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}
