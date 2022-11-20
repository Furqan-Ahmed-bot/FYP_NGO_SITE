// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ngo_site/barchart.dart';
import 'package:ngo_site/headingWidget.dart';

class Prediction extends StatefulWidget {
  final ngo_id;
  Prediction(this.ngo_id);
  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  String? data;
  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        data = value.toString();
        print(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        
        children: [
          HeadingWidget('Predicted Donations'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Predicted Value' ,),
          ),
          SizedBox(height: 30,),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: data == null
                ? Text(
                    'waiting for data to load...',
                    textAlign: TextAlign.center,
                  )
                : BarChartAPI(ngoId: widget.ngo_id, val: data),
          ),
          Center(
            child: data != null ? Text('Predicted Amount: ${data!}') : Text('reload to get data'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Text('Donation HIstory'),
          SizedBox(height: 20,),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: BarChartAPI(ngoId: widget.ngo_id),
          ),
        ],
      ),
    );
  }

  Future getData() async {
    String input =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    String url = 'http://192.168.100.13:5000/predict?a=$input';

    var result = await http.get(Uri.parse(url));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg != null) {
        return msg;
      }
    } else {
      SnackBar(content: Text('Invalid Username or Password!'));
    }
  }
}
