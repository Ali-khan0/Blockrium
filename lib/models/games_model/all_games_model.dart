class AllGamesModel {
  int? status;
  String? message;
  List<AllGames>? allGames;

  AllGamesModel({this.status, this.message, this.allGames});

  AllGamesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['all_games'] != null) {
      allGames = <AllGames>[];
      json['all_games'].forEach((v) {
        allGames!.add(new AllGames.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.allGames != null) {
      data['all_games'] = this.allGames!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllGames {
  String? id;
  String? gamename;
  String? gamecategory;
  String? url;
  String? logo;

  AllGames({this.id, this.gamename, this.gamecategory, this.url, this.logo});

  AllGames.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gamename = json['gamename'];
    gamecategory = json['gamecategory'];
    url = json['url'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gamename'] = this.gamename;
    data['gamecategory'] = this.gamecategory;
    data['url'] = this.url;
    data['logo'] = this.logo;
    return data;
  }
}
