part of 'vendor_bloc.dart';

@immutable
sealed class VendorState {}

final class VendorInitial extends VendorState {}

final class ListingSuccessful extends VendorState {}

final class ListingLoading extends VendorState {}

final class ListingError extends VendorState {
  final String error;

  ListingError(this.error);
}
