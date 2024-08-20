import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void ShowSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<List<File>> pickImage() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

Future<Position> getUserCurrentLocation() async {
  await Geolocator.requestPermission()
      .then((value) {})
      .onError((error, stackTrace) {
    print('error' + error.toString());
  });
  return await Geolocator.getCurrentPosition();
}

Future<dynamic> getLocationSuggestion(String sessionToken, String value) async {
  String API_KEY = 'AIzaSyBs1dDl_g7l4Q_OVemtPdSo4j48cs1ei4U';
  Uri uri = Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json',
      {'input': value, 'key': API_KEY, 'sessiontoken': sessionToken});

  var response = await http.get(uri, headers: {
    "Access-Control-Allow-Origin": "*",
    'Accept': '*/*',
    'Content-Type': 'application/json'
  });

  print(response);
  if (response.statusCode == 200) {
    dynamic places = json.decode(response.body)['predictions'];
    return places;
  } else {
    throw Exception('Failed to find location');
  }
}

Future<dynamic> getCoordinates(String address) async {
  String API_KEY = 'AIzaSyBs1dDl_g7l4Q_OVemtPdSo4j48cs1ei4U';
  Uri uri = Uri.https('maps.googleapis.com', 'maps/api/geocode/json',
      {'address': address, 'key': API_KEY});

  var response = await http.get(uri);

  if (response.statusCode == 200) {
    final location =
        jsonDecode(response.body)['results'][0]['geometry']['location'];

    return location;
  } else {
    throw Exception('Failed to find location');
  }
}

Future<String> getAddress(
    {required double latitude, required double longitude}) async {
  String API_KEY = 'AIzaSyBs1dDl_g7l4Q_OVemtPdSo4j48cs1ei4U';
  Uri uri = Uri.https('maps.googleapis.com', 'maps/api/geocode/json',
      {'latlng': '$latitude,$longitude', 'key': API_KEY});
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    String address =
        jsonDecode(response.body)['results'][0]['formatted_address'];
    return address;
  } else {
    throw Exception('Failed to find location');
  }
}
