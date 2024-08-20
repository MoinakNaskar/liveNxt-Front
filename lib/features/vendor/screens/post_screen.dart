import 'package:flutter/material.dart';
import 'package:livenxt_front/common/widgets/loader.dart';
import 'package:livenxt_front/common/widgets/single_property.dart';

import 'package:livenxt_front/features/vendor/listing_screens/listing_1.dart';

import 'package:livenxt_front/features/vendor/screens/vendor_product_screen.dart';
import 'package:livenxt_front/features/vendor/services/vendor_services.dart';
import 'package:livenxt_front/models/property.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Property>? properties;
  void navigateToAddProduct() {
    Navigator.pushNamed(context, Listing.routeName);
  }

  final VendorServices vendorServices = VendorServices();
  @override
  void initState() {
    super.initState();
    fetchAllProuct();
  }

  navigateToPropertyPage(property) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VendorPropertyPage(property: property)));
  }

  fetchAllProuct() async {
    properties = await vendorServices.fetchVendorProperties(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return properties == null
        ? const Loader()
        : Scaffold(
            body: ListView.builder(
              itemCount: properties!.length,
              itemBuilder: (context, index) {
                final propertyData = properties![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    onTap: () {
                      navigateToPropertyPage(propertyData);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(139, 255, 255, 255),
                          border: Border.fromBorderSide(
                              BorderSide(color: Colors.white))),
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              SingleProduct(images: propertyData.images!),
                              Opacity(
                                opacity: 0.5,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  width: double.infinity,
                                  color: Colors.black,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        propertyData.address,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            propertyData.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            propertyData.description,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'List a new Property',
              onPressed: navigateToAddProduct,
              child: const Icon(Icons.add),
            ),
          );
  }
}
