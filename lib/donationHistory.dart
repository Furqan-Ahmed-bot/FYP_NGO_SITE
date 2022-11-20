// ignore_for_file: file_names, prefer_const_constructors, unused_import

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ngo_site/models/ngoDonations.dart';
import '../Services/donationServices.dart';
import './barchart.dart';
import './headingWidget.dart';
import './main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'models/donationsModel.dart';
import 'models/ngoModel.dart';

// ignore: must_be_immutable
class DonartionHistory extends StatefulWidget {
  final donorId;
  final flag;
  DonartionHistory(this.donorId, this.flag);
  //DonartionHistory(this.donations);
  @override
  _DonartionHistoryState createState() => _DonartionHistoryState();
}

late TooltipBehavior _tooltipBehavior;

class _DonartionHistoryState extends State<DonartionHistory> {
  final List data = [];
  List<NgoDonations> ngodonation = [];
  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    //_fetchNgoName(1);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
       
        body: SingleChildScrollView(
          child: Column(
            children: [
              
              widget.flag == 0

                  ? HeadingWidget('Donation Records'):widget.flag == 0?
                  Container(
                    
                      margin: EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Text(
                        'Donation History',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ))
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              widget.flag == 0
                  ? Divider()
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              widget.flag == 0
                  ? Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: BarChartAPI(
                          ngoId: widget.donorId,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              Container(
                height: MediaQuery.of(context).size.height * 0.63,
                margin: const EdgeInsets.only(top: 10),
                child: FutureBuilder<List<NgoDonations>>(
                  future: fetchDonations(http.Client()),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 5),
                                elevation: 1.0,
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                        shadowColor: Color(0xFFFF7643),
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
                                              padding: const EdgeInsets.all(2.0),
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
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 30, 0, 0),
                                                    child: Text(
                                                      snapshot.data![index].name,
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
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            5, 10, 0, 0),
                                                    child: Text(
                                                      'From ${snapshot.data![index].username} on ${snapshot.data![index].date}',
                                                      style: TextStyle(
                                                        fontSize: 14,
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
                                                        height:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.01,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))));
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
      ),
    );
  }

  Future<List<NgoDonations>> fetchDonations(http.Client client) async {
    const String url =
        'https://edonations.000webhostapp.com/ngo-donationhistory.php';
    var data = {'ngo_id': widget.donorId};

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
}
