// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:bitlabs/bitlabs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// class BitlabsSurvey extends StatefulWidget {
//   final String title;

//   const BitlabsSurvey({Key? key, required this.title}) : super(key: key);

//   @override
//   State<BitlabsSurvey> createState() => _BitlabsSurveyState();
// }

// class _BitlabsSurveyState extends State<BitlabsSurvey> {
//   ListView? surveyWidgets;

//   @override
//   void initState() {
//     super.initState();
//     BitLabs.instance.init('aff30e31-c2ec-4896-a297-f99a3b3f794d', '141');

//     BitLabs.instance.setOnReward(
//         (reward) => {log('[Example] Reward for this session: $reward')});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               width: 250,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   ElevatedButton(
//                     onPressed: BitLabs.instance.requestTrackingAuthorization,
//                     child: const Text('Authorize Tracking(iOS)'),
//                   ),
//                   ElevatedButton(
//                     onPressed: checkForSurveys,
//                     child: const Text('Check for Surveys'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => BitLabs.instance.launchOfferWall(context),
//                     child: const Text('Open OfferWall'),
//                   ),
//                   ElevatedButton(
//                     onPressed: getSurveys,
//                     child: const Text('Get Surveys'),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 80, child: surveyWidgets ?? const SizedBox()),
//           ],
//         ),
//       ),
//     );
//   }

//   void checkForSurveys() {
//     BitLabs.instance.checkSurveys(
//         (hasSurveys) => log('[Example] Checking Surveys -> '
//             '${hasSurveys ? 'Surveys Available!' : 'No Surveys!'}'),
//         (exception) => log('[Example] CheckSurveys $exception'));
//   }

//   void getSurveys() {
//     BitLabs.instance.getSurveys(
//         (surveys) => setState(() => surveyWidgets = ListView(
//               scrollDirection: Axis.horizontal,
//               children: [...BitLabs.instance.getSurveyWidgets(surveys)],
//             )),
//         (exception) => log('[Example] GetSurveys $exception'));
//   }
// }

// Future<void> checkSurveyCompletion(String email) async {
//   final apiKey = 'aff30e31-c2ec-4896-a297-f99a3b3f794d';
//   final apiUrl = 'https://api.bitlabs.ai/surveys';
//   final response =
//       await http.get(Uri.parse('$apiUrl?email=$email&api_key=$apiKey'));
//   final surveyData = jsonDecode(response.body);

//   if (surveyData['completed']) {
//     // User has completed the survey, run your desired function here
//   } else {
//     // User has not completed the survey
//   }
// }
