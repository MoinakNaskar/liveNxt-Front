// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SingleProduct extends StatelessWidget {
  final List<String> images;
  const SingleProduct({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images.map((i) {
          int idx = images.indexOf(i);
          return Builder(
              builder: (BuildContext context) => Stack(
                    children: [
                      Image.network(
                        i,
                        height: 500,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        filterQuality: FilterQuality.high,
                      ),
                      Positioned(
                        right: 30,
                        bottom: 10,
                        child: Text(
                          '${idx + 1}/${images.length}',
                          style: TextStyle(
                              color: Color.fromARGB(255, 185, 183, 183),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ));
        }).toList(),
        options: CarouselOptions(viewportFraction: 1, height: 500));
  }
}
