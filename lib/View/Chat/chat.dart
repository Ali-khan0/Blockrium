import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        elevation: 0,
        leading: Image(image: AssetImage("assets/blockrium.png")),
        backgroundColor: Colors.white,
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Chat Will be available soon",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Center(child: Image(image: AssetImage("assets/comingsoon.png")))
          // Container(
          //     height: 50,
          //     width: w * 0.9,
          //     decoration: BoxDecoration(
          //         color: Colors.blue.shade50,
          //         borderRadius: BorderRadius.all(Radius.circular(20))),
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 15.0),
          //       child: TextFormField(
          //         decoration: InputDecoration(
          //             icon: Icon(Icons.search),
          //             border: InputBorder.none,
          //             focusedBorder: InputBorder.none,
          //             enabledBorder: InputBorder.none,
          //             errorBorder: InputBorder.none,
          //             disabledBorder: InputBorder.none,
          //             labelText: "Search"),
          //       ),
          //     )),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => DetailChat()),
          //     );
          //   },
          //   child: ListTile(
          //     title: Text("Amelia"),
          //     subtitle: Text("did you get the daily rewards?"),
          //     leading: CircleAvatar(
          //       radius: 25,
          //       backgroundColor: Colors.white,
          //       backgroundImage: NetworkImage(
          //           "https://static-cse.canva.com/blob/975732/1600w-EW4cggXkgbc.jpg"),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
