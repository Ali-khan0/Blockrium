import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';
import '../../res/components/genre_exception.dart';
import '../../res/components/no_internet_widget.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/brc_update_viewModel/brc_update_viewmodel.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/news_widget.dart';
import 'brc_update_detail.dart';

class BRCUpdateFullPage extends StatefulWidget {
  const BRCUpdateFullPage({super.key});

  @override
  State<BRCUpdateFullPage> createState() => _BRCUpdateFullPageState();
}

class _BRCUpdateFullPageState extends State<BRCUpdateFullPage> {
  final BrcUpdateController brcUpdateController = BrcUpdateController();

  @override
  void initState() {
    super.initState();
    brcUpdateController.allBRCListApi();
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
            title: "BRC Update",
          ),
          body: Obx(() {
            switch (brcUpdateController.rxRequestStatus.value) {
              case Status.LOADING:
                return loading(Get.width, Get.height * 0.6);

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
                    String desc = brcUpdateController
                            .allBRCList.value.userData![index].paragraph ??
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
                        child: newsContainer(context, image, title, date));
                  },
                );
            }
          }),
        ));
  }
}
