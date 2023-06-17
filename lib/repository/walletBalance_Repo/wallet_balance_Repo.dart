

import '../../View/Resources/appurl.dart';
import '../../data/network/network_api_services.dart';
import '../../models/all_post_model/allpostmodel.dart';

class AllPostRepositry{
  final _apiService = NetworkApiServices();
Future<AllProfilePostModel> allProfileApi() async{
  dynamic response =await _apiService.getApiBearer(AppUrl.userWallet);
  return AllProfilePostModel.fromJson(response);
}
}