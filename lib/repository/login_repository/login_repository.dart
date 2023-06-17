


import '../../View/Resources/appurl.dart';
import '../../data/network/network_api_services.dart';

class LoginRepositry{
  final _apiService = NetworkApiServices();
Future<dynamic> loginApi(var data) async{
  dynamic response =await _apiService.postApi(data, AppUrl.loginEndPoint);
  return response;
}
}