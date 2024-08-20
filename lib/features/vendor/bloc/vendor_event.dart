part of 'vendor_bloc.dart';

@immutable
sealed class VendorEvent {}

final class ListingButtonClicked extends VendorEvent {
  final BuildContext context;

  final String name;
  final String description;
  final String address;
  final String locality;
  final String listingType;
  final String lookingFor;
  final List<File> images;
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

  ListingButtonClicked(
      {required this.context,
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
      this.propertyAge});
}
