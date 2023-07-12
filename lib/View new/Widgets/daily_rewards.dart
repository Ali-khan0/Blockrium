import 'package:Blockrium/View%20new/Widgets/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/AppIcons/appicons.dart';
import '../../res/Colorsnew/appcolors.dart';
import '../../view_models/controller/Random_rewards_view_model/random_rewards_viewmodel.dart';

class DailyRewardsContainer extends StatefulWidget {
  @override
  _DailyRewardsContainerState createState() => _DailyRewardsContainerState();
}

class _DailyRewardsContainerState extends State<DailyRewardsContainer> {
  final RandomRewardsController randomRewardsController =
      RandomRewardsController();

  @override
  void initState() {
    super.initState();
    randomRewardsController.getRewardsStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var index = int.parse(randomRewardsController.rewardsStatus.value);
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            width: MediaQuery.of(context).size.width,
            height: 230,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/rewardsbg.gif"), fit: BoxFit.cover),
              border: Border.all(color: Colors.white38),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            width: MediaQuery.of(context).size.width,
            height: 230,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.purpleColor.withOpacity(0.3),
                  AppColor.pinkColor.withOpacity(0.3),
                ],
              ),
              border: Border.all(color: Colors.white38),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Daily Rewards",
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                              colors: [
                                AppColor.redColor,
                                AppColor.pinkColor,
                                AppColor.purpleColor,
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "${index} /3 Rewards",
                              style: TextStyle(color: AppColor.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (index == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      rewardsUnLocked(
                        context,
                        randomRewardsController.randomRewardsAdd,
                      ),
                      rewardsLocked(context, "Claim first to unlock"),
                      rewardsLocked(context, "Claim second to unlock"),
                    ],
                  )
                else if (index == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      rewardsClaim(context),
                      rewardsUnLocked(
                        context,
                        randomRewardsController.randomRewardsAdd,
                      ),
                      rewardsLocked(context, "Claim second to unlock"),
                    ],
                  )
                else if (index == 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      rewardsClaim(context),
                      rewardsClaim(context),
                      rewardsUnLocked(
                        context,
                        randomRewardsController.randomRewardsAdd,
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      rewardsClaim(context),
                      rewardsClaim(context),
                      rewardsClaim(context),
                    ],
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

Widget rewardsClaim(context) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.whiteColor.withOpacity(0.25),
              AppColor.whiteColor.withOpacity(0.1)
            ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    height: 150,
    width: MediaQuery.of(context).size.width * 0.28,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(
          image: AssetImage(AppIcons.brc),
          width: MediaQuery.of(context).size.width * 0.15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Text(
            "Added to wallet",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.whiteColor,
            ),
          ),
        ),
        rewardClaimedButton("Collected", 90.0, 30.0)
      ],
    ),
  );
}

Widget rewardsLocked(context, text) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.purpleColor.withOpacity(0.4),
              AppColor.pinkColor.withOpacity(0.4)
            ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    height: 150,
    width: MediaQuery.of(context).size.width * 0.28,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(
          image: AssetImage(AppIcons.lock),
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.whiteColor,
            ),
          ),
        ),
        // rewardClaimedButton("Collected", 90.0, 30.0)
      ],
    ),
  );
}

Widget rewardsUnLocked(context, func) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.purpleColor.withOpacity(0.4),
              AppColor.pinkColor.withOpacity(0.4)
            ]),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    height: 150,
    width: MediaQuery.of(context).size.width * 0.28,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(
          image: AssetImage(AppIcons.gift),
          width: MediaQuery.of(context).size.width * 0.13,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Text(
            "BRC Coins",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.whiteColor,
            ),
          ),
        ),
        InkWell(
            onTap: () {
              func();
            },
            child: roundButton("Collect", 90.0, 30.0))
      ],
    ),
  );
}
