


import '../../data/network/network_api_services.dart';
import '../../models/Games_Model/all_games_model.dart';
import '../../res/appurl.dart';

class GamesRepositry{
  final _apiService = NetworkApiServices();
Future<AllGamesModel> allGamesAPI() async{
  dynamic response =await _apiService.getApi("https://maticlegend.com/api/games");
  return AllGamesModel.fromJson(response);
}


}