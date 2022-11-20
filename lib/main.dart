import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ngo_site/Ngo_Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'NGO_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var ngo_Id = preferences.getString('ngo_id');
  var email = preferences.getString('email');
  var address = preferences.getString('address');
  var ngo_name = preferences.getString('ngo_name');
  var contact = preferences.getString('contact');
  var password = preferences.getString('password');
  var description = preferences.getString('description');
  var storage = preferences.getString('storage');
  var fow = preferences.getString('field_of_work');
  var image = preferences.getString('image');
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/login': (context) => Login(),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFFFF7643),
        secondary: const Color(0xFFFF7643),

        // or from RGB
      ),
    ),
    home: email == null
        ? Home()
        : DonorAppBar(ngo_Id, address, ngo_name, contact, email, storage,
            password, description, image, fow),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
