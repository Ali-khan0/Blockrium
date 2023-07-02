import 'dart:convert';

import 'package:Blockrium/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../View new/Widgets/custom_appbar.dart';
import '../../res/Colorsnew/appcolors.dart';
import '../Resources/appurl.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
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
        AppUrl.getTeamData,
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

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: SubScreenApbarBlack(
          title: "Your Network",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: getProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          SizedBox(
                            height: h * 0.3,
                          ),
                          Center(child: loading(w, h * 0.3)),
                        ],
                      );
                    } else {
                      if (data["referred_by_user_data"].length == 0) {
                        return Container(
                            height: Get.height * 0.7,
                            child: Center(
                                child: Text(
                              'No data available',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )));
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data["referred_by_user_data"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return teamListile(
                              h,
                              w,
                              data["referred_by_user_data"][index]["name"]
                                  .toString(),
                              data["referred_by_user_data"][index]["email"]
                                  .toString(),
                            );
                          },
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget teamListile(h, w, name, email) {
  return Container(
    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
        name,
        style: TextStyle(color: Colors.white),
      ),
      // trailing: Container(
      //   height: 30,
      //   width: 60,
      //   child: Center(
      //     child: Text("Chat"),
      //   ),
      //   decoration: BoxDecoration(
      //       color: Colors.blue.shade100,
      //       borderRadius: BorderRadius.all(Radius.circular(5))),
      // ),
      subtitle: Text(
        email,
        style: TextStyle(color: Colors.white),
      ),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage("assets/avatar.jpg"),
      ),
    ),
  );
}
