import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:livenxt_front/constants/error_handling.dart';
import 'package:livenxt_front/constants/global_variable.dart';
import 'package:livenxt_front/constants/utils.dart';
import 'package:livenxt_front/models/commercial_property.dart';
import 'package:livenxt_front/models/for_buy_property.dart';
import 'package:livenxt_front/models/rental_property.dart';
import 'package:livenxt_front/models/user.dart';
import 'package:provider/provider.dart';

import '../../../models/property.dart';
import '../../../providers/user_provider.dart';

class VendorServices {
  static int state = 1;
  Future<void> listCommercialProprty(
      {required BuildContext context,
      required String name,
      required String description,
      required String address,
      required int price,
      required List<File> images,
      required String locality,
      required String listingType,
      required String lookingFor,
      required String propertyType,
      required int buildUpArea,
      required int carpetArea,
      required double latitude,
      required double longitude}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('drc3jpkia', 'gsxrhdqc');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      CommercialProperty property = CommercialProperty(
          name: name,
          description: description,
          address: address,
          price: price,
          images: imageUrls,
          locality: locality,
          listingType: listingType,
          lookingFor: lookingFor,
          propertyType: propertyType,
          buildUpArea: buildUpArea,
          carpetArea: carpetArea,
          latitude: latitude,
          longitude: longitude);
      http.Response res = await http.post(
          Uri.parse('$uri/api/v1/vendor/list-new-property-commercial'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'x-access-token': userProvider.user.accessToken!,
          },
          body: property.toJson());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            ShowSnackBar(context, 'Property listed successfully');
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  Future<void> listForShellProprty({
    required BuildContext context,
    required String name,
    required String description,
    required String address,
    required int price,
    required List<File> images,
    required String locality,
    required String listingType,
    required String lookingFor,
    required String propertyType,
    required int buildUpArea,
    required int carpetArea,
    required double latitude,
    required double longitude,
    required String BHK,
    required int bathroom,
    required int balcony,
    required String coverParking,
    required String openParking,
    required String furnishedType,
    required List<String>? flatFurnishing,
    required List<String>? societyAmenities,
    required String transactionType,
    required String constructionType,
    required int? reraId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('drc3jpkia', 'gsxrhdqc');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      ForSellProperty property = ForSellProperty(
          name: name,
          description: description,
          address: address,
          price: price,
          images: imageUrls,
          locality: locality,
          listingType: listingType,
          lookingFor: lookingFor,
          propertyType: propertyType,
          buildUpArea: buildUpArea,
          carpetArea: carpetArea,
          latitude: latitude,
          longitude: longitude,
          BHK: BHK,
          bathroom: bathroom,
          balcony: balcony,
          coverParking: coverParking,
          openParking: openParking,
          furnishedType: furnishedType,
          transactionType: transactionType,
          constructionType: constructionType,
          flatFurnishing: flatFurnishing,
          societyAmenities: societyAmenities,
          reraId: reraId);
      http.Response res = await http.post(
          Uri.parse('$uri/api/v1/vendor/list-new-property-for-sell'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'x-access-token': userProvider.user.accessToken!,
          },
          body: property.toJson());
      print(property.toJson().toString());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            ShowSnackBar(context, 'Property listed successfully');
          });
    } catch (e) {
      print(e.toString());
      ShowSnackBar(context, e.toString());
    }
  }

  Future<void> listRentalProperty(
      {required BuildContext context,
      required String name,
      required String description,
      required String address,
      required int price,
      required List<File> images,
      required String locality,
      required String listingType,
      required String lookingFor,
      required String propertyType,
      required int buildUpArea,
      required int carpetArea,
      required double latitude,
      required double longitude,
      required String BHK,
      required int bathroom,
      required int balcony,
      required String coverParking,
      required String openParking,
      required String furnishedType,
      required List<String>? flatFurnishing,
      required List<String>? societyAmenities,
      required double propertyAge}) async {
    state = 0;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('drc3jpkia', 'gsxrhdqc');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      RentalProperty property = RentalProperty(
        name: name,
        description: description,
        address: address,
        price: price,
        images: imageUrls,
        locality: locality,
        listingType: listingType,
        lookingFor: lookingFor,
        propertyType: propertyType,
        buildUpArea: buildUpArea,
        carpetArea: carpetArea,
        latitude: latitude,
        longitude: longitude,
        BHK: BHK,
        bathroom: bathroom,
        balcony: balcony,
        coverParking: coverParking,
        openParking: openParking,
        furnishedType: furnishedType,
        propertyAge: propertyAge,
        flatFurnishing: flatFurnishing,
        societyAmenities: societyAmenities,
      );
      http.Response res = await http.post(
          Uri.parse('$uri/api/v1/vendor/list-new-property-rental'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'x-access-token': userProvider.user.accessToken!,
          },
          body: property.toJson());
      print(property.toJson().toString());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            ShowSnackBar(context, 'Property listed successfully');
          });
    } catch (e) {
      print(e.toString());
      ShowSnackBar(context, e.toString());
    }
    state = 1;
  }

  Future<List<Property>> fetchVendorProperties(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Property> propertyList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/v1/vendor/get-vendor-properties'), headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-access-token': userProvider.user.accessToken!,
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              propertyList.add(Property.fromJson(jsonEncode(
                jsonDecode(res.body)[i],
              )));
            }
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
    print(propertyList);
    return propertyList;
  }

  Future<List<User>> fetchClickedUsers(
      BuildContext context, String propertyId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<User> userList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/v1/vendor/getClickedUsers'), headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-access-token': userProvider.user.accessToken!,
        'propertyId': propertyId
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              userList.add(User.fromJson(jsonEncode(
                jsonDecode(res.body)[i]["clickedUser"][0],
              )));
            }
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }

    return userList;
  }
}
