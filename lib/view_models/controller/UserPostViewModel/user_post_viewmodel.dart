// import 'package:asdawaj/data/response/status.dart';
// import 'package:get/get.dart';

// import '../../../models/userPostModel/userpost_model.dart';
// import '../../../repository/userPostRepo/user_post_repo.dart';

// class UserAllPostController extends GetxController {
//   final _api = UserPostRepositry();

//   final rxRequestStatus = Status.LOADING.obs;
//   final userPostList = UserPostModel().obs;
//   RxString error = "".obs;

//   void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
//   void setuserProfileList(UserPostModel _value) =>
//       userPostList.value = _value;
//  void setError(String _value) =>
//       error.value = _value;
//   void allUserProfileListApi() {
//     _api.userPostApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setuserProfileList(value);
//     }).onError((error, stackTrace) {
//     setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }


//     void refreshAllUserProfileListApi() {
//     setRxRequestStatus(Status.LOADING);
//     _api.userPostApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setuserProfileList(value);
//     }).onError((error, stackTrace) {
//     setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }
// }
