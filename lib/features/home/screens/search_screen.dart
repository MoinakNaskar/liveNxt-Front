// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import 'package:livenxt_front/constants/utils.dart';
import 'package:livenxt_front/features/home/screens/search_landing_screen.dart';

class SearchScreen extends StatefulWidget {
  final int? index;
  final String? textValue;
  const SearchScreen({
    Key? key,
    this.index,
    this.textValue,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? address;
  double? latitude;
  double? longitude;
  TextEditingController searchController = TextEditingController();
  Future<void> _getCurrentCoordinates() async {
    Position position = await getUserCurrentLocation();
    String gotAddress = await getAddress(
        latitude: position.latitude, longitude: position.longitude);
    setState(() {
      address = gotAddress;
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  Future<void> _getSearchCoordinates(String inputAddress) async {
    final coordinates = await getCoordinates(inputAddress);
    setState(() {
      address = inputAddress;
      latitude = coordinates['lat'];
      longitude = coordinates['lng'];
    });
  }

  List<dynamic> _placelist = [];
  @override
  void initState() {
    super.initState();
  }

  void navigateToSearchView() {
    if (widget.index != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SearchLandingScreen(
                latitude: latitude!,
                longitude: longitude!,
                address: address!,
                index: widget.index!,
              )));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SearchLandingScreen(
                latitude: latitude!,
                longitude: longitude!,
                address: address!,
                index: 0,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
              Expanded(
                child: Container(
                    height: 48,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(top: 10),
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1)),
                            hintText: 'Search LiveNxt.com',
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                        onChanged: (value) async {
                          final places =
                              await getLocationSuggestion('hhshs', value);
                          setState(() {
                            _placelist = places;
                          });
                        },
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await _getCurrentCoordinates();
              navigateToSearchView();
            },
            child: const Material(
                elevation: 6,
                child: ListTile(
                  leading: Icon(Icons.my_location),
                  title: Text('Use My Current Location'),
                )),
          ),
          const SizedBox(
            height: 19,
          ),
          Container(
            height: 300,
            child: ListView.builder(
                itemCount: _placelist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await _getSearchCoordinates(
                          _placelist[index]['description']);
                      navigateToSearchView();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 3,
                        child: ListTile(
                          title: Text(_placelist[index]['description']),
                          leading: const Icon(Icons.location_on),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
