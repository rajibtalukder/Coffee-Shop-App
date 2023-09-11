// To parse this JSON data, do
//
//     final authenticatedUser = authenticatedUserFromJson(jsonString);

import 'dart:convert';

AuthenticatedUser authenticatedUserFromJson(String str) => AuthenticatedUser.fromJson(json.decode(str));

String authenticatedUserToJson(AuthenticatedUser data) => json.encode(data.toJson());

class AuthenticatedUser {
  Data? data;

  AuthenticatedUser({
    this.data,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) => AuthenticatedUser(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  bool? isVerified;
  dynamic verifyField;
  int? rewardsAvailable;
  String? image;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.verifyField,
    this.rewardsAvailable,
    this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    role: json["role"],
    isVerified: json["is_verified"],
    verifyField: json["verify_field"],
    rewardsAvailable: json["rewards_available"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "role": role,
    "is_verified": isVerified,
    "verify_field": verifyField,
    "rewards_available": rewardsAvailable,
    "image": image,
  };
}
