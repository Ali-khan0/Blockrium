// import 'package:asdawaj/data/response/status.dart';
// import 'package:asdawaj/models/all_post_model/allpostmodel.dart';
// import 'package:asdawaj/repository/allpost_repository/all_post_repo.dart';
// import 'package:get/get.dart';

// class AllPostController extends GetxController {
//   final _api = AllPostRepositry();

//   final rxRequestStatus = Status.LOADING.obs;
//   final allPostList = AllProfilePostModel().obs;
//   RxString error = "".obs;

//   void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
//   void setallProfileList(AllProfilePostModel _value) =>
//       allPostList.value = _value;
//  void setError(String _value) =>
//       error.value = _value;
//   void allProfileListApi() {
//     _api.allProfileApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setallProfileList(value);
//     }).onError((error, stackTrace) {
//     setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }


//     void refreshAllProfileListApi() {
//     setRxRequestStatus(Status.LOADING);
//     _api.allProfileApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setallProfileList(value);
//     }).onError((error, stackTrace) {
//     setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }
// }
