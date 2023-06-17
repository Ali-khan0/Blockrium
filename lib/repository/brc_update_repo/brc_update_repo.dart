


import '../../data/network/network_api_services.dart';
import '../../models/BRC Update Model/brc_update_model.dart';
import '../../models/Games_Model/all_games_model.dart';
import '../../models/NewModel/newmodel.dart';
import '../../res/appurl.dart';

class BrcUpdateRepositry{
  final _apiService = NetworkApiServices();
Future<BRCUpdateModel> allBRCUpdateAPI() async{
  dynamic response =await _apiService.getApi("https://maticlegend.com/api/banners");
  return BRCUpdateModel.fromJson(response);
}
}