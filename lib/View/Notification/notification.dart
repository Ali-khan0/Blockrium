import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Resources/appurl.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

var data;
Future getNotification() async {
  // void getsharedpref() async {
  final String? id;

  final prefs = await SharedPreferences.getInstance();
  final String? token;
  id = prefs.getString('userid');
  token = prefs.getString('remToken');

  if (token != null) {
    print("not null");
    final response = await http.get(
      Uri.parse(
        AppUrl.getAllNotificationEndPoint,
      ),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      print(data["message"]);
    } else {
      print("====== not geting data");
    }
  }
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // toolbarHeight: 80,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 40,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Notification",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text("will be here soon"),
        )
        //  FutureBuilder(
        //     future: getNotification(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Column(
        //           children: [
        //             Center(
        //               child: LoadingAnimationWidget.beat(
        //                 color: Colors.blue.shade300,
        //                 size: 35,
        //               ),
        //             ),
        //           ],
        //         );
        //       } else {
        //         return ListView.builder(
        //           padding: EdgeInsets.all(0),
        //           // physics: NeverScrollableScrollPhysics(),
        //           shrinkWrap: true,
        //           itemCount: data.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             return notiwidget(data["message"], data["date"], "read");
        //           },
        //         );
        //         // Text(data["data"][0]["title"].toString());
        //       }
        //     }),
        );
  }
}

Widget notiwidget(title, subtitle, read) {
  return ListTile(
    leading: CircleAvatar(
      radius: 25,
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(
          "https://static-cse.canva.com/blob/975732/1600w-EW4cggXkgbc.jpg"),
    ),
    trailing: CircleAvatar(
      backgroundColor: Colors.blue,
      radius: Get.height * 0.0070,
    ),
    title: Text(title),
    subtitle: Text(subtitle),
  );
}
