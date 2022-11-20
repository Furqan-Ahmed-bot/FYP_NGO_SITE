// To parse this JSON data, do
//
//     final DistDonationModel = DistDonationModelFromJson(jsonString);

import 'dart:convert';

List<DistDonationModel> DistDonationModelFromJson(String str) => List<DistDonationModel>.from(json.decode(str).map((x) => DistDonationModel.fromJson(x)));

String DistDonationModelToJson(List<DistDonationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistDonationModel {
    DistDonationModel({
       required this.id,
       required this.donationId,
       required this.ngoId,
       required this.firstname,
       required this.lastname,
       required this.cnic,
       required this.address,
       required this.contact,
       required this.quantity,
       required this.category,
       required this.date,
    });

    String id;
    String donationId;
    String ngoId;
    String firstname;
    String lastname;
    String cnic;
    String address;
    String contact;
    String quantity;
    String category;
    String date;

    factory DistDonationModel.fromJson(Map<String, dynamic> json) => DistDonationModel(
        id: json["id"],
        donationId: json["donation_id"],
        ngoId: json["ngo_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        cnic: json["cnic"],
        address: json["address"],
        contact: json["contact"],
        quantity: json["quantity"],
        category: json["category"],
        date: json["Date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "donation_id": donationId,
        "ngo_id": ngoId,
        "firstname": firstname,
        "lastname": lastname,
        "cnic": cnic,
        "address": address,
        "contact": contact,
        "quantity": quantity,
        "category": category,
        "Date": date,
    };
}
