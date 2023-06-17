import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    Key? key,
    required this.func,
  }) : super(key: key);
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/nointernet2.png"),
                height: Get.height * 0.25,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Text(
                'Ooops!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              SizedBox(
                width: Get.width * 0.7,
                child: const Text(
                    'it seems there is something wrong with your internet connection. Please connect to the internet and start Blockrium Again.'),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  func();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
