import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';
import '../View/HomePage/Attendance/attendance.dart';
import '../View/refferal/refferal.dart';
import '../data/response/status.dart';
import '../res/AppIcons/appicons.dart';
import '../res/Colorsnew/appcolors.dart';
import '../res/components/genre_exception.dart';
import '../res/components/no_internet_widget.dart';
import '../utils/utils.dart';
import '../view_models/controller/BottomNavBar_view_model.dart/bottom_view_model.dart';
import '../view_models/controller/Random_rewards_view_model/random_rewards_viewmodel.dart';
import '../view_models/controller/Wallet_view_model/wallet_view_model.dart';
import '../view_models/controller/brc_update_viewModel/brc_update_viewmodel.dart';
import '../view_models/controller/cryptoNewViewModel/crypto_news_model.dart';
import '../widget/widget.dart';
import 'News/news.dart';
import 'News/news_details.dart';
import 'Widgets/daily_rewards.dart';
import 'Widgets/mining_container.dart';
import 'Widgets/mining_rate.dart';
import 'Widgets/news_widget.dart';
import 'Widgets/share_invite_container.dart';
import 'brc_update/brc_update_detail.dart';
import 'brc_update/brc_update_full.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WalletViewModel _walletViewModel = WalletViewModel();
  // MiningViewModel miningViewModel = Get.put(MiningViewModel());
  final BottomNavController bottomnavController = BottomNavController();
  final NewsController newsController = NewsController();
  final BrcUpdateController brcUpdateController = BrcUpdateController();
  @override
  void initState() {
    super.initState();
    newsController.allNewsListApi();
    _walletViewModel.getNameSharedPref();
    _walletViewModel.userWallet();
    _walletViewModel.getMining();
    brcUpdateController.allBRCListApi();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bottomnavController.getGiftData().then((value) {
        if (bottomnavController.isgift.value == "") {
        } else {
          showDialogNotification(bottomnavController.isgift.value,
              bottomnavController.giftBody.value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              title: Obx(() {
                final username = _walletViewModel.userName.value;
                return Text(
                  username.toUpperCase(),
                  style: TextStyle(fontSize: 17, color: Colors.white),
                );
              }),
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: .0, bottom: 8.0),
                child: Obx(() {
                  final profileImage = _walletViewModel.profileImg.value;
                  return CircleAvatar(
                    backgroundImage: NetworkImage(profileImage == ""
                        ? "https://lh3.googleusercontent.com/pw/AJFCJaU0GU1whPNk7q4vw0eIfgsJP59K49IzweB9Vz2sz-Ph3fbgE5Yl1mrqNtfY3DXxUhSe3NFnciEkLUsVmCKfs3AatWQ-Mu7X5nXvFhDsZVF9dNtBSpRuU9Bjo_3VGffaNRS71rX8aKlsISZH2nW8hW9z=w225-h225-s-no"
                        : profileImage),
                    radius: 40,
                  );
                }),
              ),
              pinned: true,
              expandedHeight: 260,
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColor.purpleColor, AppColor.pinkColor])),
                  child: FlexibleSpaceBar(
                      background: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 130,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Blockrium ( BRC )",
                                  style: TextStyle(color: AppColor.whiteColor),
                                ),
                                Image(
                                  image: AssetImage(AppIcons.brc),
                                  height: 25,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Text(
                                      // _walletViewModel
                                      //     .walletData.value['wallet_balance']
                                      //     .toString(),

                                      _walletViewModel.walletData.value.isEmpty
                                          ? "loading..."
                                          : _walletViewModel.walletData
                                              .value["wallet_balance"]
                                              .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                        color: Colors.white,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.redColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "0.5 e/hr",
                                        style: TextStyle(
                                            color: AppColor.whiteColor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        // height: 80,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.greenAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            appbarIcon("Deposit", AppIcons.deposit),
                            appbarIcon("Widhraw", AppIcons.withdraw),
                            appbarIcon("Transfer", AppIcons.transfer),
                            appbarIcon("Stake", AppIcons.stake),
                          ],
                        ),
                      )
                    ],
                  ))),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Obx(() {
                  if (_walletViewModel.getmining.value == null) {
                    return CircularProgressIndicator();
                  } else {
                    var miningData = _walletViewModel.getmining.value;
                    if (miningData["message_title"] == null ||
                        miningData["Mining_Details"] == null) {
                      // Handle the case where the required properties are null
                      return miningContainerNull(context);
                    }

                    var a = 24;
                    var b = _walletViewModel.differenceInHours;
                    var calculate = a - b;
                    debugPrint("calculate: ${calculate.toString()}");
                    // minute
                    // var totalMin = 60; // Total minutes in an hour
                    // var apiMin = miningViewModel.differenceInMinutes;
                    // var calculateMin = totalMin - apiMin;
                    // debugPrint("calculateMin: ${calculateMin.toString()}");

                    // // seconds
                    // var totalSec = 60;
                    // var apiSec = miningViewModel.differenceInSeconds;
                    // var calculateSec = totalSec - apiSec;
                    // debugPrint("calculateSec: ${calculateSec.toString()}");

                    var aa = 24;
                    var bb = _walletViewModel.differenceInHours;

                    var calculatePercentage = bb / aa * 100 / 100;

                    return Column(
                      children: [
                        miningContainer(context, calculate, calculatePercentage,
                            _walletViewModel),
                        // WaveLinearProgressIndicator(
                        //   value: () {
                        //     if (_walletViewModel.differenceInHours >= 24) {
                        //       return 0.0;
                        //     } else if (_walletViewModel.differenceInHours < 0) {
                        //       return 0.0;
                        //     } else {
                        //       return calculatePercentage;
                        //     }
                        //   }(),
                        //   labelDecoration: BoxDecoration(
                        //     gradient: LinearGradient(colors: [
                        //       AppColor.redColor,
                        //       AppColor.pinkColor,
                        //       AppColor.purpleColor
                        //     ]),
                        //     borderRadius: BorderRadius.all(Radius.circular(50)),
                        //   ),
                        //   waveBackgroundColor: AppColor.pinkColor,
                        //   enableBounceAnimation: true,
                        //   waveColor: AppColor.purpleColor,
                        //   backgroundColor: Colors.grey[150],
                        // ),
                        // SlideCountdown(
                        //   textStyle: TextStyle(color: Colors.white),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(Radius.circular(10)),
                        //     gradient: LinearGradient(colors: [
                        //       AppColor.redColor,
                        //       AppColor.pinkColor,
                        //       AppColor.purpleColor
                        //     ]),
                        //   ),
                        //   onChanged: (value) {},
                        //   duration: Duration(
                        //     hours: calculate1,
                        //     minutes: 0,
                        //   ),
                        // ),
                        // Text(
                        //   miningData["message_title"],
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        // Text(
                        //   miningData["Mining_Details"]["created_at"],
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        // Text(
                        //   _walletViewModel.differenceInHours.toString(),
                        //   style: TextStyle(color: Colors.white),
                        // ),
                      ],
                    );
                  }
                }),
                DailyRewardsContainer(),
                InkWell(
                  onTap: () {
                    Get.to(Attendance());
                  },
                  child: shareInviteCintainer(context, "Daily Attendance",
                      "Claim your daily Attendance"),
                ),
                Obx(() {
                  final refcode = _walletViewModel.refcode.value;

                  final username = _walletViewModel.userName.value;

                  return InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      Get.to(ShareRefferal(
                        refcode: refcode,
                        username: username,
                      ));
                    },
                    child: shareInviteCintainer(context, "Start Inviting",
                        "Invite your friends & earn 10 BRC"),
                  );
                }),
                ListTile(
                  title: Text(
                    "Crypto News",
                    style: TextStyle(color: AppColor.whiteColor),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Get.to(NewsFull());
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(color: AppColor.whiteColor),
                    ),
                  ),
                ),
                Obx(() {
                  switch (newsController.rxRequestStatus.value) {
                    case Status.LOADING:
                      return loading(Get.width, Get.height * 0.2);

                    case Status.ERROR:
                      if (newsController.error.value == "No internet") {
                        return InterNetExceptionWidget(onPress: () {
                          newsController.refreshallNewsListApi();
                        });
                      } else {
                        return GeneralExceptionWidget(onPress: () {
                          newsController.refreshallNewsListApi();
                        });
                      }
                    case Status.COMPLETED:
                      return ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          String title = newsController
                                  .allNewsList.value.userData![index].title ??
                              "";
                          String date = newsController.allNewsList.value
                                  .userData![index].createdAt ??
                              "";
                          String image = newsController
                                  .allNewsList.value.userData![index].image ??
                              "";
                          String desc = newsController.allNewsList.value
                                  .userData![index].description ??
                              "";
                          String url = newsController
                                  .allNewsList.value.userData![index].link ??
                              "";
                          return InkWell(
                              onTap: () {
                                Get.to(NewsDetailPageNew(
                                    image: image,
                                    title: title,
                                    date: date,
                                    para: desc,
                                    url: url));
                              },
                              child:
                                  newsContainer(context, image, title, date));
                        },
                      );
                  }
                }),
                ListTile(
                  title: Text(
                    "BRC Update",
                    style: TextStyle(color: AppColor.whiteColor),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Get.to(BRCUpdateFullPage());
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(color: AppColor.whiteColor),
                    ),
                  ),
                ),
                Obx(() {
                  switch (brcUpdateController.rxRequestStatus.value) {
                    case Status.LOADING:
                      return loading(Get.width, Get.height * 0.2);

                    case Status.ERROR:
                      if (brcUpdateController.error.value == "No internet") {
                        return InterNetExceptionWidget(onPress: () {
                          brcUpdateController.refreshallBRCListApi();
                        });
                      } else {
                        return GeneralExceptionWidget(onPress: () {
                          brcUpdateController.refreshallBRCListApi();
                        });
                      }
                    case Status.COMPLETED:
                      return ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          String title = brcUpdateController
                                  .allBRCList.value.userData![index].title ??
                              "";
                          String date = brcUpdateController
                                  .allBRCList.value.userData![index].date ??
                              "";
                          String image = brcUpdateController
                                  .allBRCList.value.userData![index].image ??
                              "";
                          String desc = brcUpdateController.allBRCList.value
                                  .userData![index].paragraph ??
                              "";
                          // String url = brcUpdateController
                          //         .allBRCList .value.userData![index]. ??
                          "";
                          return InkWell(
                              onTap: () {
                                Get.to(BRCDetailPageNew(
                                  image: image,
                                  title: title,
                                  date: date,
                                  para: desc,
                                ));
                              },
                              child:
                                  newsContainer(context, image, title, date));
                        },
                      );
                  }
                }),
                miningRateContainer(context),
                SizedBox(
                  height: 50,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

Widget appbarIcon(text, icon) {
  return Column(
    children: [
      Container(
        height: 60,
        width: 60,
        child: Center(
          child: Image(
            image: AssetImage(icon),
            height: 30,
          ),
        ),
        decoration: BoxDecoration(
            color: Color(0xffFBFBFB).withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      Text(
        text,
        style: TextStyle(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 15),
      )
    ],
  );
}
