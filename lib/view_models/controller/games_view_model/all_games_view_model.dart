import 'package:get/get.dart';

import '../../../data/response/status.dart';
import '../../../models/Games_Model/all_games_model.dart';
import '../../../repository/games_repo/all_games_repo.dart';

class GamesController extends GetxController {
  var selected = Rx<String>("Bubble Shooter");
  var currentIndex = RxInt(0);

  void updateSelected(String value) {
    selected.value = value;
    print(selected.value);
  }

  void updateImgIndex(int value) {
    currentIndex.value = value;
  }

  List<String> category = [
    "Bubble Shooter",
    "Arcade",
    "Action",
    "Quiz",
    "Puzzle",
    "Racing",
    "Car",
    "Board Games",
    "Sports",
    "Educational",
    "Jump & Run",
    "Cards",
    "Girls",
    "Skill",
    "Casino",
    "Cooking",
  ];
  
  final _api = GamesRepositry();

  final rxRequestStatus = Status.LOADING.obs;
  final allGamesList = AllGamesModel().obs;
  RxString error = "".obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setGamesList(AllGamesModel _value) => allGamesList.value = _value;
  void setError(String _value) => error.value = _value;
  void gameListApi() {
    _api.allGamesAPI().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setGamesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshGamesListApi() {
    setRxRequestStatus(Status.LOADING);
    _api.allGamesAPI().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setGamesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}
