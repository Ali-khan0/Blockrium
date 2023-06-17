import 'package:flutter/material.dart';

class DetailChat extends StatelessWidget {
  const DetailChat({super.key});

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
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  "https://static-cse.canva.com/blob/975732/1600w-EW4cggXkgbc.jpg"),
            ),
            Text(
              "Amelia",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 30,
                  width: 150,
                  child: Center(
                    child: Text("How is it goin' mate?"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "3:05 AM",
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
          ),
          message("did you get the daily reward?", "3:05")
        ],
      ),
    );
  }
}

Widget message(message, time) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // height: 30,
          width: 150,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(message),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            time,
            style: TextStyle(fontSize: 12),
          ),
        )
      ],
    ),
  );
}
