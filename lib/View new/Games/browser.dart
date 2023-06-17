// import 'package:Blockrium/View/Games/web_view_helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';


// class BrowserApp extends StatefulWidget {
//   const BrowserApp({
//     Key? key,
//     required this.engine,
//   }) : super(key: key);
//   final String engine;
//   @override
//   _BrowserAppState createState() => _BrowserAppState();
// }

// class _BrowserAppState extends State<BrowserApp> {
//   String _currentUrl = "";
//   bool _isLoading = true;

//   // void search(String searchEngine, [String? query]) async {
//   //   var url;
//   //   if (searchEngine == "presearch") {
//   //     url = "https://presearch.org/search?q=${query ?? ""}";
//   //   } else {
//   //     url = "https://duckduckgo.com/?q=${query ?? ""}";
//   //   }
//   //   await _controller.loadUrl(url);
//   // }

//   // TextEditingController searchController = TextEditingController();
//   // late WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Navigator.of(context).pop();
//             searchController.clear();
//           },
//           child: Icon(
//             Icons.keyboard_arrow_left,
//             color: Colors.black,
//             size: 40,
//           ),
//         ),
//         title: SizedBox(
//           width: Get.width * 0.6,
//           height: Get.height * 0.05,
//           child: TextField(
//             controller: searchController,
//             onSubmitted: (value) {
//               search(webcontroller, widget.engine);
//             },

//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.symmetric(vertical: 10.0),
//               hintText: 'Search on ${widget.engine}',
//               border: OutlineInputBorder(),
//             ),
//             textAlignVertical: TextAlignVertical.center, // Add this line
//           ),
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: InkWell(
//               onTap: () {
//                 search(webcontroller, widget.engine);
//               },
//               child: Container(
//                 height: 30,
//                 width: 60,
//                 child: Center(
//                   child: Text("Search"),
//                 ),
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 8,
//                       ),
//                     ],
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: <Widget>[
//           WebView(
//             initialUrl: 'https://maticlegend.com/',
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (controller) => webcontroller = controller,
//             onPageFinished: (url) async {
//               setState(() {
//                 _currentUrl = url;
//                 _isLoading = false;
//               });
//             },
//           ),
//           _isLoading
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : Container(),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         padding: EdgeInsets.only(left: 10, right: 10),
//         // height: Get.height * 0.12,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 8.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   // Row(
//                   //   children: <Widget>[
//                   //     InkWell(
//                   //       onTap: () {
//                   //         search("presearch");
//                   //       },
//                   //       child: Container(
//                   //         width: 30,
//                   //         height: 30,
//                   //         decoration: BoxDecoration(
//                   //           borderRadius: BorderRadius.circular(50),
//                   //           color: _currentUrl.contains("presearch")
//                   //               ? Colors.grey
//                   //               : Colors.white,
//                   //         ),
//                   //         child: Icon(Icons.search),
//                   //       ),
//                   //     ),
//                   //     SizedBox(
//                   //       width: 8,
//                   //     ),
//                   //     InkWell(
//                   //       onTap: () {
//                   //         search("duckduckgo");
//                   //       },
//                   //       child: Container(
//                   //         width: 30,
//                   //         height: 30,
//                   //         decoration: BoxDecoration(
//                   //           borderRadius: BorderRadius.circular(50),
//                   //           color: _currentUrl.contains("duckduckgo")
//                   //               ? Colors.grey
//                   //               : Colors.white,
//                   //         ),
//                   //         child: Icon(Icons.search),
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
//                   // IconButton(
//                   //     onPressed: () {
//                   //       if (_controller != null) {
//                   //         search("duckduckgo", searchController.text);
//                   //       }
//                   //     },
//                   //     icon: Icon(Icons.search)),
//                   // Expanded(
//                   //   child: Padding(
//                   //     padding: EdgeInsets.only(left: 8.0, right: 8.0),
//                   //     child: TextField(
//                   //       controller: searchController,
//                   //       decoration: InputDecoration(
//                   //         hintText: 'Search',
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   SizedBox(
//                     width: Get.width * 0.6,
//                     height: Get.height * 0.05,
//                     child: TextField(
//                       controller: TextEditingController(text: _currentUrl),
//                       onChanged: (value) {
//                         setState(() {
//                           _currentUrl = value;
//                         });
//                       },
//                       enabled: false,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.symmetric(vertical: 10.0),
//                         hintText: 'loading...',
//                         border: OutlineInputBorder(),
//                       ),
//                       textAlignVertical:
//                           TextAlignVertical.center, // Add this line
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Clipboard.setData(ClipboardData(text: _currentUrl));
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Copied to clipboard'),
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.copy_all),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.refresh),
//                     onPressed: () {
//                       webcontroller.reload();
//                     },
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // IconButton(
//                   //   padding: EdgeInsets.all(0),
//                   //   icon: Icon(Icons.arrow_back),
//                   //   onPressed: () async {
//                   //     if (await _controller.canGoBack()) {
//                   //       _controller.goBack();
//                   //     }
//                   //   },
//                   // ),
//                   InkWell(
//                       onTap: () async {
//                         if (await webcontroller.canGoBack()) {
//                           webcontroller.goBack();
//                         }
//                       },
//                       child: Icon(Icons.arrow_back)),
//                   InkWell(
//                       onTap: () async {
//                         if (await webcontroller.canGoForward()) {
//                           webcontroller.goForward();
//                         }
//                       },
//                       child: Icon(Icons.arrow_forward)),

//                   // IconButton(
//                   //   padding: EdgeInsets.all(0),
//                   //   icon: Icon(Icons.arrow_forward),
//                   //   onPressed: () async {
//                   //     if (await _controller.canGoForward()) {
//                   //       _controller.goForward();
//                   //     }
//                   //   },
//                   // ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
