// // ignore_for_file: deprecated_member_use, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'NGO_dashboard.dart';
// import 'main.dart';
// import 'package:http/http.dart' as http;

// class Login extends StatefulWidget {
//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final emailController = TextEditingController();
//   final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

//   final passwordController = TextEditingController();

//   @override
//   static String p =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   static RegExp regExp = new RegExp(p);
//   void vaildation() {
//     if (emailController.text.isEmpty && passwordController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Both Fleid Is Empty"),
//         ),
//       );
//     } else if (emailController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Email Is Empty"),
//         ),
//       );
//     } else if (!regExp.hasMatch(emailController.text)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Email Is Not Vaild"),
//         ),
//       );
//     } else if (passwordController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Password Is Empty"),
//         ),
//       );
//     } else if (passwordController.text.length < 8) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Password Is Too Short"),
//         ),
//       );
//     } else {
//       LoginUser();
//     }
//   }

//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
//                   height: height * 0.4,
//                   width: width * 0.7,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Login',
//                         style: TextStyle(
//                           color: Color(0xFFFF7643),
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Welcome Back!',
//                         style: TextStyle(
//                           color: Color(0xFFFF7643),
//                           fontSize: 25,
//                         ),
//                       ),
//                       Center(
//                         child: Container(
//                           margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                           height: height * 0.25,
//                           width: width * 0.5,
//                           child: Image(
//                             image: AssetImage(
//                               'assets/1.png',
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Center(
//                   child: Container(
//                     height: height * 0.22,
//                     width: width * 0.8,
//                     child: Column(
//                       children: [
//                         // TextFormField(
//                         //   style: TextStyle(color: Colors.white),
//                         //   controller: emailController,
//                         //   decoration: InputDecoration(
//                         //       fillColor: Colors.blue[800],
//                         //       filled: true,
//                         //       prefixIcon: Icon(
//                         //         Icons.email,
//                         //         color: Colors.white,
//                         //       ),
//                         //       hintText: ('Email'),
//                         //       hintStyle: TextStyle(color: Colors.white),
//                         //       border: OutlineInputBorder(
//                         //         borderRadius: BorderRadius.circular(10),
//                         //         borderSide: BorderSide.none,
//                         //       )),
//                         // ),

//                         TextFormField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                               labelText: "Email",
//                               hintText: "Enter Your Email",
//                               floatingLabelBehavior:
//                                   FloatingLabelBehavior.always,
//                               suffixIcon: Padding(
//                                 padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
//                                 child: Icon(
//                                   Icons.email,
//                                 ),
//                               ),
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 42, vertical: 20),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(28),
//                                   borderSide: BorderSide(color: Colors.black),
//                                   gapPadding: 10),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(28),
//                                 borderSide: BorderSide(color: Colors.black),
//                                 gapPadding: 10,
//                               )),
//                         ),
//                         SizedBox(height: height * 0.04),
//                         // TextFormField(
//                         //   style: TextStyle(color: Colors.white),
//                         //   controller: passwordController,
//                         //   obscureText: true,
//                         //   decoration: InputDecoration(
//                         //       fillColor: Colors.blue[800],
//                         //       filled: true,
//                         //       prefixIcon: Icon(
//                         //         Icons.remove_red_eye,
//                         //         color: Colors.white,
//                         //       ),
//                         //       hintText: ('Password'),
//                         //       hintStyle: TextStyle(color: Colors.white),
//                         //       border: OutlineInputBorder(
//                         //         borderRadius: BorderRadius.circular(10),
//                         //         borderSide: BorderSide.none,
//                         //       )),
//                         // ),
//                         TextFormField(
//                           controller: passwordController,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                               labelText: "Password",
//                               hintText: "Enter Your Password",
//                               floatingLabelBehavior:
//                                   FloatingLabelBehavior.always,
//                               suffixIcon: Padding(
//                                 padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
//                                 child: Icon(
//                                   Icons.password,
//                                 ),
//                               ),
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 42, vertical: 20),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(28),
//                                   borderSide: BorderSide(color: Colors.black),
//                                   gapPadding: 10),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(28),
//                                 borderSide: BorderSide(color: Colors.black),
//                                 gapPadding: 10,
//                               )),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Container(
//                 //   height: 50,
//                 //   width: 300,
//                 //   child: RaisedButton(
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //     ),
//                 //     color: Colors.blue[800],
//                 //     child: Text(
//                 //       'Login',
//                 //       style: TextStyle(
//                 //         color: Colors.white,
//                 //         fontSize: 20,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     ),
//                 //     onPressed: () {
//                 //       vaildation();
//                 //     },
//                 //   ),
//                 // ),

//                 Padding(
//                   padding: EdgeInsets.only(top: height * 0.05),
//                   child: Container(
//                     height: height * 0.07,
//                     width: width * 0.8,
//                     child: RaisedButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                       color: Color(0xFFFF7643),
//                       // ignore: prefer_const_constructors
//                       child: Text(
//                         'Login',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       onPressed: () {
//                         vaildation();
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future LoginUser() async {
//     String url = 'https://edonations.000webhostapp.com/api-login-ngo.php';
//     var data = {
//       'email': emailController.text,
//       'password': passwordController.text,
//     };
//     var result = await http.post(Uri.parse(url), body: jsonEncode(data));
//     var msg = jsonDecode(result.body);
//     if (result.statusCode == 200) {
//       if (msg[0] != null) {
//         SharedPreferences preferences = await SharedPreferences.getInstance();
//         preferences.setString('ngo_id', msg[0]['ngo_id']);
//         preferences.setString('email', emailController.text);
//         preferences.setString('address', msg[0]['address']);
//         preferences.setString('ngo_name', msg[0]['ngo_name']);
//         preferences.setString('contact', msg[0]['contact']);
//         preferences.setString('password', msg[0]['password']);
//         preferences.setString('description', msg[0]['description']);
//         preferences.setString('storage', msg[0]['storage']);
//         preferences.setString('field_of_work', msg[0]['field_of_work']);
//         preferences.setString('image', msg[0]['image']);

//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => DonorAppBar(
//                 msg[0]['ngo_id'],
//                 msg[0]['address'],
//                 msg[0]['ngo_name'],
//                 msg[0]['contact'],
//                 msg[0]['email'],
//                 msg[0]['storage'],
//                 msg[0]['password'],
//                 msg[0]['description'],
//                 msg[0]['image'],
//                 msg[0]['field_of_work'])));
//       }
//     } else {
//       SnackBar(content: Text('Invalid Username or Password!'));
//     }
//   }
// }

// ignore_for_file: deprecated_member_use, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NGO_dashboard.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? token1;
  bool ShowCircle = true;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token) {
      print("Token is" + token!);

      setState(() {
        token1 = token;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessaging_Listeners();
  }

  final emailController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  final passwordController = TextEditingController();

  @override
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);
  void vaildation() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Both Fleid Is Empty"),
        ),
      );
    } else if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email Is Not Vaild"),
        ),
      );
    } else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Is Too Short"),
        ),
      );
    } else {
      updatefcm().then((_) {
        LoginUser();
      });
    }
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                  height: height * 0.4,
                  width: width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFFFF7643),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Color(0xFFFF7643),
                          fontSize: 25,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          height: height * 0.25,
                          width: width * 0.5,
                          child: Image(
                            image: AssetImage(
                              'assets/1.png',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: height * 0.22,
                    width: width * 0.8,
                    child: Column(
                      children: [
                        // TextFormField(
                        //   style: TextStyle(color: Colors.white),
                        //   controller: emailController,
                        //   decoration: InputDecoration(
                        //       fillColor: Colors.blue[800],
                        //       filled: true,
                        //       prefixIcon: Icon(
                        //         Icons.email,
                        //         color: Colors.white,
                        //       ),
                        //       hintText: ('Email'),
                        //       hintStyle: TextStyle(color: Colors.white),
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide.none,
                        //       )),
                        // ),

                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Enter Your Email",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                child: Icon(
                                  Icons.email,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(color: Colors.black),
                                  gapPadding: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(color: Colors.black),
                                gapPadding: 10,
                              )),
                        ),
                        SizedBox(height: height * 0.04),
                        // TextFormField(
                        //   style: TextStyle(color: Colors.white),
                        //   controller: passwordController,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //       fillColor: Colors.blue[800],
                        //       filled: true,
                        //       prefixIcon: Icon(
                        //         Icons.remove_red_eye,
                        //         color: Colors.white,
                        //       ),
                        //       hintText: ('Password'),
                        //       hintStyle: TextStyle(color: Colors.white),
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide.none,
                        //       )),
                        // ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter Your Password",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                child: Icon(
                                  Icons.password,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(color: Colors.black),
                                  gapPadding: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(color: Colors.black),
                                gapPadding: 10,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   height: 50,
                //   width: 300,
                //   child: RaisedButton(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     color: Colors.blue[800],
                //     child: Text(
                //       'Login',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     onPressed: () {
                //       vaildation();
                //     },
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.8,
                    child: ElevatedButton(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(28),
                      // ),
                      // color: Color(0xFFFF7643),
                      // ignore: prefer_const_constructors
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        vaildation();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future LoginUser() async {
    String url = 'https://edonations.000webhostapp.com/api-login-ngo.php';
    var data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg[0] != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('ngo_id', msg[0]['ngo_id']);
        preferences.setString('email', emailController.text);
        preferences.setString('address', msg[0]['address']);
        preferences.setString('ngo_name', msg[0]['ngo_name']);
        preferences.setString('contact', msg[0]['contact']);
        preferences.setString('password', msg[0]['password']);
        preferences.setString('description', msg[0]['description']);
        preferences.setString('storage', msg[0]['storage']);
        preferences.setString('field_of_work', msg[0]['field_of_work']);
        preferences.setString('image', msg[0]['image']);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DonorAppBar(
                msg[0]['ngo_id'],
                msg[0]['address'],
                msg[0]['ngo_name'],
                msg[0]['contact'],
                msg[0]['email'],
                msg[0]['storage'],
                msg[0]['password'],
                msg[0]['description'],
                msg[0]['image'],
                msg[0]['field_of_work'])));
      }
    } else {
      SnackBar(content: Text('Invalid Username or Password!'));
    }
  }

  Future updatefcm() async {
    String url = 'https://edonations.000webhostapp.com/api-updateNgoFcm.php';
    var data = {
      'email': emailController.text,
      'fcm': token1,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg['status'] != false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('You logged in as ${emailController.text}')));
      }
    }
  }
}
