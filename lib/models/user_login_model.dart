// To parse this JSON data, do
//
//     final getUserlogIn = getUserlogInFromJson(jsonString);

import 'dart:convert';

GetUserlogIn getUserlogInFromJson(String str) =>
    GetUserlogIn.fromJson(json.decode(str));

String getUserlogInToJson(GetUserlogIn data) => json.encode(data.toJson());

class GetUserlogIn {
  String? message;
  User? user;
  String? otp;

  GetUserlogIn({this.message, this.user, this.otp});

  factory GetUserlogIn.fromJson(Map<String, dynamic> json) => GetUserlogIn(
    message: json["Message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "user": user?.toJson(),
    "otp": otp,
  };
}

class User {
  String? id;
  String? name;
  String? emailid;
  String? mobileno;
  String? address;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic pincode;
  String? requirementId;
  dynamic gender;
  String? superCatId;
  String? status;
  String? otp;
  String? otpVerify;

  User({
    this.id,
    this.name,
    this.emailid,
    this.mobileno,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.requirementId,
    this.gender,
    this.superCatId,
    this.status,
    this.otp,
    this.otpVerify,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    emailid: json["emailid"],
    mobileno: json["mobileno"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
    requirementId: json["requirement_id"],
    gender: json["gender"],
    superCatId: json["super_cat_id"],
    status: json["status"],
    otp: json["otp"],
    otpVerify: json["otp_verify"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "emailid": emailid,
    "mobileno": mobileno,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "pincode": pincode,
    "requirement_id": requirementId,
    "gender": gender,
    "super_cat_id": superCatId,
    "status": status,
    "otp": otp,
    "otp_verify": otpVerify,
  };
}
