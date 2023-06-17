import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPayDetail extends StatelessWidget {
  const QrPayDetail({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
          "My PayCode",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: h * 0.5,
          width: w * 0.9,
          decoration: BoxDecoration(
              // color: Colors.green,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 8,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Ali",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text("Scan my code to pay"),
              Center(
                child: Container(
                  // color: Colors.pink,
                  height: h * 0.4,
                  width: w * 0.8,
                  child: QrImageView(
                    data: "ali1203526456",
                    version: QrVersions.min,
                    size: 200.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
