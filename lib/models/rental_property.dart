import 'dart:convert';

class RentalProperty {
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
  final String BHK;
  final int bathroom;
  final int balcony;
  final String coverParking;
  final String openParking;
  final String furnishedType;
  final List<String>? flatFurnishing;
  final List<String>? societyAmenities;
  final double propertyAge;

  RentalProperty(
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
      required this.longitude,
      required this.BHK,
      required this.bathroom,
      required this.balcony,
      required this.coverParking,
      required this.openParking,
      required this.furnishedType,
      required this.flatFurnishing,
      required this.societyAmenities,
      required this.propertyAge});
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
      'BHK': BHK,
      'bathroom': bathroom,
      'balcony': balcony,
      'coverParking': coverParking,
      'openParking': openParking,
      'furnishedType': furnishedType,
      'flatFurnishing': flatFurnishing,
      'societyAmenities': societyAmenities,
      'propertyAge': propertyAge
    };
  }

  factory RentalProperty.fromMap(Map<String, dynamic> map) {
    return RentalProperty(
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
      BHK: map['details'][0]['BHK'] as String,
      bathroom: map['details'][0]['bathroom'] as int,
      balcony: map['details'][0]['balcony'] as int,
      coverParking: map['details'][0]['coverParking'] as String,
      openParking: map['details'][0]['openParking'] as String,
      furnishedType: map['details'][0]['furnishedType'] as String,
      flatFurnishing: map['details'][0]['flatFurnishing'] != null
          ? List<String>.from(
              map['details'][0]['flatFurnishing'] as List<String>)
          : null,
      societyAmenities: map['details'][0]['societyAmenities'] != null
          ? List<String>.from(
              map['details'][0]['societyAmenities'] as List<String>)
          : null,
      propertyAge: map['propertyAge'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory RentalProperty.fromJson(String source) =>
      RentalProperty.fromMap(json.decode(source) as Map<String, dynamic>);
}
