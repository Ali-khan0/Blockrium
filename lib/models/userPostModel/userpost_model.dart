class UserPostModel {
  String? message;
  String? messageTitle;
  List<Getallpost>? getallpost;

  UserPostModel({this.message, this.messageTitle, this.getallpost});

  UserPostModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageTitle = json['message_title'];
    if (json['getallpost'] != null) {
      getallpost = <Getallpost>[];
      json['getallpost'].forEach((v) {
        getallpost!.add(new Getallpost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['message_title'] = this.messageTitle;
    if (this.getallpost != null) {
      data['getallpost'] = this.getallpost!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Getallpost {
  int? id;
  String? name;
  String? postedBy;
  String? postExpiry;
  String? age;
  String? postdate;
  String? profession;
  String? distance;
  String? likes;
  String? pic;
  String? city;
  String? country;
  String? about;
  String? hobbies;
  String? gander;
  String? martialStatus;
  String? religion;
  String? languageKnown;
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
  String? postStatus;
  String? createdAt;
  String? updatedAt;
  List<String>? imageUrls;
  List<String>? hobbie;
  String? languageKnowns;

  Getallpost(
      {this.id,
      this.name,
      this.postedBy,
      this.postExpiry,
      this.age,
      this.postdate,
      this.profession,
      this.distance,
      this.likes,
      this.pic,
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
      this.postStatus,
      this.createdAt,
      this.updatedAt,
      this.imageUrls,
      this.hobbie,
      this.languageKnowns});

  Getallpost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    postedBy = json['postedBy'];
    postExpiry = json['post_expiry'];
    age = json['age'];
    postdate = json['postdate'];
    profession = json['profession'];
    distance = json['distance'];
    likes = json['likes'];
    pic = json['pic'];
    city = json['city'];
    country = json['country'];
    about = json['about'];
    hobbies = json['hobbies'];
    gander = json['gander'];
    martialStatus = json['martialStatus'];
    religion = json['religion'];
    languageKnown = json['languageKnown'];
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
    postStatus = json['post_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrls = json['image_urls'].cast<String>();
    hobbie = json['hobbie'].cast<String>();
    languageKnowns = json['languageKnowns'];
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
    data['pic'] = this.pic;
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
    data['post_status'] = this.postStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_urls'] = this.imageUrls;
    data['hobbie'] = this.hobbie;
    data['languageKnowns'] = this.languageKnowns;
    return data;
  }
}
