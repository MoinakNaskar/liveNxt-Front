import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:livenxt_front/features/vendor/services/vendor_services.dart';
import 'package:meta/meta.dart';

part 'vendor_event.dart';
part 'vendor_state.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  VendorServices _vendorServices = VendorServices();
  VendorBloc() : super(VendorInitial()) {
    on<ListingButtonClicked>(_listProperty);
  }
  void _listProperty(
      ListingButtonClicked event, Emitter<VendorState> emit) async {
    emit(ListingLoading());
    try {
      if (event.listingType == 'Commercial') {
        await _vendorServices.listCommercialProprty(
            context: event.context,
            name: event.name,
            description: event.description,
            address: event.address,
            price: event.price,
            images: event.images,
            locality: event.locality,
            listingType: event.listingType,
            lookingFor: event.lookingFor,
            propertyType: event.propertyType,
            buildUpArea: event.buildUpArea,
            carpetArea: event.carpetArea,
            latitude: event.latitude!,
            longitude: event.longitude!);
      }
      if (event.listingType == 'Residential') {
        if (event.lookingFor == 'Sell') {
          await _vendorServices.listForShellProprty(
            context: event.context,
            name: event.name,
            description: event.description,
            address: event.address,
            price: event.price,
            images: event.images,
            locality: event.locality,
            listingType: event.listingType,
            lookingFor: event.lookingFor,
            propertyType: event.propertyType,
            buildUpArea: event.buildUpArea,
            carpetArea: event.carpetArea,
            latitude: event.latitude!,
            longitude: event.longitude!,
            BHK: event.BHK!,
            bathroom: event.bathroom!,
            balcony: event.balcony!,
            coverParking: event.coverParking!,
            openParking: event.openParking!,
            furnishedType: event.furnishedType!,
            flatFurnishing: event.flatFurnishing,
            societyAmenities: event.societyAmenities,
            transactionType: event.transactionType!,
            constructionType: event.constructionType!,
            reraId: event.reraId,
          );
        }
        if (event.lookingFor == 'Rent') {
          await _vendorServices.listRentalProperty(
              context: event.context,
              name: event.name,
              description: event.description,
              address: event.address,
              price: event.price,
              images: event.images,
              locality: event.locality,
              listingType: event.listingType,
              lookingFor: event.lookingFor,
              propertyType: event.propertyType,
              buildUpArea: event.buildUpArea,
              carpetArea: event.carpetArea,
              latitude: event.latitude!,
              longitude: event.longitude!,
              BHK: event.BHK!,
              bathroom: event.bathroom!,
              balcony: event.balcony!,
              coverParking: event.coverParking!,
              openParking: event.openParking!,
              furnishedType: event.furnishedType!,
              flatFurnishing: event.flatFurnishing,
              societyAmenities: event.societyAmenities,
              propertyAge: event.propertyAge!);
        }
      }

      return emit(ListingSuccessful());
    } catch (e) {
      debugPrint(e.toString());
      emit(ListingError(e.toString()));
    }
  }
}
