import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:livenxt_front/common/widgets/common_textfield.dart';
import 'package:livenxt_front/common/widgets/custom_buttom.dart';
import 'package:livenxt_front/common/widgets/loader.dart';
import 'package:livenxt_front/features/vendor/bloc/vendor_bloc.dart';

import '../../../constants/utils.dart';

class Listing extends StatefulWidget {
  static const String routeName = '/lising';
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  // VendorServices _vendorServices = VendorServices();

  double? longitude;
  double? latitude;
  getLocation() async {
    Position position = await getUserCurrentLocation();
    longitude = position.longitude;
    latitude = position.latitude;
  }

  createProperty() {
    context.read<VendorBloc>().add(ListingButtonClicked(
        address: address_1_Controller.text,
        context: context,
        name: propertyNameController.text,
        description: descriptionController.text,
        locality: LocalityController.text,
        listingType: listingType!,
        lookingFor: lookingFor!,
        images: images,
        propertyType: propertyType!,
        price: int.parse(priceController.text),
        buildUpArea: int.parse(buildUpAreaController.text),
        carpetArea: int.parse(carpetAreaController.text),
        latitude: latitude,
        longitude: longitude,
        BHK: BHK,
        bathroom: bathroom,
        balcony: balcony,
        coverParking: coverParking,
        openParking: openParking,
        furnishedType: furnishedType,
        flatFurnishing: clickedFurnishing,
        societyAmenities: clickedAminities,
        transactionType: sellTransactionType,
        constructionType: sellConstructionType,
        reraId: reraIDController.text.isEmpty
            ? 0
            : int.parse(reraIDController.text),
        propertyAge: propertyAgeController.text.isEmpty
            ? 0.0
            : double.parse(propertyAgeController.text)));
  }

  final PageController _ProgressController = PageController(initialPage: 0);
  final TextEditingController propertyAgeController = TextEditingController();
  final TextEditingController buildUpAreaController = TextEditingController();
  final TextEditingController carpetAreaController = TextEditingController();
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController address_1_Controller = TextEditingController();
  final TextEditingController LocalityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController reraIDController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final _firstPageKey = GlobalKey<FormState>();
  final _secondPageKey = GlobalKey<FormState>();
  List<dynamic> locationSuggetions = [];
  String? listingType;
  String? lookingFor;
  String? coverParking;
  String? openParking;
  String? you;
  String? BHK;
  int? balcony;
  String? propertyType;
  String? sellTransactionType;
  String? sellConstructionType;
  int? bathroom;
  String? furnishedType;
  List<String> clickedAminities = [];
  List<String> clickedFurnishing = [];
  List<File> images = [];
  int aminitiesTap = 0;
  List<String> BHKs = ['1 RK', '1 BHK', '2 BHK', '3 BHK', '3+ BHK'];
  List<int> bathrooms = [1, 2, 3, 4];
  List<int> balconies = [0, 1, 2, 3, 4];
  List<String> listingTypes = ['Residential', 'Commercial'];
  List<String> openParkings = ['1', '2', '3', '3+'];
  List<String> coverParkings = ['1', '2', '3', '3+'];
  List<String> furnishedTypes = [
    'Fully Furnished',
    'Semi Furnished ',
    'Unfurnished'
  ];
  List<String> furnishings = [
    'Dinning Table',
    'Washing Table',
    'Sofa',
    'Microwave',
    'Stove',
    'Fridge',
    'Water Purifier',
    'Gas Pipeline',
    'AC',
    'Bed',
    'TV',
    'Cupboard',
    'Geyser'
  ];
  List<String> aminities = [
    'Lift',
    'CCTV',
    'Gym',
    'Garden',
    'Kids Area',
    'Sports',
    'Swimming Pool',
    'Intercom',
    'Gated Community',
    'Club House',
    'Community Hall',
    'Regular Water Supply',
    'Power Backup',
    'Pet Allowed'
  ];
  List<String> lookingFors_residential = ['Rent', 'Sell', 'PG/Co-living'];
  List<String> lookingFors_commercial = ['Rent', 'Sell'];
  List<String> you_are = ['Owner', 'Builder', 'Broker'];
  List<String> sellTransactionTypes = ['New Booking', 'Resale'];
  List<String> sellConstructionTypes = ['Ready to Move', 'Under Construction'];
  List<String> commercialPropertyTypes = [
    'Office',
    'Retail Shop',
    'Showroom',
    'Warehouse',
    'Plot',
    'Other'
  ];
  List<String> residentialPropertyTypes = [
    'Apartment',
    'Independent Floor',
    'Independent House',
    'Villa'
  ];
  void selectImages() async {
    var res = await pickImage();

    setState(() {
      images = res;
    });
  }

  double? progress;
  @override
  void initState() {
    super.initState();
    LocalityController.addListener(() {
      _getLocationSuggetion();
    });
  }

  void _getLocationSuggetion() async {
    final location =
        await getLocationSuggestion('gvhjbj', LocalityController.text);
    setState(() {
      locationSuggetions = location;
      _ProgressController.keepPage;
    });
  }

  Future<void> _getCoordinate(String address) async {
    final coordinates = await getCoordinates(address);
    print(coordinates['lat']);
    setState(() {
      print('object');
      LocalityController.value = TextEditingValue(text: address);
      latitude = coordinates['lat'];
      longitude = coordinates['lng'];
      _ProgressController.keepPage;
      locationSuggetions = [];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _ProgressController.dispose();
    propertyAgeController.dispose();
    buildUpAreaController.dispose();
    carpetAreaController.dispose();
    propertyNameController.dispose();
    address_1_Controller.dispose();
    LocalityController.dispose();
    descriptionController.dispose();
    reraIDController.dispose();

    priceController.dispose();
  }

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
        body: PageView(
          controller: _ProgressController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 82, 5, 96),
                Colors.black,
              ])),
              child: Column(
                children: [
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
                      child: SingleChildScrollView(
                        child: Form(
                            key: _firstPageKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Listing Type *',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: listingTypes.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 30,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20,
                                                childAspectRatio: 4),
                                        itemBuilder: (context, index) {
                                          return FloatingActionButton.extended(
                                            heroTag: '@${listingTypes[index]}',
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                side: const BorderSide(
                                                    color: Colors.transparent)),
                                            elevation: 5,
                                            backgroundColor: listingType ==
                                                    listingTypes[index]
                                                ? const Color.fromARGB(
                                                    255, 177, 102, 190)
                                                : Colors.white,
                                            label: Text(
                                              listingTypes[index],
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              listingType = listingTypes[index];
                                              setState(() {});
                                            },
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Looking For *',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: listingType == 'Commercial'
                                            ? lookingFors_commercial.length
                                            : lookingFors_residential.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 10,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20,
                                                childAspectRatio: 4),
                                        itemBuilder: (context, index) {
                                          return FloatingActionButton.extended(
                                            heroTag:
                                                'p${lookingFors_residential[index]}',
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                side: const BorderSide(
                                                    color: Colors.transparent)),
                                            elevation: 5,
                                            backgroundColor: listingType ==
                                                    'Commercial'
                                                ? lookingFor ==
                                                        lookingFors_commercial[
                                                            index]
                                                    ? const Color.fromARGB(
                                                        255, 177, 102, 190)
                                                    : Colors.white
                                                : lookingFor ==
                                                        lookingFors_residential[
                                                            index]
                                                    ? const Color.fromARGB(
                                                        255, 177, 102, 190)
                                                    : Colors.white,
                                            label: Text(
                                              listingType == 'Commercial'
                                                  ? lookingFors_commercial[
                                                      index]
                                                  : lookingFors_residential[
                                                      index],
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              listingType == 'Commercial'
                                                  ? lookingFor =
                                                      lookingFors_commercial[
                                                          index]
                                                  : lookingFor =
                                                      lookingFors_residential[
                                                          index];
                                              setState(() {});
                                            },
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Yor are *',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: you_are.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 10,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20,
                                                childAspectRatio: 4),
                                        itemBuilder: (context, index) {
                                          return FloatingActionButton.extended(
                                            heroTag: 'i${you_are[index]}',
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                side: const BorderSide(
                                                    color: Colors.transparent)),
                                            elevation: 5,
                                            backgroundColor:
                                                you == you_are[index]
                                                    ? const Color.fromARGB(
                                                        255, 177, 102, 190)
                                                    : Colors.white,
                                            label: Text(
                                              you_are[index],
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              you = you_are[index];
                                              setState(() {});
                                            },
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Property type*',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      height: 100,
                                      width: double.infinity,
                                      child: listingType == 'Commercial'
                                          ? ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: commercialPropertyTypes
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: FloatingActionButton
                                                      .extended(
                                                    heroTag:
                                                        'u${commercialPropertyTypes[index]}',
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        side: const BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                    elevation: 5,
                                                    backgroundColor: propertyType ==
                                                            commercialPropertyTypes[
                                                                index]
                                                        ? const Color.fromARGB(
                                                            255, 177, 102, 190)
                                                        : Colors.white,
                                                    label: Text(
                                                      commercialPropertyTypes[
                                                          index],
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      propertyType =
                                                          commercialPropertyTypes[
                                                              index];
                                                      setState(() {});
                                                    },
                                                  ),
                                                );
                                              })
                                          : ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  residentialPropertyTypes
                                                      .length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: FloatingActionButton
                                                      .extended(
                                                    heroTag:
                                                        '#${residentialPropertyTypes[index]}',
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        side: const BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                    elevation: 5,
                                                    backgroundColor: propertyType ==
                                                            residentialPropertyTypes[
                                                                index]
                                                        ? const Color.fromARGB(
                                                            255, 177, 102, 190)
                                                        : Colors.white,
                                                    label: Text(
                                                      residentialPropertyTypes[
                                                          index],
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      propertyType =
                                                          residentialPropertyTypes[
                                                              index];
                                                      setState(() {});
                                                    },
                                                  ),
                                                );
                                              })),
                                  listingType == 'Residential'
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              const Text(
                                                'BHK*',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: BHKs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            FloatingActionButton
                                                                .extended(
                                                          heroTag:
                                                              'l${BHKs[index]}',
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          elevation: 5,
                                                          backgroundColor:
                                                              BHK == BHKs[index]
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      177,
                                                                      102,
                                                                      190)
                                                                  : Colors
                                                                      .white,
                                                          label: Text(
                                                            BHKs[index],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          onPressed: () {
                                                            BHK = BHKs[index];
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                'Bathroom*',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: bathrooms.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            FloatingActionButton
                                                                .extended(
                                                          heroTag:
                                                              'm${bathrooms[index]}',
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          elevation: 5,
                                                          backgroundColor:
                                                              bathroom ==
                                                                      bathrooms[
                                                                          index]
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      177,
                                                                      102,
                                                                      190)
                                                                  : Colors
                                                                      .white,
                                                          label: Text(
                                                            bathrooms[index]
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          onPressed: () {
                                                            bathroom =
                                                                bathrooms[
                                                                    index];
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                'Balcony*',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: balconies.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            FloatingActionButton
                                                                .extended(
                                                          heroTag:
                                                              'n${balconies[index]}',
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          elevation: 5,
                                                          backgroundColor:
                                                              balcony ==
                                                                      balconies[
                                                                          index]
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      177,
                                                                      102,
                                                                      190)
                                                                  : Colors
                                                                      .white,
                                                          label: Text(
                                                            balconies[index]
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          onPressed: () {
                                                            balcony = balconies[
                                                                index];
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Furnished Type*',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        furnishedTypes.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            FloatingActionButton
                                                                .extended(
                                                          heroTag:
                                                              'h${furnishedTypes[index]}',
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          elevation: 5,
                                                          backgroundColor:
                                                              furnishedType ==
                                                                      furnishedTypes[
                                                                          index]
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      177,
                                                                      102,
                                                                      190)
                                                                  : Colors
                                                                      .white,
                                                          label: Text(
                                                            furnishedTypes[
                                                                index],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          onPressed: () {
                                                            furnishedType =
                                                                furnishedTypes[
                                                                    index];
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              FloatingActionButton.extended(
                                                heroTag: '@jhk',
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    side: const BorderSide(
                                                        color: Colors
                                                            .transparent)),
                                                elevation: 5,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 175, 20, 202),
                                                label: const Text(
                                                  '+ Add Furrnishing/Amenities',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  if (aminitiesTap == 1) {
                                                    aminitiesTap = 0;
                                                  } else {
                                                    aminitiesTap = 1;
                                                  }
                                                  setState(() {});
                                                },
                                              ),
                                              aminitiesTap == 1
                                                  ? Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Society Amenities',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 200,
                                                          child:
                                                              GridView.builder(
                                                                  itemCount:
                                                                      aminities
                                                                          .length,
                                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                      mainAxisSpacing:
                                                                          10,
                                                                      crossAxisCount:
                                                                          3,
                                                                      crossAxisSpacing:
                                                                          10,
                                                                      childAspectRatio:
                                                                          4),
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return FloatingActionButton
                                                                        .extended(
                                                                      heroTag:
                                                                          'c${aminities[index]}',
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          side:
                                                                              const BorderSide(color: Colors.transparent)),
                                                                      elevation:
                                                                          5,
                                                                      backgroundColor: clickedAminities.contains(aminities[
                                                                              index])
                                                                          ? const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              177,
                                                                              102,
                                                                              190)
                                                                          : Colors
                                                                              .white,
                                                                      label:
                                                                          Text(
                                                                        aminities[
                                                                            index],
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 12),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        if (clickedAminities
                                                                            .contains(aminities[index])) {
                                                                          clickedAminities
                                                                              .remove(aminities[index]);
                                                                        } else {
                                                                          clickedAminities
                                                                              .add(aminities[index]);
                                                                        }
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                    );
                                                                  }),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Flat Furnishings',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 200,
                                                          child:
                                                              GridView.builder(
                                                                  itemCount:
                                                                      furnishings
                                                                          .length,
                                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                      mainAxisSpacing:
                                                                          10,
                                                                      crossAxisCount:
                                                                          3,
                                                                      crossAxisSpacing:
                                                                          10,
                                                                      childAspectRatio:
                                                                          4),
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return FloatingActionButton
                                                                        .extended(
                                                                      heroTag:
                                                                          'b${furnishings[index]}',
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          side:
                                                                              const BorderSide(color: Colors.transparent)),
                                                                      elevation:
                                                                          5,
                                                                      backgroundColor: clickedFurnishing.contains(furnishings[
                                                                              index])
                                                                          ? const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              177,
                                                                              102,
                                                                              190)
                                                                          : Colors
                                                                              .white,
                                                                      label:
                                                                          Text(
                                                                        furnishings[
                                                                            index],
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 12),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        if (clickedFurnishing
                                                                            .contains(furnishings[index])) {
                                                                          clickedFurnishing
                                                                              .remove(furnishings[index]);
                                                                        } else {
                                                                          clickedFurnishing
                                                                              .add(furnishings[index]);
                                                                        }
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                    );
                                                                  }),
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox(
                                                      height: 10,
                                                    ),
                                              const Text(
                                                'Cover Parking',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        coverParkings.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            FloatingActionButton
                                                                .extended(
                                                          heroTag:
                                                              'y${coverParkings[index]}',
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          elevation: 5,
                                                          backgroundColor:
                                                              coverParking ==
                                                                      coverParkings[
                                                                          index]
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      177,
                                                                      102,
                                                                      190)
                                                                  : Colors
                                                                      .white,
                                                          label: Text(
                                                            coverParkings[
                                                                index],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          onPressed: () {
                                                            coverParking =
                                                                coverParkings[
                                                                    index];
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                'Open Parking',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        openParkings.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            FloatingActionButton
                                                                .extended(
                                                          heroTag:
                                                              'j${openParkings[index]}',
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          elevation: 5,
                                                          backgroundColor:
                                                              openParking ==
                                                                      openParkings[
                                                                          index]
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      177,
                                                                      102,
                                                                      190)
                                                                  : Colors
                                                                      .white,
                                                          label: Text(
                                                            openParkings[index],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          onPressed: () {
                                                            openParking =
                                                                openParkings[
                                                                    index];
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ])
                                      : const SizedBox(
                                          height: 10,
                                        ),
                                  CustomTextField(
                                      controller: buildUpAreaController,
                                      hintText: 'Build Up Area'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                      controller: carpetAreaController,
                                      hintText: 'Carpet Area'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  listingType == 'Residential'
                                      ? lookingFor == 'Sell'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Transaction Type*',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  child: GridView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              mainAxisSpacing:
                                                                  10,
                                                              crossAxisCount: 2,
                                                              crossAxisSpacing:
                                                                  20,
                                                              childAspectRatio:
                                                                  4),
                                                      itemCount:
                                                          sellTransactionTypes
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return FloatingActionButton
                                                            .extended(
                                                          heroTag:
                                                              'v${sellConstructionTypes[index]}',
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          elevation: 5,
                                                          backgroundColor:
                                                              sellTransactionType ==
                                                                      sellTransactionTypes[
                                                                          index]
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      177,
                                                                      102,
                                                                      190)
                                                                  : Colors
                                                                      .white,
                                                          label: Text(
                                                            sellTransactionTypes[
                                                                index],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          onPressed: () {
                                                            sellTransactionType =
                                                                sellTransactionTypes[
                                                                    index];
                                                            setState(() {});
                                                          },
                                                        );
                                                      }),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Construction Type*',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  child: GridView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              mainAxisSpacing:
                                                                  10,
                                                              crossAxisCount: 2,
                                                              crossAxisSpacing:
                                                                  20,
                                                              childAspectRatio:
                                                                  4),
                                                      itemCount:
                                                          sellConstructionTypes
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return FloatingActionButton
                                                            .extended(
                                                          heroTag:
                                                              '%${sellConstructionTypes[index]}',
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          elevation: 5,
                                                          backgroundColor:
                                                              sellConstructionType ==
                                                                      sellConstructionTypes[
                                                                          index]
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      177,
                                                                      102,
                                                                      190)
                                                                  : Colors
                                                                      .white,
                                                          label: Text(
                                                            sellConstructionTypes[
                                                                index],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          onPressed: () {
                                                            sellConstructionType =
                                                                sellConstructionTypes[
                                                                    index];
                                                            setState(() {});
                                                          },
                                                        );
                                                      }),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                CustomTextField(
                                                    controller: priceController,
                                                    hintText: 'Price')
                                              ],
                                            )
                                          : Column(children: [
                                              CustomTextField(
                                                  controller:
                                                      propertyAgeController,
                                                  hintText: 'Property Age'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              CustomTextField(
                                                  controller: priceController,
                                                  hintText: 'Cost per month')
                                            ])
                                      : CustomTextField(
                                          controller: priceController,
                                          hintText: 'Cost'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomButton(
                                      text: 'Next, add address',
                                      onTap: () {
                                        if (_firstPageKey.currentState!
                                            .validate()) {
                                          _ProgressController.animateToPage(1,
                                              duration: const Duration(
                                                  milliseconds: 40),
                                              curve: Curves.bounceIn);
                                        }
                                      })
                                ])),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //     Second Page
            //...................................................................................................................

            BlocConsumer<VendorBloc, VendorState>(
              listener: (context, state) {
                if (state is ListingSuccessful) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is ListingLoading) {
                  return Loader();
                }
                return Container(
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
                        child: SingleChildScrollView(
                          child: Form(
                            key: _secondPageKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  images.isNotEmpty
                                      ? Stack(children: [
                                          CarouselSlider(
                                            items: images.map((i) {
                                              int idx = images.indexOf(i);
                                              return Builder(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Stack(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            children: [
                                                              Image.file(
                                                                i,
                                                                fit: BoxFit
                                                                    .contain,
                                                                height: 500,
                                                              ),
                                                              Text(
                                                                '${idx + 1}/${images.length}',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            96,
                                                                            93,
                                                                            93)),
                                                              )
                                                            ],
                                                          ));
                                            }).toList(),
                                            options: CarouselOptions(
                                                viewportFraction: 1,
                                                height: 500),
                                          ),
                                          FloatingActionButton(
                                            onPressed: selectImages,
                                            child: Text('Add'),
                                          ),
                                        ])
                                      : GestureDetector(
                                          onTap: selectImages,
                                          child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(10),
                                              dashPattern: [10, 4],
                                              strokeCap: StrokeCap.round,
                                              child: Container(
                                                width: double.infinity,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.folder_open,
                                                      size: 40,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Select Property Images",
                                                      style: TextStyle(),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  CustomTextField(
                                    controller: propertyNameController,
                                    hintText: 'Property Name',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    controller: descriptionController,
                                    hintText: 'Property Description',
                                    maxLines: 7,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    controller: address_1_Controller,
                                    hintText: 'Address line 1 ',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    controller: LocalityController,
                                    hintText: 'Locality',
                                    maxLines: 1,
                                  ),
                                  locationSuggetions == []
                                      ? SizedBox(
                                          height: 10,
                                        )
                                      : Container(
                                          height: 200,
                                          child: ListView.builder(
                                              itemCount:
                                                  locationSuggetions.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    final coordinates =
                                                        await getCoordinates(
                                                            locationSuggetions[
                                                                    index][
                                                                'description']);
                                                    setState(() {
                                                      latitude =
                                                          coordinates['lat'];
                                                      longitude =
                                                          coordinates['lng'];
                                                      LocalityController.text =
                                                          locationSuggetions[
                                                                  index]
                                                              ['description'];
                                                      locationSuggetions = [];
                                                      LocalityController
                                                          .removeListener(
                                                              () {});
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      elevation: 3,
                                                      child: ListTile(
                                                        title: Text(
                                                            locationSuggetions[
                                                                    index][
                                                                'description']),
                                                        leading: Icon(
                                                            Icons.location_on),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  listingType == 'Residential'
                                      ? lookingFor == 'Sell'
                                          ? CustomTextField(
                                              controller: reraIDController,
                                              hintText: 'RERA ID')
                                          : Text('')
                                      : Text(''),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FloatingActionButton.extended(
                                        heroTag: 'previouspage',
                                        label: Icon(Icons.arrow_left),
                                        onPressed: () {
                                          _ProgressController.animateToPage(0,
                                              duration: const Duration(
                                                  milliseconds: 40),
                                              curve: Curves.bounceIn);
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      FloatingActionButton.extended(
                                        heroTag: 'submitt',
                                        label: const Text('List your property'),
                                        onPressed: () {
                                          createProperty();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                    ]));
              },
            ),
            Container()
          ],
        ));
  }
}
