// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'Ngo_Home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  final ngoName;
  final currentPassword;
  final email;
  final storage;
  final ngo_Id;
  final image;
  final fow;
  ChangePassword(this.ngoName, this.currentPassword, this.email, this.storage,
      this.ngo_Id, this.image, this.fow);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

TextEditingController currentpassword = TextEditingController();
TextEditingController newPass = TextEditingController();

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: WillPopScope(
          onWillPop: () async => false,
          child: Center(
            
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Change Password" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),
                ),
                Container(
                  
                  margin: EdgeInsets.only(top: 30),
                  width: 300,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: currentpassword,
                        decoration: InputDecoration(
                          hintText: "Current Password",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: newPass,
                        decoration: InputDecoration(hintText: "New Password"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: " Re enter New Password"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          
                          child: Text("Update" , style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            changePass();
                          },
                        ),
                      ),
                      // Text(widget.email),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future changePass() async {
    String url = 'https://edonations.000webhostapp.com/api-changePassword.php';
    var data = {'email': widget.email, 'password': newPass.text};
    //var msg = jsonDecode(result.body);
    if (widget.currentPassword == currentpassword.text) {
      var result = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (result.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Ngo_Home(widget.ngoName, widget.storage,
                widget.ngo_Id, widget, widget.email, widget.fow)));
      } else {
        SnackBar(content: Text('Please Enter Correct Current Password'));
      }
    }
  }
}
