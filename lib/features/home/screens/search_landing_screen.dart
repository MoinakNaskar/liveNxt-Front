// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:livenxt_front/features/home/screens/buy_property_screen.dart';
import 'package:livenxt_front/features/home/screens/commercial_property_screen.dart';
import 'package:livenxt_front/features/home/screens/rental_property_screen.dart';

class SearchLandingScreen extends StatefulWidget {
  final double longitude;
  final double latitude;
  final String address;
  final int index;
  const SearchLandingScreen({
    Key? key,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.index,
  }) : super(key: key);

  @override
  State<SearchLandingScreen> createState() => _SearchLandingScreenState();
}

class _SearchLandingScreenState extends State<SearchLandingScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.latitude);
    print(widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.index,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
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
                  )
                ]),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.apartment),
                  text: 'Buy',
                ),
                Tab(
                  icon: Icon(Icons.house),
                  text: 'Rent',
                ),
                Tab(
                  icon: Icon(Icons.corporate_fare),
                  text: 'Commercial',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BuyPropertyScreen(
                latitude: widget.latitude,
                longitude: widget.longitude,
                address: widget.address),
            RentalPropertyScreen(
                latitude: widget.latitude,
                longitude: widget.longitude,
                address: widget.address),
            CommercialPropertyScreen(
                latitude: widget.latitude,
                longitude: widget.longitude,
                address: widget.address),
          ],
        ),
      ),
    );
  }
}
