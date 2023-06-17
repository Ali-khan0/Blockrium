


import '../../data/network/network_api_services.dart';
import '../../models/Games_Model/all_games_model.dart';
import '../../models/NewModel/newmodel.dart';
import '../../res/appurl.dart';

class NewsRepositry{
  final _apiService = NetworkApiServices();
Future<NewsModel> allNewsAPI() async{
  dynamic response =await _apiService.getApi("https://maticlegend.com/api/get-news");
  return NewsModel.fromJson(response);
}


}