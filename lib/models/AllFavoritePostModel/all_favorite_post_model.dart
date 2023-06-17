class AllFavoritePostModel {
  int? status;
  String? message;
  List<UserData>? userData;

  AllFavoritePostModel({this.status, this.message, this.userData});

  AllFavoritePostModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? postedBy;
  String? postExpiry;
  String? age;
  Null? postdate;
  String? profession;
  String? distance;
  String? likes;
  String? city;
  String? country;
  String? about;
  List<String>? hobbies;
  String? gander;
  String? martialStatus;
  String? religion;
  List<String>? languageKnown;
  String? physicalStatus;
  String? motherTongue;
  String? height;
  String? weight;
  String? complexion;
  String? bodyType;
  String? hairColour;
  String? hairType;
  String? eyeColour;
  String? eyeWear;
  String? familyType;
  String? financialStatus;
  String? elderBrother;
  String? youngerBrother;
  String? marriedBrother;
  String? elderSister;
  String? youngerSister;
  String? marriedSister;
  String? createdAt;
  List<String>? pic;

  UserData(
      {this.id,
      this.name,
      this.postedBy,
      this.postExpiry,
      this.age,
      this.postdate,
      this.profession,
      this.distance,
      this.likes,
      this.city,
      this.country,
      this.about,
      this.hobbies,
      this.gander,
      this.martialStatus,
      this.religion,
      this.languageKnown,
      this.physicalStatus,
      this.motherTongue,
      this.height,
      this.weight,
      this.complexion,
      this.bodyType,
      this.hairColour,
      this.hairType,
      this.eyeColour,
      this.eyeWear,
      this.familyType,
      this.financialStatus,
      this.elderBrother,
      this.youngerBrother,
      this.marriedBrother,
      this.elderSister,
      this.youngerSister,
      this.marriedSister,
      this.createdAt,
      this.pic});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    postedBy = json['postedBy'];
    postExpiry = json['post_expiry'];
    age = json['age'];
    postdate = json['postdate'];
    profession = json['profession'];
    distance = json['distance'];
    likes = json['likes'];
    city = json['city'];
    country = json['country'];
    about = json['about'];
    hobbies = json['hobbies'].cast<String>();
    gander = json['gander'];
    martialStatus = json['martialStatus'];
    religion = json['religion'];
    languageKnown = json['languageKnown'].cast<String>();
    physicalStatus = json['physicalStatus'];
    motherTongue = json['motherTongue'];
    height = json['height'];
    weight = json['weight'];
    complexion = json['complexion'];
    bodyType = json['bodyType'];
    hairColour = json['hairColour'];
    hairType = json['hairType'];
    eyeColour = json['eyeColour'];
    eyeWear = json['eyeWear'];
    familyType = json['familyType'];
    financialStatus = json['financialStatus'];
    elderBrother = json['elderBrother'];
    youngerBrother = json['youngerBrother'];
    marriedBrother = json['marriedBrother'];
    elderSister = json['elderSister'];
    youngerSister = json['youngerSister'];
    marriedSister = json['marriedSister'];
    createdAt = json['created_at'];
    pic = json['pic'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['postedBy'] = this.postedBy;
    data['post_expiry'] = this.postExpiry;
    data['age'] = this.age;
    data['postdate'] = this.postdate;
    data['profession'] = this.profession;
    data['distance'] = this.distance;
    data['likes'] = this.likes;
    data['city'] = this.city;
    data['country'] = this.country;
    data['about'] = this.about;
    data['hobbies'] = this.hobbies;
    data['gander'] = this.gander;
    data['martialStatus'] = this.martialStatus;
    data['religion'] = this.religion;
    data['languageKnown'] = this.languageKnown;
    data['physicalStatus'] = this.physicalStatus;
    data['motherTongue'] = this.motherTongue;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['complexion'] = this.complexion;
    data['bodyType'] = this.bodyType;
    data['hairColour'] = this.hairColour;
    data['hairType'] = this.hairType;
    data['eyeColour'] = this.eyeColour;
    data['eyeWear'] = this.eyeWear;
    data['familyType'] = this.familyType;
    data['financialStatus'] = this.financialStatus;
    data['elderBrother'] = this.elderBrother;
    data['youngerBrother'] = this.youngerBrother;
    data['marriedBrother'] = this.marriedBrother;
    data['elderSister'] = this.elderSister;
    data['youngerSister'] = this.youngerSister;
    data['marriedSister'] = this.marriedSister;
    data['created_at'] = this.createdAt;
    data['pic'] = this.pic;
    return data;
  }
}
