class User {
  int id;
  String username;
  String name;
  String email;
  String userImage;
  String referralCode;
  String phoneNumber;
  String emailVerifiedAt;
  String rememberToken;
  String status;
  String createdAt;
  String updatedAt;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.userImage,
    required this.referralCode,
    required this.phoneNumber,
    required this.emailVerifiedAt,
    required this.rememberToken,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      userImage: json['user_image'],
      referralCode: json['referral_code'],
      phoneNumber: json['phone_number'],
      emailVerifiedAt: json['email_verified_at'],
      rememberToken: json['remember_token'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Token {
  Map<String, dynamic> headers;
  Map<String, dynamic> original;
  String? exception;

  Token({
    required this.headers,
    required this.original,
    this.exception,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      headers: json['headers'],
      original: json['original'],
      exception: json['exception'],
    );
  }
}

class LoginResponseModel {
  String message;
  String messageTitle;
  Token token;
  User user;

  LoginResponseModel({
    required this.message,
    required this.messageTitle,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      messageTitle: json['message_title'],
      token: Token.fromJson(json['token']),
      user: User.fromJson(json['token']['original']['user']),
    );
  }
}
