// // ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_const_constructors_in_immutables, unnecessary_new

// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'dart:convert';
import 'package:flutter/material.dart';
import './headingWidget.dart';
import 'package:http/http.dart' as http;

import 'models/ngoDonations.dart';

// ignore: must_be_immutable
class AcceptDonation extends StatefulWidget {
  final ngoId;
  int storage;
  final fow;
  final ngoname;
  AcceptDonation(this.ngoId, this.storage,this.fow,this.ngoname);
  @override
  _AcceptDonationState createState() => _AcceptDonationState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _AcceptDonationState extends State<AcceptDonation> {
  
  List<NgoDonations> ngodonation = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          HeadingWidget('Accept Donations'),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: const Text(
              'Pending Donations',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.79,
            margin: const EdgeInsets.only(top: 10),
            child: FutureBuilder<List<NgoDonations>>(
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
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: snapshot
                                                          .data![index].image ==
                                                      "abcd"
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.28,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.28,
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: AssetImage(
                                                                'assets/default.png')),
                                                      ),
                                                    )
                                                  : Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.28,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.28,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: MemoryImage(
                                                                base64Decode(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .image))),
                                                      ),
                                                    ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 30, 0, 0),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].name,
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
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'From ${snapshot.data![index].username} on ${snapshot.data![index].date} \n'
                                                          'Address: ${snapshot.data![index].address}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black
                                                          ),
                                                        ),
                                                        
                                                      ],
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
                                                        'Pending',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.red),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () {
                                       if(widget.fow=='food'){
                                          delDonation(
                                            snapshot
                                                .data![index].donationId).then((_) {
                                                  sendNotification(snapshot.data![index].fcm ,  'E-Donation','${snapshot.data![index].name} rejected by ${widget.ngoname}').then((_) {
                                                    setState(() {
                                                      
                                                    });
                                                  });
                                                  
                                                });

                                        }
                                        else {if(widget.fow=='clothes'){
                                          delClothDonation(
                                            snapshot
                                                .data![index].donationId).then((_) {
                                                  sendNotification(snapshot.data![index].fcm ,  'E-Donation','${snapshot.data![index].name} rejected by ${widget.ngoname}').then((_) {
                                                    setState(() {
                                                      
                                                    });
                                                  });
                                                });
                                        }
                                        else{
                                          delBookDonation(
                                            snapshot
                                                .data![index].donationId).then((_) {
                                                  sendNotification(snapshot.data![index].fcm , 'E-Donation','${snapshot.data![index].name} rejected by ${widget.ngoname}').then((_){
                                                    setState(() {
                                                      
                                                    });
                                                  });
                                                });
                                        }
                                        
                                        }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.done_outlined),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                        Text(
                                          'Reject',
                                          style: TextStyle(
                                              fontFamily: 'Quicksand',
                                              fontSize: 16),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    onPressed: () {
                                      if ((widget.storage -int.parse(snapshot
                                                .data![index].quantity))> 0) {
                                        if(widget.fow=='food'){
                                          accpetDonation(
                                            snapshot
                                                .data![index].donationId,
                                            snapshot
                                                .data![index].quantity).then((_) {
                                                  sendNotification(snapshot.data![index].fcm , 'E-Donation','${snapshot.data![index].name} accepted by ${widget.ngoname}').then((_) {
                                                    setState(() {
                                                      
                                                    });
                                                  });
                                                  
                                                });

                                        }
                                        else {if(widget.fow=='clothes'){
                                          accpetClothesDonation(
                                            snapshot
                                                .data![index].donationId,
                                            snapshot
                                                .data![index].quantity).then((_) {
                                                  sendNotification(snapshot.data![index].fcm , 'E-Donation','${snapshot.data![index].name} accepted by ${widget.ngoname}').then((_) {
                                                    setState(() {
                                                      
                                                    });
                                                  });
                                                });
                                        }
                                        else{
                                          accpetBookDonation(
                                            snapshot
                                                .data![index].donationId,
                                            snapshot
                                                .data![index].quantity).then((_) {
                                                  sendNotification(snapshot.data![index].fcm , 'E-Donation','${snapshot.data![index].name} accepted by ${widget.ngoname}').then((_){
                                                    setState(() {
                                                      
                                                    });
                                                  });
                                                });
                                        }
                                        
                                        }
                                                
                                      } 
                                      else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Insufficient storage!')));
                                      }
                                      
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.done_outlined),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                        Text(
                                          'Accept',
                                          style: TextStyle(
                                              fontFamily: 'Quicksand',
                                              fontSize: 16),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
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
    );
  }

  Future accpetDonation(String donationId, String quantity) async {
    print(donationId);
    print(quantity);
    print(widget.ngoId);
    String url = 'https://edonations.000webhostapp.com/api-acceptdonation.php';
    var data = {
      'donation_id': donationId,
      'quantity': quantity,
      'ngo_id': widget.ngoId
    };

      var result = await http.post(Uri.parse(url), body: jsonEncode(data));
      var msg = jsonDecode(result.body);
      if (msg['message'] == "record updated successfully") {
        final snackBar = SnackBar(content: Text('Confirmed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Not Confirmed')));
      }
  }
  Future accpetClothesDonation(String donationId, String quantity) async {
    print(donationId);
    print(quantity);
    print(widget.ngoId);
    String url = 'https://edonations.000webhostapp.com/api-acceptdonation.php';
    var data = {
      'donation_id': donationId,
      'quantity': quantity,
      'ngo_id': widget.ngoId
    };

      var result = await http.post(Uri.parse(url), body: jsonEncode(data));
      var msg = jsonDecode(result.body);
      if (msg['message'] == "record updated successfully") {
        final snackBar = SnackBar(content: Text('Confirmed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Not Confirmed')));
      }
  }
  Future accpetBookDonation(String donationId, String quantity) async {
    print(donationId);
    print(quantity);
    print(widget.ngoId);
    String url = 'https://edonations.000webhostapp.com/api-acceptdonation.php';
    var data = {
      'donation_id': donationId,
      'quantity': quantity,
      'ngo_id': widget.ngoId
    };

      var result = await http.post(Uri.parse(url), body: jsonEncode(data));
      var msg = jsonDecode(result.body);
      if (msg['message'] == "record updated successfully") {
        final snackBar = SnackBar(content: Text('Confirmed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Not Confirmed')));
      }
  }

  Future delDonation(final donationId) async {
    String url = 'https://edonations.000webhostapp.com/api-deleteDonation.php';
    var data = {'donation_id': donationId};
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Deleted!'),
      ));
    } else {
      SnackBar(content: Text('Not deleted'));
    }
  }
    Future delBookDonation(final donationId) async {
    String url = 'https://edonations.000webhostapp.com/api-deleteBookDonation.php';
    var data = {'donation_id': donationId};
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Deleted!'),
      ));
    } else {
      SnackBar(content: Text('Not deleted'));
    }
  }  
  Future delClothDonation(final donationId) async {
    String url = 'https://edonations.000webhostapp.com/api-deleteClothesDonation.php';
    var data = {'donation_id': donationId};
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Deleted!'),
      ));
    } else {
      SnackBar(content: Text('Not deleted'));
    }
  }

  Future<List<NgoDonations>> fetchDonations() async {
    const String url =
        'https://edonations.000webhostapp.com/api-pendingdonations.php';
    var data = {'ngo_id': widget.ngoId};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));

    if (result.statusCode == 200) {
      final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
      return parsed
          .map<NgoDonations>((json) => NgoDonations.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future sendNotification(String fcm,String msg , String body)async{
    String url = 'https://edonations.000webhostapp.com/notify-ngo.php';
    var data = {
      'title':msg,
      'fcmtoken': fcm,
      'body': body,
    };
    var result = await http.post(Uri.parse(url) , body: jsonEncode(data));
    var msg1=jsonDecode(result.body);
    if (msg1['success']==1) {
      print('success');
    }

  }
}
