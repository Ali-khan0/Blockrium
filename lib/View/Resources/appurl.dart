class AppUrl {
  static var baseUrl = "https://maticlegend.com/api";

  static var loginEndPoint = "https://maticlegend.com/api/auth/login";

  static var signUpEndPoint = "$baseUrl/auth/register";

  static var bannersEndPoint = "$baseUrl/banners";

  static var getuserProfile = "$baseUrl/auth/profile";

  static var updateUserEndPoint = "$baseUrl/auth/profile_update";

  static var addAttendanceEntPoint = "$baseUrl/auth/userattendance";

  static var userWallet = "$baseUrl/auth/wallet";

  static var dailyRewardEndpoint = "$baseUrl/auth/dailyreward";

  static var logoutEndpoint = "$baseUrl/auth/logout";
// // add Fee
  static var miningEndPoint = "$baseUrl/auth/auth_mining";
  static var newminingEndPoint = "$baseUrl/auth/click-button";
// // delete fee
  static var getMiningEndPoint = "$baseUrl/auth/get_mining";
  static var getTeamData = "$baseUrl/auth/referred-by-team";

  static var joinRefferal = "$baseUrl/auth/update-referred-by";

  static var randomRewardsEndPoint = "$baseUrl/auth/random-dailyreward";
  static var randomRewardsStatusEndPoint = "$baseUrl/auth/reward-status";
  static var appStageEndPoint = "$baseUrl/app-stage";
  static var getNotificationEndPoint = "$baseUrl/auth/getnotification";
  static var countNotificationEndPoint = "$baseUrl/auth/count-notification";
  static var markReadNotificationEndPoint =
      "$baseUrl/auth/notifications/mark-as-read";
  static var getAllNotificationEndPoint = "$baseUrl/auth/all-notification";
  static var updatePasswordEndPoint = "$baseUrl/update-password";
}
