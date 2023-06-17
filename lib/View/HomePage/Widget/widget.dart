import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget maticUpdate(w, h, img, title, date) {
  return Padding(
    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.1,
              blurRadius: 8,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: w * 0.830,
      height: h * 0.3,
      child: Column(
        children: [
          Container(
            height: h * 0.2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(img), fit: BoxFit.cover),
                // color: Colors.pink,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
          Container(
            height: h * 0.1,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: ListTile(
              title: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(DateFormat('d-M-y').format(DateTime.parse(date))),
            ),
          ),
        ],
      ),
    ),
  );
}
