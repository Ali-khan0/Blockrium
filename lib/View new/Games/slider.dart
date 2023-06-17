import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSliderExample extends StatefulWidget {
  @override
  _CarouselSliderExampleState createState() => _CarouselSliderExampleState();
}

class _CarouselSliderExampleState extends State<CarouselSliderExample> {
  List<String> imageUrls = [
    "https://firebasestorage.googleapis.com/v0/b/foodlover-2bb53.appspot.com/o/WhatsApp%20Image%202023-06-02%20at%2017.02.09sfsdxcve.jpg?alt=media&token=bac9b224-2e6b-4197-84e1-08b9db5c1db1"
  ,"https://firebasestorage.googleapis.com/v0/b/foodlover-2bb53.appspot.com/o/WhatsApp%20Image%202023-06-02%20at%2017.09.36ascv%20asdfasd.jpg?alt=media&token=e94bcfdf-d64d-4052-93e0-149467ab76e4"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(10.0), // Set desired border radius here
        color: Colors
            .transparent, // You can also set the background color of the container
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 100.0,
          autoPlay: true,
          viewportFraction: 1,
        ),
        items: imageUrls.map((String imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10.0), // Set the same border radius as the parent container
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
