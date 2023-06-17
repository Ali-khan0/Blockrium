import 'package:flutter/material.dart';
import 'package:get/get.dart';

void transfer(w, h) {
  Get.bottomSheet(Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: ListTile(
              leading: Text(
                "Pay To",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close)),
            ),
          ),
          Container(
            height: h * 0.9,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                    height: 50,
                    width: w * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            labelText: "Search"),
                      ),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Transfer Will be available soon",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Center(
                        child:
                            Image(image: AssetImage("assets/comingsoon.png")))
                  ],
                ),
                // InkWell(
                //     onTap: () {
                //       Get.back();
                //       Get.to(TransferDetail());
                //     },
                //     child: transferMember())
              ],
            ),
          )
        ],
      ),
    ),
  ));
}

Widget transferMember() {
  return ListTile(
    leading: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(
          "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcm01MTUtaWxsdXN0cmF0aW9uLTAxNWMteC5qcGc.jpg"),
    ),
    title: Text("Mudassir Mukhtyar"),
    subtitle: Text("@4744"),
  );
}
