class banners {
  int? status;
  List<Data>? data;

  banners({this.status, this.data});

  banners.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? paragraph;
  String? image;
  String? date;
  String? createdAt;
  String? deletedAt;

  Data(
      {this.id,
      this.title,
      this.paragraph,
      this.image,
      this.date,
      this.createdAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    paragraph = json['paragraph'];
    image = json['image'];
    date = json['date'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['paragraph'] = this.paragraph;
    data['image'] = this.image;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
