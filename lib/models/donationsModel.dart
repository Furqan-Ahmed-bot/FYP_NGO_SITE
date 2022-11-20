// To parse this JSON data, do
//
//     final donations = donationsFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<Donations> donationsFromJson(String str) =>
    List<Donations>.from(json.decode(str).map((x) => Donations.fromJson(x)));

String donationsToJson(List<Donations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donations {
  Donations(
      {required this.username,
      required this.name,
      required this.quantity,
      required this.date,
      required this.donationId,
      required this.image});

  String username;
  String name;
  String quantity;
  String date;
  String donationId;
  String image;

  factory Donations.fromJson(Map<String, dynamic> json) => Donations(
        username: json["username"],
        name: json["name"],
        quantity: json["quantity"],
        date: json["date"],
        donationId: json["donation_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "quantity": quantity,
        "date": date,
        "donation_id": donationId,
        "image": image,
      };
}
