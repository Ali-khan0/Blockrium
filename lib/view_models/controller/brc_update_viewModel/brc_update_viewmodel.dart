import 'package:get/get.dart';

import '../../../data/response/status.dart';
import '../../../models/BRC Update Model/brc_update_model.dart';

import '../../../repository/brc_update_repo/brc_update_repo.dart';

class BrcUpdateController extends GetxController {

  
  final _api =BrcUpdateRepositry();

  final rxRequestStatus = Status.LOADING.obs;
  final allBRCList = BRCUpdateModel().obs;
  RxString error = "".obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setNewsList(BRCUpdateModel _value) => allBRCList.value = _value;
  void setError(String _value) => error.value = _value;
  void allBRCListApi() {
    _api.allBRCUpdateAPI().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setNewsList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshallBRCListApi() {
    setRxRequestStatus(Status.LOADING);
    _api.allBRCUpdateAPI().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setNewsList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}
