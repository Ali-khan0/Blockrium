import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:Blockrium/utils/utils.dart';
import 'package:adcolony_flutter/adcolony_flutter.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Ads/Admob/admob.dart';
import '../../../Ads/Unity/unityads.dart';
import '../../../View new/Widgets/custom_appbar.dart';
import '../../../res/colors/app_colors.dart';
import '../../Resources/appurl.dart';
import '../../Resources/utils.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent('Normal Event D',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 0),
        color: AppColor.purpleColor),
  ];

  final String _interstitial_ad_unit_id =
      Platform.isAndroid ? "e12b4397e739b0bd" : "e12b4397e739b0bd";

  var _interstitialRetryAttempt = 0;

  void initializeInterstitialAdsAttendance() {
    addAttendance();
    setState(() {});
  }

  Future getProfile() async {
    // void getsharedpref() async {
    final String? id;

    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');
// }
    debugPrint("userid ============ $id");

    debugPrint("remToken ============ $token");
    if (token != null) {
      debugPrint("not null");
      final response = await http.get(
        Uri.parse(
          AppUrl.getuserProfile,
        ),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        debugPrint(data["message"]);
        debugPrint(data["attendance"]);
      } else {
        debugPrint("====== not geting data");
      }
    }
  }

  var attendancedata;
  Future addAttendance() async {
    // void getsharedpref() async {
    final String? id;
    var coints = "1";
    final prefs = await SharedPreferences.getInstance();
    final String? token;
    id = prefs.getString('userid');
    token = prefs.getString('remToken');

    if (token != null) {
      debugPrint("not null");

      var response = await post(
        Uri.parse(AppUrl.addAttendanceEntPoint),
        body: {
          "coins": coints,
          // "password": password,
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        attendancedata = jsonDecode(response.body.toString());
        Utils.snackbar(attendancedata["message"].toString(), "");
        UnityAdManater.showRwdAd()
            .then((value) => UnityAdManater.loadUnityAdRWD());
        // UnityAdManater.showRwdAd();
      } else {
        Utils.snackbar("Something went wrong", "");
      }
    }
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await UnityAdManater.loadUnityAdRWD();
    });

    getProfile();
    super.initState();
  }

  var data;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: SubScreenApbarBlack(
          title: "Daily Attendance",
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AbsorbPointer(
                absorbing: true,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    // height: 180,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white38),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColor.purpleColor.withOpacity(0.3),
                              AppColor.pinkColor.withOpacity(0.3)
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: CalendarAppBar(
                      white: Colors.white,
                      black: Colors.transparent,
                      accent: Color.fromARGB(34, 0, 0, 0),
                      padding: 0.0,
                      backButton: false,
                      fullCalendar: true,
                      // fullCalendar: true,
                      // events:
                      //     // lst
                      //     List.generate(1,
                      //         (index) => DateTime.now().subtract(Duration(days: index * 1))),
                      onDateChanged: (value) => debugPrint(value),
                      firstDate: DateTime.now().subtract(Duration(days: 140)),
                      lastDate: DateTime.now(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: getProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          Center(child: loading(w, h * 0.4)),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data["attendance"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return attendancelist(
                              w,
                              h,
                              data["attendance"][index]["attendance_date"]
                                  .toString(),
                              data["attendance"][index]["coins"].toString());
                        },
                      );
                      // Text(data["data"][0]["title"].toString());
                    }
                  }),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white38),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColor.purpleColor.withOpacity(0.3),
                    AppColor.pinkColor.withOpacity(0.3)
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 50,
          width: w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                  onTap: () {
                    initializeInterstitialAdsAttendance();
                    // addAttendance();
                    setState(() {});
                  },
                  child: Card(
                    child: Container(
                      // height: h * 0.05,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
                          child: Text(
                            "Claim Attendance",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppColor.redColor,
                            AppColor.pinkColor,
                            AppColor.purpleColor
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
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

Widget attendancelist(w, h, title, coin) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
    child: Container(
      // height: 50,
      width: w,
      // color: Colors.green,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white38),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.purpleColor.withOpacity(0.3),
                AppColor.pinkColor.withOpacity(0.3)
              ]),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        leading: Container(
          width: 10,
          decoration: BoxDecoration(
              // color: Colors.green,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.redColor,
                    AppColor.pinkColor,
                    AppColor.purpleColor
                  ]),
              // color: Color.fromARGB(255, 305, 221, 7),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 8,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          "1 BRC added to Wallet",
          style: TextStyle(color: Colors.white),
        ),
        trailing: CircleAvatar(
          radius: 5,
          backgroundColor: AppColor.purpleColor,
        ),
      ),
    ),
  );
}
