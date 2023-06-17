import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../View new/Widgets/custom_appbar.dart';

class WhitePaper extends StatelessWidget {
  const WhitePaper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: SubScreenApbarBlack(
            title: "White paper",
          ),
          body: Center(
            child: Text(
              "Coming soon",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
          //  SfPdfViewer.asset(
          //   'assets/privacy.pdf',
          // ),
          ),
    );
  }
}
