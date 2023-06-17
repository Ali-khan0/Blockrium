import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';
import '../../res/components/genre_exception.dart';
import '../../res/components/no_internet_widget.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/cryptoNewViewModel/crypto_news_model.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/news_widget.dart';
import 'news_details.dart';

class NewsFull extends StatefulWidget {
  const NewsFull({super.key});

  @override
  State<NewsFull> createState() => _NewsFullState();
}

class _NewsFullState extends State<NewsFull> {
  final NewsController newsController = NewsController();
  @override
  void initState() {
    super.initState();
    newsController.allNewsListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: SubScreenApbarBlack(
          title: "Crypto News",
        ),
        body: Obx(() {
          switch (newsController.rxRequestStatus.value) {
            case Status.LOADING:
              return loading(Get.width, Get.height * 0.6);

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
                  String title =
                      newsController.allNewsList.value.userData![index].title ??
                          "";
                  String date = newsController
                          .allNewsList.value.userData![index].createdAt ??
                      "";
                  String image =
                      newsController.allNewsList.value.userData![index].image ??
                          "";
                  String desc = newsController
                          .allNewsList.value.userData![index].description ??
                      "";
                  String url =
                      newsController.allNewsList.value.userData![index].link ??
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
                      child: newsContainer(context, image, title, date));
                },
              );
          }
        }),
      ),
    );
  }
}
