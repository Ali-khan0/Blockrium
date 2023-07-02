import 'dart:convert';

import 'package:Blockrium/View%20new/Profile/edit_profile_new.dart';
import 'package:Blockrium/View/Streak/streak.dart';
import 'package:Blockrium/View/Team/team.dart';
import 'package:Blockrium/res/AppIcons/appicons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/Profile/whitepaper.dart';
import '../../View/Resources/appurl.dart';
import '../../View/Terms & Policy & About us/terms_policy.dart';
import '../../View/refferal/refferal.dart';
import '../../res/Colorsnew/appcolors.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/Wallet_view_model/wallet_view_model.dart';
import '../../widget/widget.dart';
import '../Widgets/custom_appbar.dart';
import 'package:http/http.dart' as http;

class ProfilePageNew extends StatefulWidget {
  const ProfilePageNew({super.key});

  @override
  State<ProfilePageNew> createState() => _ProfilePageNewState();
}

class _ProfilePageNewState extends State<ProfilePageNew> {
  final WalletViewModel _walletViewModel = WalletViewModel();

  @override
  void initState() {
    super.initState();
    _walletViewModel.getNameSharedPref();
    getProfile();
  }

  var data;
  Future getProfile() async {
    // void getsharedpref() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');
// }
    debugPrint("userid ============ $id");

    debugPrint("remToken ============ $token");
    if (token != null) {
      debugPrint("not null");
      final response = await http.get(
        Uri.parse(
          AppUrl.getuserProfile,
        ),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        debugPrint(data["message"]);
      } else {
        debugPrint("====== not geting data");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: "Profile",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                final username = _walletViewModel.userName.value;
                final email = _walletViewModel.email.value;
                final profileImage = _walletViewModel.profileImg.value;
                return Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white38),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColor.purpleColor.withOpacity(0.3),
                            AppColor.pinkColor.withOpacity(0.3)
                          ]),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(profileImage == ""
                              ? "https://lh3.googleusercontent.com/pw/AJFCJaU0GU1whPNk7q4vw0eIfgsJP59K49IzweB9Vz2sz-Ph3fbgE5Yl1mrqNtfY3DXxUhSe3NFnciEkLUsVmCKfs3AatWQ-Mu7X5nXvFhDsZVF9dNtBSpRuU9Bjo_3VGffaNRS71rX8aKlsISZH2nW8hW9z=w225-h225-s-no"
                              : profileImage),
                          radius: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          width: Get.width * 0.55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                username.toUpperCase(),
                                style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                email,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color:
                                        AppColor.whiteColor.withOpacity(0.7)),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(EditProfile());
                                },
                                child: Container(
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                        ),
                                      ],
                                      gradient: LinearGradient(colors: [
                                        Color(0xff9C3FE4),
                                        Color(0xffC65647),
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Center(
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: InkWell(
                  onTap: () {
                    Utilsnew.alertDialogLogout(context, () {});
                  },
                  child: profileContainer("Logout", AppIcons.logout,
                      "Logout without loosing account data"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: InkWell(
                  onTap: () {
                    Get.to(TeamPage());
                  },
                  child: profileContainer(
                      "Your Network", AppIcons.team, "People you invited"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: InkWell(
                  onTap: () {
                    Get.to(StreakPage());
                  },
                  child: profileContainer(
                      "Top Users", AppIcons.stats, "See Who is on Top"),
                ),
              ),
              // profileContainer(
              //     "Notification", AppIcons.wallet, "Get update about the App"),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Obx(() {
                    final refcode = _walletViewModel.refcode.value;

                    final username = _walletViewModel.userName.value;
                    return InkWell(
                      onTap: () {
                        Get.to(ShareRefferal(
                          refcode: refcode,
                          username: username,
                        ));
                      },
                      child: profileContainer("My Referral Code", AppIcons.code,
                          "Get your referral code"),
                    );
                  })),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: InkWell(
                  onTap: () {
                    enterRefCodeDialog(
                        context,
                        Get.height,
                        Get.width,
                        _walletViewModel.joinRefealCTRL.value,
                        data["is_referred_by"]);
                    // _showMyDialog(context, h, w);
                    // debugPrint(data["is_referred_by"]);
                    // enterRefCodeDialog(
                    //     context, h, w, joinRefealCTRL, data["is_referred_by"]);
                  },
                  child: profileContainer("Join Team", AppIcons.join,
                      "Enter the referral code you got"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: InkWell(
                  onTap: () {
                    Get.to(PolicyTerms());
                  },
                  child: profileContainer("Privacy Policy", AppIcons.privacy,
                      "Blockrium Privacy Policy"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: InkWell(
                  onTap: () {
                    Get.to(WhitePaper());
                  },
                  child: profileContainer("Whitepaper", AppIcons.whitepaper,
                      "Blockrium Whitepaper"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget profileContainer(title, icon, subtitle) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.purpleColor.withOpacity(0.2),
              AppColor.pinkColor.withOpacity(0.2)
            ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(color: AppColor.whiteColor),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColor.whiteColor),
      ),
      leading: Image(
        image: AssetImage(icon),
        height: 40,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        color: Colors.white,
      ),
    ),
  );
}
