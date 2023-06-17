import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/glowingbutton.dart';
import '../Terms & Policy & About us/terms_policy.dart';

class AccountSuspend extends StatefulWidget {
  const AccountSuspend({
    Key? key,
    // required this.versiondata,
  }) : super(key: key);

  @override
  State<AccountSuspend> createState() => _AccountSuspendState();
}

String email = "support@maticlegend.com";

class _AccountSuspendState extends State<AccountSuspend> {
  // final  versiondata;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image(
              image: AssetImage("assets/blockrium.png"),
            ),
          ),
          title: Text(
            "Blockrium",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(
                //   height: 100,
                // ),
                Image(
                  image: AssetImage("assets/suspend.png"),
                  height: Get.height * 0.2,
                ),
                Text(
                  """We regret to inform you that your account has been suspended due to a violation of our app's policies. We take our policies seriously to ensure a safe and fair experience for all of our users.
        
        If you believe that this suspension was made in error, please contact us to discuss the matter further. However, if the violation was intentional or due to negligence, we ask that you review our policies and take appropriate steps to rectify the situation.
          
        We appreciate your understanding and cooperation in this matter. Thank you for using our app.""",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: Get.height * 0.09,
                ),
                Column(
                  children: [
                    Text(
                      "Email us to recover your account",
                      style: TextStyle(color: Colors.white),
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       launch("mailto:$email");
                    //     },
                    //     child: Text("Recover Account")),
                    GestureDetector(
                      onTap: () {
                        launch("mailto:$email");
                      },
                      child: GlowingButtonAuth(
                        text: "Recover Account",
                        loading: false,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PolicyTerms()),
                          );
                        },
                        child: Text(
                          "Blockrium Privacy & Policy",
                          style: TextStyle(color: Colors.blue),
                        )),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: 'support@maticlegend.com'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Email copied')),
                        );
                      },
                      child: Text(
                        'support@maticlegend.com',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
