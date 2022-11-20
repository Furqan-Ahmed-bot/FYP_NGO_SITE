// ignore_for_file: file_names, prefer_const_constructors, unused_import, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:ngo_site/confirmdonation.dart';
import 'package:ngo_site/dashboard/list.dart';
import 'package:ngo_site/dashboard/product.dart';
import 'package:ngo_site/donationDistribution.dart';
import 'package:ngo_site/prediction.dart';
import 'package:ngo_site/volunteer_reg.dart';
import './donationRequest.dart';
import './donationHistory.dart';
import 'package:flutter/material.dart';
import './alertPopup.dart';
import './warehouseStorage.dart';

class Ngo_Home extends StatefulWidget {
  final ngoName;
  final storage;
  final ngo_Id;
  final image;
  final email;
  final fow;
  Ngo_Home(this.ngoName, this.storage, this.ngo_Id, this.image, this.email,
      this.fow);
  @override
  State<Ngo_Home> createState() => Ngo_HomeState();
}

class Ngo_HomeState extends State<Ngo_Home> {
  String localimage = '';
  @override
  void initstate() {
    super.initState();
    setState(() {
      localimage = widget.image;
    });
    print(localimage);
  }

  DateTime pre_backpress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    List nav = [
      FirstPage(),
      AcceptDonation(widget.ngo_Id, int.parse(widget.storage),widget.fow,widget.ngoName),
      DonationDistribution(widget.ngo_Id, widget.fow),
      WarehouseStorage(widget.storage, widget.ngo_Id),
      Prediction(int.parse(widget.ngo_Id)),
      DonartionHistory(int.parse(widget.ngo_Id), 0)
    ];
    List<String> fow = ['food', 'clothes', 'books'];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFF7643),
      //   appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Color(0xFFFF7643),
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 50),
      //     child: Text('Donors Dashboard'),
      //   ),
      // ),

      body: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            final snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            exit(0);
          }
        },
        child: Column(
          children: [
            Center(
              child: Container(
                height: height * 0.16,
                width: width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.1),
                      child: Text(
                        '${widget.ngoName}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.2,
                    ),
                    CircleAvatar(
                      maxRadius: height * 0.045,
                      child: CircleAvatar(
                        maxRadius: height * 0.045,
                        backgroundImage:
                            MemoryImage(base64Decode(widget.image)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.04),
              child: Text(
                'Welcome To E-Donation App',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(
              height: height * 0.05,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height * 0.1),
                    decoration: BoxDecoration(
                        color: Color(0xFFF1EFF1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(width * 0.1),
                          topRight: Radius.circular(width * 0.1),
                          // bottomLeft: Radius.circular(30),
                          // bottomRight: Radius.circular(30),
                        )),
                  ),
                  ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) => Product(
                      itemIndex: index,
                      product: products[index],
                      nav: nav,
                      ngoId: widget.ngo_Id,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}
