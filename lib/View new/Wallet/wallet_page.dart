import 'package:Blockrium/view_models/controller/Wallet_view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/AppIcons/appicons.dart';
import '../../res/Colorsnew/appcolors.dart';
import '../../widget/comingsoon_dialog.dart';
import '../Homepage.dart';

class WalletPageNnew extends StatefulWidget {
  const WalletPageNnew({super.key});

  @override
  State<WalletPageNnew> createState() => _WalletPageNnewState();
}

class _WalletPageNnewState extends State<WalletPageNnew> {
  final WalletViewModel _walletViewModel = WalletViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showComingSoonDialog();
    });

    _walletViewModel.userWallet();
  }

  void showComingSoonDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ComingSoonDialog();
      },
    );
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
              // leading: Padding(
              //   padding: const EdgeInsets.only(left: 8.0, top: .0, bottom: 8.0),
              //   child: Obx(() {
              //     final profileImage = _walletViewModel.profileImg.value;
              //     return CircleAvatar(
              //       backgroundImage: NetworkImage(profileImage == ""
              //           ? "https://lh3.googleusercontent.com/pw/AJFCJaU0GU1whPNk7q4vw0eIfgsJP59K49IzweB9Vz2sz-Ph3fbgE5Yl1mrqNtfY3DXxUhSe3NFnciEkLUsVmCKfs3AatWQ-Mu7X5nXvFhDsZVF9dNtBSpRuU9Bjo_3VGffaNRS71rX8aKlsISZH2nW8hW9z=w225-h225-s-no"
              //           : profileImage),
              //       radius: 40,
              //     );
              //   }),
              // ),
              pinned: true,
              expandedHeight: 260,
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFDC93),
                        Color(0xFFFFCB7E),
                        Color(0xFFFFBE6C),
                        Color(0xFFFF978A),
                        Color(0xFFFF9488),
                        Color(0xFFF58D8B),
                        Color(0xFFF58A89),
                        Color(0xFFEE4E6A),
                      ],
                      stops: [
                        0.1551,
                        0.2711,
                        0.392,
                        0.6627,
                        0.7593,
                        0.8802,
                        0.9672,
                        1.0832
                      ],
                      transform: GradientRotation(356.43 * 3.14159 / 180),
                    ),
                  ),
                  child: FlexibleSpaceBar(
                      background: Container(
                    width: Get.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130,
                          width: Get.width,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Blockrium ( BRC )",
                              style: TextStyle(color: Colors.black),
                            ),
                            Image(
                              image: AssetImage(AppIcons.brc),
                              height: 25,
                            )
                          ],
                        ),
                        Obx(() => Text(
                              _walletViewModel.walletData.value.isEmpty
                                  ? "loading..."
                                  : _walletViewModel
                                      .walletData.value["wallet_balance"]
                                      .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Colors.black,
                              ),
                            )),
                        Container(
                          // height: 80,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.greenAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              appbarIcon2("Deposit", AppIcons.deposit),
                              appbarIcon2("withdraw", AppIcons.withdraw),
                              appbarIcon2("Transfer", AppIcons.transfer),
                              appbarIcon2("Stake", AppIcons.stake),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ListTile(
                  leading: Text(
                    "Crypto Activites",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      "No History available",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

Widget appbarIcon2(text, icon) {
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
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      Text(
        text,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      )
    ],
  );
}
