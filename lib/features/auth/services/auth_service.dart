import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:livenxt_front/common/widgets/bottom_bar.dart';
import 'package:livenxt_front/constants/error_handling.dart';
import 'package:livenxt_front/constants/global_variable.dart';
import 'package:livenxt_front/constants/utils.dart';
import 'package:livenxt_front/features/auth/screens/auth_screen.dart';

import 'package:livenxt_front/features/vendor/screens/vendor_screens.dart';
import 'package:livenxt_front/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/property.dart';
import '../../../providers/user_provider.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      Position position = await getUserCurrentLocation();
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          type: "",
          accessToken: "",
          refreshToken: "",
          latitude: position.latitude,
          longitude: position.longitude);
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/auth/create-user'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            ShowSnackBar(
                context, 'Account created! login with same credentials');
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      Position position = await getUserCurrentLocation();
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/auth/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'latitude': position.latitude,
          'longitude': position.longitude
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            final SharedPreferences prefr =
                await SharedPreferences.getInstance();

            await prefr.setString(
                'x-access-token', jsonDecode(res.body)["accessToken"]);

            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            ShowSnackBar(context, 'Logged in successfully');
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            User user = User.fromJson(res.body);
            user.type == "user"
                ? Navigator.pushNamedAndRemoveUntil(
                    context, BottomBar.routeName, (route) => false)
                : Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => VendorScreen()),
                    (route) => false);
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      Position position = await getUserCurrentLocation();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');

      if (accessToken == null) {
        prefs.setString('x-access-token', '');
      }
      final userRes = await http.post(Uri.parse('$uri/api/v1/auth/getUser'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-access-token': accessToken!
          },
          body: jsonEncode({
            'latitude': position.latitude,
            'longitude': position.longitude
          }));
      print(userRes.body);

      Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  Future<List<Property>> fetchSellProperties(BuildContext context,
      {required double latitude, required double longitude}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Property> propertyList = [];

    try {
      http.Response res = await http.post(Uri.parse('$uri/api/v1/auth/getSell'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'x-access-token': userProvider.user.accessToken!,
          },
          body: jsonEncode({'latitude': latitude, 'longitude': longitude}));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              propertyList
                  .add(Property.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e, stacktrace) {
      ShowSnackBar(context, e.toString());
      print(e.toString());
      print(stacktrace);
    }

    return propertyList;
  }

  Future<List<Property>> fetchRentProperties(BuildContext context,
      {required double latitude, required double longitude}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Property> propertyList = [];
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/v1/auth/getRent'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'x-access-token': userProvider.user.accessToken!,
          },
          body: jsonEncode({'latitude': latitude, 'longitude': longitude}));
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

  Future<List<Property>> fetchCommercialProperties(BuildContext context,
      {required double latitude, required double longitude}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Property> propertyList = [];

    try {
      http.Response res =
          await http.post(Uri.parse('$uri/api/v1/auth/getCommercial'),
              headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'x-access-token': userProvider.user.accessToken!,
              },
              body: jsonEncode({'latitude': latitude, 'longitude': longitude}));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              propertyList
                  .add(Property.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e, stacktrace) {
      ShowSnackBar(context, e.toString());
      print(e.toString());
      print(stacktrace);
    }

    return propertyList;
  }

  createLead(BuildContext context, String propertyId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/v1/auth/createLead'), headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-access-token': userProvider.user.accessToken!,
        'propertyId': propertyId
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            ShowSnackBar(context, 'Success');
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
      print(e.toString());
    }
  }

  createEnquiry(BuildContext context, String propertyId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/v1/auth/createEnquired'), headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-access-token': userProvider.user.accessToken!,
        'propertyId': propertyId
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            ShowSnackBar(context, 'Success');
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  LogOutUser(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/v1/auth/logout'), headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-access-token': userProvider.user.accessToken!,
      });
      final SharedPreferences prefr = await SharedPreferences.getInstance();
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            ShowSnackBar(context, 'Logged out successfully');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
                (route) => false);
          });
      prefr.clear();
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
