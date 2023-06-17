// import 'package:asdawaj/data/response/status.dart';
// import 'package:asdawaj/models/AllFavoritePostModel/all_favorite_post_model.dart';
// import 'package:get/get.dart';

// import '../../../models/userPostModel/userpost_model.dart';
// import '../../../repository/AllFavoritePostRepo/all_fav_post_repo.dart';

// class AllFavoritePostController extends GetxController {
//   final _api = AllFavoritePostRepositry();

//   final rxRequestStatus = Status.LOADING.obs;
//   final favoritePostList = AllFavoritePostModel().obs;
//   RxString error = "".obs;

//   void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
//   void setuserProfileList(AllFavoritePostModel _value) =>
//       favoritePostList.value = _value;
//   void setError(String _value) => error.value = _value;
//   void allFavoritePostListApi() {
//     _api.allFavoritePostApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setuserProfileList(value);
//     }).onError((error, stackTrace) {
//       setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }

//   void refreshAllFavoritePostListApi() {
//     setRxRequestStatus(Status.LOADING);
//     _api.allFavoritePostApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setuserProfileList(value);
//     }).onError((error, stackTrace) {
//       setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }
// }
