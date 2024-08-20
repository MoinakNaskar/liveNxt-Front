// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:livenxt_front/common/widgets/loader.dart';
import 'package:livenxt_front/common/widgets/single_property.dart';
import 'package:livenxt_front/features/vendor/services/vendor_services.dart';

import 'package:livenxt_front/models/property.dart';

import '../../../models/user.dart';

class VendorPropertyPage extends StatefulWidget {
  static final routeName = '/vendoe-property-page';
  final Property property;
  const VendorPropertyPage({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  State<VendorPropertyPage> createState() => _VendorPropertyPageState();
}

class _VendorPropertyPageState extends State<VendorPropertyPage> {
  List<User>? users;
  VendorServices vendorServices = VendorServices();
  getClickedUser() async {
    print(widget.property.id);
    users =
        await vendorServices.fetchClickedUsers(context, widget.property.id!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getClickedUser();
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
                child: const Row(
                  children: [
                    Text(
                      'LiveN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      'X',
                      style: TextStyle(
                          color: Color.fromARGB(205, 234, 202, 17),
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    ),
                    Text(
                      't',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )
                  ],
                ),
              ),
              const Text(
                'Merchant',
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
              )
            ],
          ),
        ),
      ),
      body: users == null
          ? Loader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleProduct(images: widget.property.images!),
                Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Total Clicked  -${users!.length}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: users!.length,
                      itemBuilder: (context, index) {
                        final user = users![index];
                        return ListTile(
                          onTap: () {},
                          title: Text('${index + 1}. ${user.name}'),
                          trailing: Text(
                            user.address,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Total Enquiry  -${users!.length}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: Text('edit'),
      ),
    );
  }
}
