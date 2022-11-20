import 'package:flutter/material.dart';

class Products {
  final int id;
  final String title, image;

  Products({required this.id, required this.title, required this.image});
}

// list of products
// for our demo
List<Products> products = [
  Products(
    id: 1,
    title: "Ask For Donation",
    image: "assets/remove.png",
   
   
  ),
  Products(
    id: 4,
    title: "Accept Donation",
    image: "assets/accept.png",
    ),
  Products(
    id: 9,
    title: "Distributed Donation",
    image: "assets/record.png",
  
  ),
   Products(
    id: 9,
    title: "WareHouse Storage",
    image: "assets/storages.png",
  
  ),
   Products(
    id: 9,
    title: "Predicted Donations",
    image: "assets/predict.png",
  
  ),
   Products(
    id: 9,
    title: "Donation Records",
    image: "assets/rec.png",
  
  ),
  
];