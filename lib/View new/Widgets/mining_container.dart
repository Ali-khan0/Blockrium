import 'package:Blockrium/View%20new/Widgets/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';

import '../../res/Colorsnew/appcolors.dart';
import '../../view_models/controller/Wallet_view_model/wallet_view_model.dart';

Widget miningContainer(context, calculate, calculatePercentage, modelData) {
  final WalletViewModel _walletViewModel = WalletViewModel();

  return Container(
    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
    width: MediaQuery.of(context).size.width,
    height: 150,
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
                "Mining will end after",
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      // color: AppColor.redColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SlideCountdown(
                      textStyle: TextStyle(color: Colors.white),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(colors: [
                            AppColor.redColor,
                            AppColor.pinkColor,
                            AppColor.purpleColor
                          ])),
                      onChanged: (value) {},
                      duration: Duration(
                          hours:
                              //  5,
                              calculate,
                          minutes: 0,
                          seconds: 0),
                    ),
                    // SlideCountdown(
                    //   textStyle: TextStyle(color: Colors.white),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       gradient: LinearGradient(colors: [
                    //         AppColor.redColor,
                    //         AppColor.pinkColor,
                    //         AppColor.purpleColor
                    //       ])),
                    //   onChanged: (value) {},
                    //   duration: Duration(
                    //     hours: 5,
                    //     minutes: 0,
                    //   ),
                    // ),
                  ),
                ),
              )
            ],
          ),
        ),
        // Text(
        //   calculatePercentage.toString(),                                               
        //   style: TextStyle(color: Colors.white),
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: WaveLinearProgressIndicator(
            value:
                modelData.differenceInHours >= 24 ? 0.0 : calculatePercentage,
            labelDecoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColor.redColor,
                  AppColor.pinkColor,
                  AppColor.purpleColor
                ]),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            waveBackgroundColor: AppColor.pinkColor,
            enableBounceAnimation: true,
            waveColor: AppColor.purpleColor,
            backgroundColor: Colors.grey[150],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: InkWell(
            onTap: () {
              modelData.differenceInHours >= 24
                  ? _walletViewModel.newmining()
                  :
                  // initializeInterstitialAdsMining();
                  Get.snackbar(
                      "Mining Already Initialized", "Please wait for 24 hours");
            },
            child:
                //  roundButton(
                //     () {
                //   if (calculate >= 24) {
                //     return roundButton("Start", 70.0, 35.0);
                //   } else if (calculate < 0) {
                //     return roundButton("Start", 70.0, 35.0);
                //   } else {
                //     return initilizedMining("Initialized", 80.0, 35.0);
                //   }
                // }(),
                modelData.differenceInHours >= 24
                    ? roundButton("Start", 70.0, 35.0)
                    : initilizedMining("Initialized", 80.0, 35.0),
            // 70.0,
            // 35.0)),
          ),
        )
      ],
    ),
  );
}

Widget miningContainerNull(context) {
  final WalletViewModel _walletViewModel = WalletViewModel();

  return Container(
    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
    width: MediaQuery.of(context).size.width,
    height: 150,
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
                "Mining will end after",
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      // color: AppColor.redColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SlideCountdown(
                      textStyle: TextStyle(color: Colors.white),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(colors: [
                            AppColor.redColor,
                            AppColor.pinkColor,
                            AppColor.purpleColor
                          ])),
                      onChanged: (value) {},
                      duration: Duration(
                        hours: 0,
                        // calculate,
                        minutes: 0,
                      ),
                    ),
                    // SlideCountdown(
                    //   textStyle: TextStyle(color: Colors.white),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       gradient: LinearGradient(colors: [
                    //         AppColor.redColor,
                    //         AppColor.pinkColor,
                    //         AppColor.purpleColor
                    //       ])),
                    //   onChanged: (value) {},
                    //   duration: Duration(
                    //     hours: 5,
                    //     minutes: 0,
                    //   ),
                    // ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: WaveLinearProgressIndicator(
            value: 0.0,
            labelDecoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColor.redColor,
                  AppColor.pinkColor,
                  AppColor.purpleColor
                ]),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            waveBackgroundColor: AppColor.pinkColor,
            enableBounceAnimation: true,
            waveColor: AppColor.purpleColor,
            backgroundColor: Colors.grey[150],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: InkWell(
              onDoubleTap: () {
                _walletViewModel.newmining();
              },
              child: roundButton("loading..", 70.0, 35.0)),
        )
      ],
    ),
  );
}
