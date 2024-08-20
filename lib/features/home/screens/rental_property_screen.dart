// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:livenxt_front/features/home/screens/search_screen.dart';
import 'package:numeral_system/numeral_system.dart';

import '../../../common/widgets/loader.dart';
import '../../../common/widgets/single_property.dart';
import '../../../models/property.dart';
import '../../auth/services/auth_service.dart';

class RentalPropertyScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String address;
  const RentalPropertyScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.address,
  }) : super(key: key);

  @override
  State<RentalPropertyScreen> createState() => _RentalPropertyScreenstate();
}

class _RentalPropertyScreenstate extends State<RentalPropertyScreen> {
  AuthService _authService = AuthService();
  List<Property>? properties;
  @override
  void initState() {
    super.initState();
    getRentProperties();
  }

  void getRentProperties() async {
    final gotProperties = await _authService.fetchRentProperties(context,
        latitude: widget.latitude, longitude: widget.longitude);
    setState(() {
      properties = gotProperties;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              child: Material(
                elevation: 4,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              index: 1,
                            )));
                  },
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  titleAlignment: ListTileTitleAlignment.titleHeight,
                  trailing: Icon(
                    Icons.search,
                    size: 15,
                  ),
                  leading: Icon(
                    Icons.location_on,
                    size: 15,
                  ),
                  title: Center(
                    child: Text(
                      'Near- ${widget.address}\n   ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
            properties == null
                ? Loader()
                : Expanded(
                    child: ListView.builder(
                        itemCount: properties!.length,
                        itemBuilder: (context, index) {
                          final property = properties![index];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60)),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      SizedBox(
                                          height: 500,
                                          child: SingleProduct(
                                              images: property.images)),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        width: double.infinity,
                                        height: 250,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                              Colors.black,
                                              Color.fromRGBO(0, 0, 0, 0.836),
                                              Colors.transparent
                                            ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 130,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    property.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25,
                                                        color: Colors.white),
                                                  ),
                                                  NumeralSystem(
                                                      numberSystem:
                                                          NumberSystem.indian,
                                                      digit: property.price,
                                                      digitAfterDecimal:
                                                          DigitAfterDecimal.two,
                                                      textStyle: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                property.description,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                ),
                                                title: Text(
                                                  property.locality,
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              187,
                                                              255,
                                                              255,
                                                              255),
                                                      fontSize: 13),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
