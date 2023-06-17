// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// import '../../Ads/Unity/unityads.dart';

// class WebViewScreen extends StatefulWidget {
//   final String url;

//   WebViewScreen({required this.url});

//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }

// void myFunction() {
//   print('Executing myFunction when user navigates back');
//   UnityAdManater.showIntAd();
// }

// class _WebViewScreenState extends State<WebViewScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       await UnityAdManater.loadUnityAdINT();
//     });
//     SystemChrome.setPreferredOrientations([]);
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         // Execute the function and print something
//         myFunction();

//         // Allow the page to be popped
//         return Future.value(true);
//       },
//       child: WebviewScaffold(
//         url: widget.url,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Ads/Unity/unityads.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
void myFunction() {
  print('Executing myFunction when user navigates back');
  UnityAdManater.showIntAd();
}

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
         WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await UnityAdManater.loadUnityAdINT();
    });
    SystemChrome.setPreferredOrientations([]);
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}





class GamePlay extends StatefulWidget {
  const GamePlay({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  late final WebViewController controller;
void showAd() {
  
  UnityAdManater.showIntAd();
}
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      )
      
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
             WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await UnityAdManater.loadUnityAdINT();
    });
    SystemChrome.setPreferredOrientations([]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
   Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showAd();
        return true;
      },
      child: Scaffold(
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}

