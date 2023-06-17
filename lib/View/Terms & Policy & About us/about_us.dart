import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.white,
        title: Text(
          "About Us",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Purpose & Goal.",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  " DurraniExpress is a platform built by ShaheenDevelopers for Male & Female who envisioned to provide a one-stop online platform to search, compare, and buy from a range of leading local and 100% original global brands, all from the very comfort of their homes.",
                  style: TextStyle(fontSize: 17)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  """ We are here to ensure that you shop in the fastest, most convenient, and most cost-effective manner for the best of your family.
So hang on DurraniExpress..we’ve got your back!.""",
                  style: TextStyle(fontSize: 17)),
            )
          ],
        ),
      ),
    );
  }
}
