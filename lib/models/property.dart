// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Property {
  final String id;
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
  final String? BHK;
  final int? bathroom;
  final int? balcony;
  final String? coverParking;
  final String? openParking;
  final String? furnishedType;
  final List<String>? flatFurnishing;
  final List<String>? societyAmenities;
  final String? transactionType;
  final String? constructionType;
  final int? reraId;
  final double? propertyAge;
  Property({
    required this.id,
    required this.name,
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
    this.latitude,
    this.longitude,
    this.BHK,
    this.bathroom,
    this.balcony,
    this.coverParking,
    this.openParking,
    this.furnishedType,
    this.flatFurnishing,
    this.societyAmenities,
    this.transactionType,
    this.constructionType,
    this.reraId,
    this.propertyAge,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
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
      'BHK': BHK,
      'bathroom': bathroom,
      'balcony': balcony,
      'coverParking': coverParking,
      'openParking': openParking,
      'furnishedType': furnishedType,
      'flatFurnishing': flatFurnishing,
      'societyAmenities': societyAmenities,
      'transactionType': transactionType,
      'constructionType': constructionType,
      'reraId': reraId,
      'propertyAge': propertyAge,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      address: map['address'] as String,
      locality: map['locality'] as String,
      listingType: map['listingType'] as String,
      lookingFor: map['lookingFor'] as String,
      images: List<String>.from(map['images']),
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
      BHK:
          map['details'].isNotEmpty ? map['details'][0]['BHK'] as String : null,
      bathroom: map['details'].isNotEmpty
          ? map['details'][0]['bathroom'] as int
          : null,
      balcony: map['details'].isNotEmpty
          ? map['details'][0]['balcony'] as int
          : null,
      coverParking: map['details'].isNotEmpty
          ? map['details'][0]['coverParking'] as String
          : null,
      openParking: map['details'].isNotEmpty
          ? map['details'][0]['openParking'] as String
          : null,
      furnishedType: map['details'].isNotEmpty
          ? map['details'][0]['furnishedType'] as String
          : null,
      flatFurnishing: map['details'].isNotEmpty
          ? map['details'][0]['flatFurnishing'].isNotEmpty
              ? List<String>.from(
                  map['details'][0]['flatFurnishing'] as List<String>)
              : null
          : null,
      societyAmenities: map['details'].isNotEmpty
          ? map['details'][0]['societyAmenities'].isNotEmpty
              ? List<String>.from(
                  map['details'][0]['societyAmenities'] as List<String>)
              : null
          : null,
      transactionType: map['transactionType'] != null
          ? map['transactionType'] as String
          : null,
      constructionType: map['constructionType'] != null
          ? map['constructionType'] as String
          : null,
      reraId: map['subscribers'][0]['reraId'] != null
          ? map['subscribers'][0]['reraId'] as int
          : null,
      propertyAge:
          map['propertyAge'] != null ? map['propertyAge'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Property.fromJson(String source) =>
      Property.fromMap(json.decode(source) as Map<String, dynamic>);
}
