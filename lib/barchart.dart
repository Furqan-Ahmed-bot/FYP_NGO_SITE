// import 'package:chartapp/network/network_helper.dart';
// import 'package:chartapp/src/Bar_Chart/bar_model.dart';
// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ngo_site/prediction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/donationsModel.dart';
import 'package:http/http.dart' as http;

class BarChartAPI extends StatefulWidget {
  int ngoId;
  final val;
  BarChartAPI({required this.ngoId, this.val});

  @override
  State<BarChartAPI> createState() => _BarChartAPIState();
}

var _tooltipBehavior;

class _BarChartAPIState extends State<BarChartAPI> {
  List<Donations> genders = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData().whenComplete(() {
      if (widget.val != null) {
        DateTime now = DateTime.now();
        DateTime currentTime = DateTime(now.year, now.month, now.day);
        genders.add(Donations(
            username: '',
            name: '',
            quantity: widget.val.toString(),
            date: 'Predicted Donation',
            donationId: '',
            image: ''));
      }
    });

    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  Future getData() async {
    const String url =
        'https://edonations.000webhostapp.com/ngo-donationhistory.php';
    var data = {'ngo_id': widget.ngoId};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));

    List<Donations> tempdata = donationsFromJson(result.body);
    setState(() {
      genders = tempdata;
      loading = false;
    });
  }

  _createSampleData() {
    return SfCartesianChart(
        backgroundColor: Colors.white,
        // Enables the tooltip for all the series in chart
        tooltipBehavior: _tooltipBehavior,
        // Initialize category axis
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          // Initialize line series

          LineSeries<Donations, String>(
              // Enables the tooltip for individual series
              enableTooltip: true,
              dataSource: genders,
              xValueMapper: (Donations sales, _) => sales.date.toString(),
              yValueMapper: (Donations sales, _) =>
                  double.parse("${sales.quantity}"),
              animationDuration: 2000,
              color: Colors.orange),
        ]);
    // [
    //   charts.Series<Donations, String>(
    //     data: genders,
    //     id: 'sales',
    //     colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
    //     domainFn: (Donations genderModel, _) => genderModel.name,
    //     measureFn: (Donations genderModel, _) =>
    //         int.parse(genderModel.quantity),
    //   )
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: _createSampleData(),
              ),
      ),
    );
  }
}
