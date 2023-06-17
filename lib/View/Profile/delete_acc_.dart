import 'package:flutter/material.dart';

import '../../widget/widget.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    
  bool isLoading = false; // Add this variable to track loading state
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   // toolbarHeight: 80,
      //   elevation: 0,
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: Icon(
      //       Icons.keyboard_arrow_left,
      //       color: Colors.black,
      //       size: 40,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     "Delete Account",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        // toolbarHeight: 80,
        elevation: 0,
        // leadingWidth: 100,
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
        title: Text(
          "Delete Account",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Submit a request for deletion of your account.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "NOTE: after 10 days of request your account will be deleted and you'll no longer have access to your account.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                InkWell(
                    onTap: () {}, child: roundButton(h, w, "Delete Account",isLoading)),
                Text(
                    "Please Contact at our email if you want to cancel the request"),
                Text(
                  "support@maticlegend.com",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
