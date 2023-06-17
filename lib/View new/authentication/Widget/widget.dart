import 'package:Blockrium/res/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget buildtextfield(controller, hint, icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " $hint",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xffA4A4A4),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(colors: [
                Color(0xffFFFFFF).withOpacity(0.2),
                Color(0xffFFFFFF).withOpacity(0.1),
              ])),
          child: TextFormField(
            validator: ((txt) {
              if (txt == null || txt.isEmpty) {
                return "Please Enter Some Text";
              } else {
                return null;
              }
            }),
            style: TextStyle(
              color: Colors.white,
            ),
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: Color(0xffA4A4A4),
                ),
                hintStyle: TextStyle(
                  color: Color(0xffA4A4A4),
                ),
                border: InputBorder.none,
                hintText: hint),
          ),
        ),
      ],
    ),
  );
}

Widget buildphonetextfield(controller, hint, icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " $hint",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xffA4A4A4),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(colors: [
                Color(0xffFFFFFF).withOpacity(0.2),
                Color(0xffFFFFFF).withOpacity(0.1),
              ])),
          child: TextFormField(
            validator: ((txt) {
              if (txt == null || txt.isEmpty) {
                return "Please Enter Phone Number";
              } else {
                return null;
              }
            }),
            style: TextStyle(
              color: Colors.white,
            ),
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Color(0xffA4A4A4),
                ),
                prefixIcon: Icon(
                  icon,
                  color: Color(0xffA4A4A4),
                ),
                border: InputBorder.none,
                hintText: hint),
          ),
        ),
      ],
    ),
  );
}

Widget buildrefferaltextfield(controller, hint, icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " $hint",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xffA4A4A4),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(colors: [
                Color(0xffFFFFFF).withOpacity(0.2),
                Color(0xffFFFFFF).withOpacity(0.1),
              ])),
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
            ),
            controller: controller,
            // keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Color(0xffA4A4A4),
                ),
                prefixIcon: Icon(
                  icon,
                  color: Color(0xffA4A4A4),
                ),
                border: InputBorder.none,
                // label: Text(hint),
                hintText: hint),
          ),
        ),
      ],
    ),
  );
}
