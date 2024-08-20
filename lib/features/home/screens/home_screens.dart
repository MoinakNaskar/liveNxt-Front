import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:livenxt_front/common/widgets/loader.dart';
import 'package:livenxt_front/constants/utils.dart';
import 'package:livenxt_front/features/auth/services/auth_service.dart';
import 'package:livenxt_front/features/home/screens/buy_property_screen.dart';
import 'package:livenxt_front/features/home/screens/commercial_property_screen.dart';

import 'package:livenxt_front/features/home/screens/rental_property_screen.dart';
import 'package:livenxt_front/features/home/screens/search_landing_screen.dart';
import 'package:livenxt_front/features/home/screens/search_screen.dart';
import 'package:livenxt_front/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/property.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _state = 1;
  List<Property>? properties;

  AuthService _authService = AuthService();
  List<String> featuresImages = [
    'assets/image.jpeg',
    'assets/image.jpeg',
    'assets/image.jpeg'
  ];

  List<String> features = [
    'Sobha',
    'Prestige',
    'Merlin',
    'Siddha',
    'Forum',
    'Rajwada'
  ];
  double? latitude;
  double? longitude;
  String? address;
  int? indexProperty = 0;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getCurrentAddress() async {
    Position position = await getUserCurrentLocation();
    String gotAddress = await getAddress(
        latitude: position.latitude, longitude: position.longitude);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      address = gotAddress;
    });
  }

  getSell() async {
    await getCurrentAddress();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchLandingScreen(
              latitude: latitude!,
              longitude: longitude!,
              address: address!,
              index: 0,
            )));
  }

  getRent() async {
    await getCurrentAddress();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchLandingScreen(
              latitude: latitude!,
              longitude: longitude!,
              address: address!,
              index: 1,
            )));
  }

  getCommercial() async {
    await getCurrentAddress();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchLandingScreen(
              latitude: latitude!,
              longitude: longitude!,
              address: address!,
              index: 2,
            )));
  }

  createLead(String propertyId) async {
    await _authService.createLead(context, propertyId);
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    final user = Provider.of<UserProvider>(context).user;
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SearchScreen()));
                          },
                          child: ListTile(
                            title: const Text('Search LiveNxt.com'),
                            leading: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        body: _state == 0
            ? Loader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: features.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 20),
                                    child: Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          const CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/image.jpeg",
                                            ),
                                            maxRadius: 30,
                                          ),
                                          Text(
                                            features[index],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        child: CarouselSlider(
                            items: featuresImages.map((i) {
                              return Builder(
                                  builder: (BuildContext context) =>
                                      Image.asset(
                                        i,
                                        fit: BoxFit.fitWidth,
                                        height: 0,
                                        width: double.infinity,
                                      ));
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 3,
                              height: 200,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 4),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 2),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton.extended(
                            heroTag: 'Buy',
                            hoverElevation: 20,
                            splashColor:
                                const Color.fromARGB(255, 208, 149, 218),
                            backgroundColor: Colors.white,
                            label: Text(
                              '    Buy        ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            onPressed: () {
                              getSell();
                            },
                            elevation: 5,
                          ),
                          FloatingActionButton.extended(
                            heroTag: 'Rent',
                            splashColor:
                                const Color.fromARGB(255, 208, 149, 218),
                            backgroundColor: Colors.white,
                            label: Text(
                              '   Rent      ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            onPressed: () {
                              getRent();
                            },
                            elevation: 5,
                          ),
                          FloatingActionButton.extended(
                            heroTag: 'Comercial',
                            splashColor:
                                const Color.fromARGB(255, 208, 149, 218),
                            backgroundColor: Colors.white,
                            label: Text(
                              'Commercial',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            onPressed: () {
                              getCommercial();
                            },
                            elevation: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Opacity(
                              opacity: 0.7,
                              child: Material(
                                elevation: 10,
                                child: Image.asset('assets/image.jpeg',
                                    fit: BoxFit.fitWidth),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Opacity(
                              opacity: 0.7,
                              child: FloatingActionButton.extended(
                                heroTag: 'buy2',
                                backgroundColor:
                                    Color.fromARGB(255, 196, 103, 212),
                                label: Text(
                                  'Find Buy',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  getSell();
                                },
                                elevation: 5,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Opacity(
                              opacity: 0.7,
                              child: Material(
                                elevation: 10,
                                child: Image.asset('assets/image.jpeg',
                                    fit: BoxFit.fitWidth),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Opacity(
                              opacity: 0.7,
                              child: FloatingActionButton.extended(
                                heroTag: 'Rent2',
                                backgroundColor:
                                    Color.fromARGB(255, 196, 103, 212),
                                label: Text(
                                  'Find Rent',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  getRent();
                                },
                                elevation: 5,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Opacity(
                              opacity: 0.7,
                              child: Material(
                                elevation: 10,
                                child: Image.asset('assets/image.jpeg',
                                    fit: BoxFit.fitWidth),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Opacity(
                              opacity: 0.7,
                              child: FloatingActionButton.extended(
                                heroTag: 'Commercial2',
                                backgroundColor:
                                    Color.fromARGB(255, 196, 103, 212),
                                label: Text(
                                  'Find Commercial',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  getCommercial();
                                },
                                elevation: 5,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
