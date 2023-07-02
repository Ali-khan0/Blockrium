// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:otpless_flutter/otpless_flutter.dart';
// void main() {
// runApp(const OTPless());
// }
// ClassOTPlessextendsStatefulWidget {
// const OTPless({Key? key}) :super(key: key);
// @override
// State<OTPless> createState() => _OTPlessState();
// }
// class_OTPlessStateextendsState<OTPless> {
// String _userToken = 'Unknown';
// final _otplessFlutterPlugin = Otpless();
// final TextEditingController urlTextContoller = TextEditingController();
// @override 
// void initState() {
// super.initState();
// initPlatformState();
// }
// // ** Function that is called when page is loaded// ** We can check the auth state in this
// // function
// Future<void> initPlatformState()async {
// _otplessFlutterPlugin.authStream.listen((token) {
// // TODO: Handle user token like making api calls
// setState(() {
// _userToken = token ?? "Unknown";
// });
// });
// }
// @override 
// void dispose() {
// // Clean up the controller when the widget is disposed.
// urlTextContoller.dispose();
// super.dispose();}
// // ** Function to initiate the login processvoid initiateWhatsappLogin(String intentUrl)as
// async {
// var result =
// await _otplessFlutterPlugin.loginUsingWhatsapp(intentUrl: intentUrl);
// switch (result['code']) {
// case "581":
// debugdebugPrint(result['message']);
// //TODO: handle whatsapp not foundbreak;
// default:
// }
// }
// @override
// Widget build(BuildContext context) {
// return MaterialApp(
// home: Scaffold(
// appBar: AppBar(
// title:const Text('OTPless Flutter Plugin example app'),
// ),
// body: SafeArea(
// child: Padding(
// padding:const EdgeInsets.all(8.0),
// child: Center(
// child: Column(
// children: [
// CupertinoButton.filled(
// child: Text("Login With Whatsapp(deeplink)"),
// onPressed: () {
// initiateWhatsappLogin(
// "https://maticlegend.authlink.me?redirectUri=otpless://maticlegend");
// }),
// Text(_userToken),
// SizedBox(height: 100),
// TextField(
// controller: urlTextContoller,
// textAlign: TextAlign.left,
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// hintText: "enterYourUrlHere"),
// ),
// SizedBox(height: 10),
// CupertinoButton.filled(
// child: Text("Login With Whatsapp(web)"),
// onPressed: () {
// initiateWhatsappLogin(urlTextContoller.text);
// }),
// Text(_userToken)
// ],
// ),
// ),
// ),),
// ),
// );
// }
// }
