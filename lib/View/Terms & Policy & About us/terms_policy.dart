import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../View new/Widgets/custom_appbar.dart';

class PolicyTerms extends StatelessWidget {
  const PolicyTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: SubScreenApbarBlack(
          title: "Terms & Policy",
        ),
        body: SfPdfViewer.asset(
          'assets/privacy.pdf',
        ),
      ),
    );
  }
}

// class Heading extends StatelessWidget {
//   const Heading({
//     Key? key,
//     required this.heading,
//   }) : super(key: key);
//   final String heading;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         heading,
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//       ),
//     );
//   }
// }

// class Normaltitle extends StatelessWidget {
//   const Normaltitle({
//     Key? key,
//     required this.text,
//   }) : super(key: key);
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 16),
//       ),
//     );
//   }
// }

// class PDFViewerPage extends StatelessWidget {
//   final String asset;

//   PDFViewerPage({required this.asset});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: 
//     );
//   }
// }
