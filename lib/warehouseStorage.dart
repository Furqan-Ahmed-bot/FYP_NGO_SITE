// ignore_for_file: file_names, unnecessary_string_interpolations, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import './donationHistory.dart';
import './headingWidget.dart';
import 'Services/donationServices.dart';

class WarehouseStorage extends StatefulWidget {
  //List<DonationData> donations;
  final storage;
  final ngo_id;
  WarehouseStorage(this.storage, this.ngo_id);

  @override
  State<WarehouseStorage> createState() => _WarehouseStorageState();
}

class _WarehouseStorageState extends State<WarehouseStorage> {
  @override
  Widget build(BuildContext context) {
    int storage = int.parse(widget.storage);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeadingWidget('Warehouse Storage'),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: Colors.white,
              child: Center(
                  child: storage > 10 && storage < 50
                      ? Text(
                          'Available Storage\n ${widget.storage} kg',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 32,
                             ),
                        )
                      : storage > 50
                          ? Text(
                              'Available Storage\n ${widget.storage} kg',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 32,
                                  color: Colors.green),
                            )
                          : Text(
                              'Available Storage\n 50 kg',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 32,
                                  color: Colors.red),
                            )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.all(0),
              child: const Text('Records',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  )),
            ),
            // Divider(),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: DonartionHistory(widget.ngo_id, 1),
            ),
          ],
        ),
      ),
    );
  }
}
