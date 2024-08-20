import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final double? latitude;
  final double? longitude;
  final String? accessToken;
  final String refreshToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    this.latitude,
    this.longitude,
    this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
      latitude: map['location']['coordinates'][1] != null
          ? map['location']['coordinates'][1] as double
          : null,
      longitude: map['location']['coordinates'][0] != null
          ? map['location']['coordinates'][0] as double
          : null,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      refreshToken: map['refreshToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
