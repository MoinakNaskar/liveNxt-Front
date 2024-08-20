// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommercialProperty {
  final String name;
  final String description;
  final String address;
  final String locality;
  final String listingType;
  final String lookingFor;
  final List<String> images;
  final String propertyType;
  final int price;
  final int buildUpArea;
  final int carpetArea;
  final double? latitude;
  final double? longitude;

  CommercialProperty(
      {required this.name,
      required this.description,
      required this.address,
      required this.locality,
      required this.listingType,
      required this.lookingFor,
      required this.images,
      required this.propertyType,
      required this.price,
      required this.buildUpArea,
      required this.carpetArea,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'address': address,
      'locality': locality,
      'listingType': listingType,
      'lookingFor': lookingFor,
      'images': images,
      'propertyType': propertyType,
      'price': price,
      'buildUpArea': buildUpArea,
      'carpetArea': carpetArea,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory CommercialProperty.fromMap(Map<String, dynamic> map) {
    return CommercialProperty(
      name: map['name'] as String,
      description: map['description'] as String,
      address: map['address'] as String,
      locality: map['locality'] as String,
      listingType: map['listingType'] as String,
      lookingFor: map['lookingFor'] as String,
      images: List<String>.from(map['images'] as List<String>),
      propertyType: map['propertyType'] as String,
      price: map['price'] as int,
      buildUpArea: map['buildUpArea'] as int,
      carpetArea: map['carpetArea'] as int,
      latitude: map['location']['coordinates'][1] != null
          ? map['location']['coordinates'][1] as double
          : null,
      longitude: map['location']['coordinates'][0] != null
          ? map['location']['coordinates'][0] as double
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommercialProperty.fromJson(String source) =>
      CommercialProperty.fromMap(json.decode(source) as Map<String, dynamic>);
}
