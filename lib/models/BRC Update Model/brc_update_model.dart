class BRCUpdateModel {
  int? status;
  String? message;
  List<UserData>? userData;

  BRCUpdateModel({this.status, this.message, this.userData});

  BRCUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['userData'] != null) {
      userData = <UserData>[];
      json['userData'].forEach((v) {
        userData!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userData != null) {
      data['userData'] = this.userData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? title;
  String? paragraph;
  String? date;
  String? image;

  UserData({this.id, this.title, this.paragraph, this.date, this.image});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    paragraph = json['paragraph'];
    date = json['date'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['paragraph'] = this.paragraph;
    data['date'] = this.date;
    data['image'] = this.image;
    return data;
  }
}
