import 'dart:convert';
import 'headingwidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Login.dart';

class DonationDistribution extends StatefulWidget {
  final ngoId;
  final fow;
  DonationDistribution(this.ngoId, this.fow);
  @override
  State<DonationDistribution> createState() => _SignUpState();
}

class _SignUpState extends State<DonationDistribution> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController donationQuantity = TextEditingController();
  String? _mySelection;

  List donations = [];

  Future<String> getSWData() async {
    String url = 'https://edonations.000webhostapp.com/ngo-donationhistory.php';
    var data = {'ngo_id': widget.ngoId};
    var res = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: {'Accept': "application/json"});

    var resBody = json.decode(res.body);

    setState(() {
      donations = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.05;
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeadingWidget('Donation Distribution'),
            Divider(),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: firstname,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFFF7643),
                          filled: true,
                          hintText: ('First Name'),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    SizedBox(height: height),
                    TextFormField(
                      controller: lastname,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFFF7643),
                          filled: true,
                          hintText: ('Last Name'),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    SizedBox(height: height),
                    TextFormField(
                      controller: cnic,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFFF7643),
                          filled: true,
                          hintText: ('CNIC'),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    SizedBox(height: height),
                    TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFFF7643),
                          filled: true,
                          hintText: ('Address'),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    SizedBox(height: height),
                    TextFormField(
                      controller: contact,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFFF7643),
                          filled: true,
                          hintText: ('Contact Number'),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    SizedBox(
                      height: height,
                    ),
                    DonationList(),
                    SizedBox(height: height),
                    TextFormField(
                      controller: donationQuantity,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFFF7643),
                          filled: true,
                          hintText: ('Quantity'),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    SizedBox(
                      height: height,
                    ),

                     Container(
            
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                
                child: const Text(
                  'Donate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  
                  ),
                ),
                onPressed: () {
                  register();
                },
              ),
            ),
                  ],
                ),
              ),
            ),
           
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
  String date='${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  Future register() async {
    String url = 'https://edonations.000webhostapp.com/api-dist_Donation.php';
    var data = {
      'donation_id': _mySelection,
      'ngo_id': widget.ngoId,
      'firstname': firstname.text,
      'lastname': lastname.text,
      'cnic': cnic.text,
      'address': address.text,
      'contact': contact.text,
      'quantity': int.parse(donationQuantity.text),
      'category': widget.fow,
      'date': date

    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    //var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Can not register')));
    }
  }

  Widget DonationList() {
    return DropdownButton<String>(
      hint: Text('Select Donation'),
      items: donations.map((item) {
        return DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['name'],
              ),
              Text(
                'Quantity = ${item['quantity']}',
              ),
            ],
          ),
          value: item['donationId'].toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _mySelection = val.toString();
        });
        print(_mySelection);
      },
      value: _mySelection,
    );
  }
}
