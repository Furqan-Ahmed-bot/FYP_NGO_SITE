// // ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_const_constructors_in_immutables, unnecessary_new

// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ngo_site/models/distdonationModel.dart';
import './headingWidget.dart';
import 'package:http/http.dart' as http;

import 'models/ngoDonations.dart';

// ignore: must_be_immutable
class DistDonation extends StatefulWidget {
  final ngoId;
  final fow;
  final ngoname;
  DistDonation(this.ngoId, this.fow,this.ngoname);
  @override
  _AcceptDonationState createState() => _AcceptDonationState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _AcceptDonationState extends State<DistDonation> {
  
  List<NgoDonations> ngodonation = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: WillPopScope(
        onWillPop: () async=> false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: const Text(
                'Donated Records',
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              margin: const EdgeInsets.only(top: 10),
              child: FutureBuilder<List<DistDonationModel>>(
                future: fetchDonations(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                  shadowColor: Color(0xFFFF7643),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  elevation: 1.0,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          color: Colors.white70,
                                          elevation: 10,
                                          child: Padding(
                                            padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,0,MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.width*0.05),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.5,
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .fromLTRB(10, 30, 0, 0),
                                                        child: Text('Name: ${snapshot.data![index].firstname} ${snapshot.data![index].lastname}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.5,
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .fromLTRB(5, 10, 0, 0),
                                                        child: Text(
                                                          'cnic ${snapshot.data![index].cnic} on ${snapshot.data![index].date} \n'
                                                          'Address: ${snapshot.data![index].address}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                          5, 40, 0, 0),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Quantity',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          Text(
                                                            snapshot.data![index]
                                                                .quantity,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01,
                                                          ),
                                                          Text(
                                                            'Donated',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors.green),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )))),
                            ],
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<List<DistDonationModel>> fetchDonations() async {
    const String url =
        'https://edonations.000webhostapp.com/api-getdistdonation.php';
    var data = {'ngo_id': widget.ngoId};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));

    if (result.statusCode == 200) {
      final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
      return parsed
          .map<DistDonationModel>((json) => DistDonationModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}

