// To parse this JSON data, do
//
//     final ngoDonations = ngoDonationsFromJson(jsonString);

// ignore_for_file: file_names

// To parse this JSON data, do
//
//     final donations = donationsFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

List<NgoDonations> donationsFromJson(String str) => List<NgoDonations>.from(
    json.decode(str).map((x) => NgoDonations.fromJson(x)));

String donationsToJson(List<NgoDonations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NgoDonations {
  NgoDonations({
    required this.username,
    required this.name,
    required this.quantity,
    required this.date,
    required this.donationId,
    required this.image,
    required this.address,
    required this.fcm,
  });

  String username;
  String name;
  String quantity;
  String date;
  String donationId;
  String image;
  String address;
  String fcm;

  factory NgoDonations.fromJson(Map<String, dynamic> json) => NgoDonations(
        username: json["username"],
        name: json["name"],
        quantity: json["quantity"],
        date: json["date"],
        donationId: json["donationId"],
        image: json["image"],
        address: json["address"],
        fcm: json["fcm"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "quantity": quantity,
        "date": date,
        "donationId": donationId,
        "image": image,
        "fcm": fcm
      };
}
