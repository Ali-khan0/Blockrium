import 'package:Blockrium/View%20new/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View new/Profile/profile.dart';
import '../new_changes.dart';
import '../res/AppIcons/appicons.dart';
import '../version.dart';
import '../view_models/controller/BottomNavBar_view_model.dart/bottom_view_model.dart';
import '../view_models/services/no_internet.dart';

import '../View new/Games/games.dart';
import 'Profile/profile.dart';
import 'Wallet/transfer.dart';
import 'Wallet/wallet.dart';
import 'account_suspend/accountsuspend.dart';
import 'maintenance/maintenance.dart';

class MyBottomNavbar extends StatefulWidget {
  MyBottomNavbar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavbar> createState() => _MyBottomNavbarState();
}

class _MyBottomNavbarState extends State<MyBottomNavbar> {
  final tabs = [HomePage(), GamesPage(), Wallet(), ProfilePageNew()];

  final BottomNavController bottomnavController = BottomNavController();

  @override
  void initState() {
    super.initState();
    bottomnavController.getversion().then((value) {
      if (bottomnavController.version != null &&
          // bottomnavController.version <= 10) {
          bottomnavController.version <= 14) {
        // 13
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VersionCheck(
                      versiondata: bottomnavController.versiondata.value,
                    )));
      }
    });

    bottomnavController.getSuspendData().then((value) {
      if (bottomnavController.isactive.value == "1") {
        // 1 for active
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AccountSuspend()));
      }
    });
  
 bottomnavController.  getMaintenaceData().then((value) {
      if (bottomnavController.ismaintenance == false) {
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MaintenancePage()));
      }
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
        init: BottomNavController(),
        builder: (bottomNavController) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/bg.png"))),
            child: Scaffold(
                body: Obx(() => tabs[bottomNavController.currentIndex.value]),
                bottomNavigationBar: Obx(
                  () => Container(
                    // height: 60,
                    color: Colors.black,
                    child: Row(
                      //children inside bottom appbar
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          // height: 60,
                          child: IconButton(
                            iconSize: 50,
                            icon: bottomNavController.currentIndex.value == 0
                                ? Image(
                                    image: AssetImage(AppIcons.dashbordfill),
                                    height: 35,
                                  )
                                : Image(
                                    image: AssetImage(AppIcons.dashboard),
                                    height: 35,
                                  ),
                            onPressed: () {
                              bottomNavController.updateIndex(0);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            iconSize: 55,
                            icon: bottomNavController.currentIndex.value == 1
                                ? Image(
                                    image: AssetImage(AppIcons.gamefill),
                                    height: 40,
                                  )
                                : Image(
                                    image: AssetImage(AppIcons.game),
                                    height: 40,
                                  ),
                            onPressed: () {
                              bottomNavController.updateIndex(1);
                              // setState(() {
                              //   _bottomNavIndex = 1;
                              // });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                            iconSize: 50,
                            icon: bottomNavController.currentIndex.value == 2
                                ? Image(
                                    image: AssetImage(AppIcons.walletfill),
                                    height: 35,
                                  )
                                : Image(
                                    image: AssetImage(AppIcons.wallet),
                                    height: 35,
                                  ),
                            onPressed: () {
                              bottomNavController.updateIndex(2);
                              // setState(() {
                              //   _bottomNavIndex = 2;
                              // });
                            },
                          ),
                        ),
                        IconButton(
                          iconSize: 50,
                          icon: bottomNavController.currentIndex.value == 3
                              ? Image(
                                  image: AssetImage(AppIcons.profilefill),
                                  height: 35,
                                )
                              : Image(
                                  image: AssetImage(AppIcons.profile),
                                  height: 35,
                                ),
                          onPressed: () {
                            bottomNavController.updateIndex(3);
                            // setState(() {
                            //   _bottomNavIndex = 3;
                            // });
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
