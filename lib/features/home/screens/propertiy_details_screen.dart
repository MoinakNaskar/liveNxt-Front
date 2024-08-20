// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:livenxt_front/common/widgets/single_property.dart';
import 'package:livenxt_front/models/property.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final Property property;
  const PropertyDetailsScreen({
    super.key,
    required this.property,
  });

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
              Color.fromARGB(255, 82, 5, 96),
              Colors.black,
            ]))),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text('Upload Listing')),
              ],
            ),
          ),
        ),
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 82, 5, 96),
              Colors.black,
            ])),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      width: double.infinity,
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SingleProduct(images: widget.property.images)
                              ],
                            ),
                          ),
                        ],
                      )))
            ])));
  }
}
