import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:http/http.dart' as http;

import 'Widget/maticupdatedetail.dart';
import 'Widget/widget.dart';

class MaticUpdateFull extends StatefulWidget {
  const MaticUpdateFull({super.key});

  @override
  State<MaticUpdateFull> createState() => _MaticUpdateFullState();
}

class _MaticUpdateFullState extends State<MaticUpdateFull> {
  var data;

  Future<void> getBanners() async {
    final response =
        await http.get(Uri.parse("https://maticlegend.com/api/banners"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {
      print("====== not geting data");
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
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
          // backgroundColor: Colors.white,
          title: Text(
            "Blockrium Update",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getBanners(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.beat(
                    color: Colors.purple.shade300,
                    size: 35,
                  ),
                );
              } else {
                return
                    // Text(data["data"][0]["title"].toString());
                    ListView.builder(
                  itemCount: data["userData"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(MaticUpdateDetail(
                            image: data["userData"][index]["image"].toString(),
                            title: data["userData"][index]["title"].toString(),
                            date: data["userData"][index]["date"].toString(),
                            para: data["userData"][index]["paragraph"]
                                .toString()));
                      },
                      child: maticupdate2(
                        data["userData"][index]["title"].toString(),
                        data["userData"][index]["date"].toString(),
                        data["userData"][index]["image"].toString(),
                      ),
                    );
                  },
                );
              }
            }));
  }
}

Widget maticupdate2(title, date, image) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0.1,
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(date),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image(image: NetworkImage(image)),
        ),
      ),
    ),
  );
}
