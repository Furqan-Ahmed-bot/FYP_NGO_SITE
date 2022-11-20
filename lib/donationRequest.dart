// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import './donationHistory.dart';
// import './main.dart';
// import './headingWidget.dart';
// import 'NGO_dashboard.dart';

// class DonationRequest extends StatefulWidget {
//   @override
//   _DonationRequestState createState() => _DonationRequestState();
// }

// class _DonationRequestState extends State<DonationRequest> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(children: <Widget>[
//         HeadingWidget('Donation History'),
//         Container(
//           height: 400,
//           //child:
//           //ListView.builder(
//           // itemCount: donations.length,
//           // itemBuilder: (context, index) {
//           //   return Card(
//           //     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//           //     elevation: 1.0,
//           //     child: ListTile(
//           //       leading: Text('${(index + 1).toString()}',
//           //           style: TextStyle(
//           //             fontFamily: 'Quicksand',
//           //             fontSize: 20,
//           //           )),
//           //       title: Text(
//           //         donations[index].donationName,
//           //         style: TextStyle(
//           //           fontFamily: 'Quicksand',
//           //           fontSize: 20,
//           //         ),
//           //       ),
//           //       subtitle: Text('${donations[index].day}'),
//           //       trailing: Column(children: [
//           //         Text('Amount'),
//           //         Text('${donations[index].donationAmount}')
//           //       ]),
//           //     ),
//           //   );
//           //}
//           // ),
//         ),
//       ]),
//     );
//   }
// }

// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, unnecessary_null_comparison, non_constant_identifier_names, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, avoid_print

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController title = new TextEditingController();
  TextEditingController body = new TextEditingController();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? token1;

  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.subscribeToTopic('registeruser');
    _firebaseMessaging.getToken().then((token){

      print("Token is" +token!);
      print('title is $title');
      print(body);
      
      setState(() {
        token1 = token;
        
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7643),
        title: Text("Notification"),
        
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
           
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Push Notifications' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
              ),
              Container(child: Image(image: AssetImage('assets/push.png'), height: 200,),),
              SizedBox(height: 20,),
             Container(
               
                      height: 350,
                      width: 300,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            
                            
                            style: TextStyle(color: Colors.white),
                            controller: title,
                            decoration: InputDecoration(
                                fillColor: Color(0xFFFF7643),
                                filled: true,
                               
                                hintText: ('Title'),
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            
                            style: TextStyle(color: Colors.white),
                            controller: body,
                            
                            decoration: InputDecoration(
                                fillColor: Color(0xFFFF7643),
                                filled: true,
                                 
                                hintText: ('Note'),
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ],
                      ),
                    ),
                    
              
              ElevatedButton(
                onPressed: () => {
                  print(title),
                  print(body),
                //do something
                getQue(),
                },
                
                
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.notifications,color: Colors.white),
                    SizedBox(height: 10,),
                    Text("Send",style: TextStyle(
                        color: Colors.white
                    ),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField field( hintname, TextEditingController texteditingcontroller){
    return TextFormField(
      controller: texteditingcontroller,
      decoration: InputDecoration(
          fillColor: Color(0xff8CA1A5),
          filled: true,
          hintText: hintname,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )),
    );
  }
  
  Future getQue() async {
    print(token1);
    if(token1!=null){
      //call php file
      var data = {
      'fcmtoken': token1,
      'title': title.text,
      'body' : body.text
      };
      var senddata=jsonEncode(data);
      var response = await http.post(Uri.parse("https://edonations.000webhostapp.com/notifications_ngo.php"),
      body: senddata );
      print(response.body);
      return jsonDecode(response.body);
      
    }
    else{
      print("Token is null");
    }
  }
}
