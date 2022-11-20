// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ngo_site/confirmdonation.dart';
import 'package:ngo_site/donationRequest.dart';
import 'list.dart';
import 'package:http/http.dart' as http;

class Product extends StatefulWidget {
  const Product({
    Key? key,
    required this.itemIndex,
    required this.product,
    // required this.fow,
    required this.ngoId,
    required this.nav,
  }) : super(key: key);

  final int itemIndex;
  final Products product;
  // final String fow;
  // final int donorId;
  final ngoId;
  final List nav;
  @override
  State<Product> createState() => _ProductState();
}
int countDonation=0;
int countPendings=0;
class _ProductState extends State<Product> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countdonations().then((value) {
setState(() {
  countDonation=value;
});
    });
    countpendings().then((value) {
setState(() {
  countPendings=value;
});
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: width * 0.009,
      ),
      // color: Colors.blueAccent,
      height: height * 0.186,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => widget.nav[widget.itemIndex]));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: height * 0.135,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.05),
                color: Colors.orange.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, width * 0.05),
                    blurRadius: width * 0.05,
                    color: Colors.black12, // Black color with 12% opacity
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(right: width * 0.025),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.05),
                ),
              ),
            ),
            // our product image
            Positioned(
                top: height * 0.01,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(width*0.1,0,0,0),
                  height: height * 0.14,
                  width: width * 0.44,
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                )),
            // Product title and price
            Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  height: height * 0.155,
                  width: width * 0.7,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(width * 0.05, width * 0.15,
                        width * 0.05, width * 0.01),
                    // ignore: prefer_const_constructors
                    child: Column(
                      children: [
                        Text(
                          widget.product.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: height*0.007),
                        Text(
                          widget.itemIndex==1? 'Total: ${countDonation.toString()}':widget.itemIndex==5?'Total: ${countPendings.toString()}':"",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
  Future countpendings() async{
    String url = 'https://edonations.000webhostapp.com/api-ngoDonationCount.php';
    var data = {
      'ngo_id': widget.ngoId
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
        return msg['count'];
      
    } 
  }
  Future countdonations() async{
    String url = 'https://edonations.000webhostapp.com/api-ngoPendingDonationCount.php';
    var data = {
      'ngo_id': widget.ngoId
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
        return msg['count'];
      
    } 
  }
}
