import 'package:Blockrium/View%20new/Games/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../../Ads/Unity/unityads.dart';
import '../../data/response/status.dart';
import '../../res/Colorsnew/appcolors.dart';
import '../../res/colors/style.dart';
import '../../res/components/genre_exception.dart';
import '../../res/components/no_internet_widget.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/games_view_model/all_games_view_model.dart';
import '../../widget/glowingbutton.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  final GamesController gamesController = GamesController();

  @override
  void initState() {
    super.initState();
    gamesController.gameListApi();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await UnityAdManater.loadUnityAdINT();
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<GamesController>(
        init: GamesController(),
        builder: (gamesController2) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg1.png"), fit: BoxFit.fill)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: GameAppBar(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      UnityBannerAd(
                        placementId: 'Banner_Android',
                        onLoad: (placementId) =>
                            print('Banner loaded: $placementId'),
                        onClick: (placementId) =>
                            print('Banner clicked: $placementId'),
                        onFailed: (placementId, error, message) => print(
                            'Banner Ad $placementId failed: $error $message'),
                      ),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(
                      //       10.0), // Set the desired border radius value
                      //   child: Image.asset("assets/images/banner4.png"),
                      // ),
                      // gamesCategoriesBar(),
                      Obx(() {
                        switch (gamesController.rxRequestStatus.value) {
                          case Status.LOADING:
                            return loading(w, h * 0.6);

                          case Status.ERROR:
                            if (gamesController.error.value == "No internet") {
                              return InterNetExceptionWidget(onPress: () {
                                gamesController.refreshGamesListApi();
                              });
                            } else {
                              return GeneralExceptionWidget(onPress: () {
                                gamesController.refreshGamesListApi();
                              });
                            }
                          case Status.COMPLETED:
                            var bubbleShooterGames = gamesController
                                .allGamesList.value.allGames
                                ?.where((game) =>
                                    game.gamecategory ==
                                    gamesController2.selected.value.toString())
                                .toList();

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 3,
                                        mainAxisExtent: 200),
                                itemCount: bubbleShooterGames!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var game = bubbleShooterGames[index];

                                  return Container(
                                    height: Get.height * 0.3,
                                    width: Get.width * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        // color: Colors.white
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.white.withOpacity(0.07),
                                            AppColor.pinkColor
                                                .withOpacity(0.07),
                                            AppColor.purpleColor
                                                .withOpacity(0.07),
                                            Colors.white.withOpacity(0.07),
                                          ],
                                        )),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: Get.height * 0.15,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: Image.network(
                                                  game.logo.toString()),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0, right: 4.0),
                                            child: Text(
                                              game.gamename.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(GamePlay(
                                                    url: game.url.toString()));
                                                UnityAdManater.showIntAd();
                                              },
                                              child: GlowingButton(
                                                text: "play".tr,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                        }
                      }),
                    ],
                  ),
                )),
          );
        });
  }
}

class GameAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _GameAppBarState createState() => _GameAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(Get.height * 0.15);
}

class _GameAppBarState extends State<GameAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35,
        ),
        Container(
          height: 120,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/banner56.png"))),
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      // Material(
                      //   elevation: 5,
                      //   child: Image.asset(
                      //     "assets/images/banner55.png",
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "G-CLUB",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  _animation.value,
                                ),
                                child: child,
                              );
                            },
                            child: Container(
                              height: Get.height * 0.1,
                              width: Get.width * 0.2,
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                image: DecorationImage(
                                  image: AssetImage("assets/astra.png"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: gamesCategoriesBar(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget gamesCategoriesBar() {
  return GetBuilder<GamesController>(
    init: GamesController(),
    builder: (gamesController) {
      return Container(
        height: Get.height * 0.06,
        // color: Color(0xFFC427C4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: gamesController.category.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // gamesController
                      //     .updateSelected(gamesController.category[index]);

                      gamesController.updateSelected(
                          gamesController.category[index].toString());
                    },
                    child: Obx(() {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0),
                          child: gamesController.selected.value ==
                                  gamesController.category[index]
                              ? GlowingButton2(
                                  text: gamesController.category[index],
                                )
                              : Text(
                                  gamesController.category[index],
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
