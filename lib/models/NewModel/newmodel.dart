class NewsModel {
  int? status;
  String? message;
  List<UserData>? userData;

  NewsModel({this.status, this.message, this.userData});

  NewsModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? categories;
  String? link;
  String? createdAt;
  String? image;

  UserData(
      {this.id,
      this.title,
      this.description,
      this.categories,
      this.link,
      this.createdAt,
      this.image});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    categories = json['categories'];
    link = json['link'];
    createdAt = json['created_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['categories'] = this.categories;
    data['link'] = this.link;
    data['created_at'] = this.createdAt;
    data['image'] = this.image;
    return data;
  }
}
