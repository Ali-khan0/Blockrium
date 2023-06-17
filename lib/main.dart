import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'Ads/Admob/admob_keys.dart';
import 'View new/Intro_Screen/introscreen.dart';
import 'View new/authentication/loginpage.dart';
import 'View/bottomnav.dart';
import 'res/colors/app_colors.dart';
import 'view_models/services/no_internet.dart';
import 'package:permission_handler/permission_handler.dart';


FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await UnityAds.init(
    gameId: '5212184',
    onComplete: () => print('Initialization Complete'),
    onFailed: (error, message) =>
        print('Initialization Failed: $error $message'),
  );
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();

  // await Flurry.initialize(
  //     androidKey: "JFNVHKCJJ3PR48DTKG6S",
  //     iosKey: "JFNVHKCJJ3PR48DTKG6S",
  //     enableLog: true);
  tzdata.initializeTimeZones();
  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true);
  InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings, iOS: iosSettings);
  bool? initialized =
      await notificationsPlugin.initialize(initializationSettings);
  print("Notifications: $initialized");

  var status = await Permission.notification.status;
  if (status.isGranted) {
    print('Notifications permission already granted');
  } else {
    var result = await Permission.notification.request();
    if (result.isGranted) {
      print('Notifications permission granted');
    } else {
      print('Notifications permission denied');
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blockrium',
        theme: ThemeData(
            fontFamily: 'Montserrat',
            primarySwatch: Colors.red,
            useMaterial3: true),
        home: InternetConnectivityWidget());
  }
}

class InternetConnectivityWidget extends StatefulWidget {
  const InternetConnectivityWidget({Key? key}) : super(key: key);

  @override
  _InternetConnectivityWidgetState createState() =>
      _InternetConnectivityWidgetState();
}

class _InternetConnectivityWidgetState
    extends State<InternetConnectivityWidget> {
  late bool _isConnected;
  late bool _isCheckingConnectivity;

  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
  }

  Future<void> _checkInternetConnectivity() async {
    setState(() {
      _isCheckingConnectivity = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi);
      _isCheckingConnectivity = false;
    });
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingConnectivity) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: Get.height,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else if (_isConnected == null || !_isConnected) {
      return NoInternet(
        func: _checkInternetConnectivity,
      );
    } else {
      return FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return MyBottomNavbar();
            } else {
              return OnBoardingPage();
            }
          } else {
            return Container(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
}
