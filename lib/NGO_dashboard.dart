// ignore_for_file: prefer_const_constructors, file_names, unused_import, prefer_typing_uninitialized_variables

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ngo_site/Login.dart';
import 'package:ngo_site/distDonationHistory.dart';
import 'package:ngo_site/prediction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/donationServices.dart';
import 'donationHistory.dart';
import 'my_drawer_header.dart';
import 'notification.dart';
import 'Ngo_Home.dart';
import 'EditProfile.dart';

class DonorAppBar extends StatefulWidget {
  final storage;
  final username;
  final address;
  final contact;
  final email;
  final description;
  final password;
  final ngo_Id;
  final image;
  final fow;
  DonorAppBar(
      this.ngo_Id,
      this.address,
      this.username,
      this.contact,
      this.email,
      this.storage,
      this.password,
      this.description,
      this.image,
      this.fow);
  @override
  _DonorAppBar createState() => _DonorAppBar();
}

int ngoId = 0;

class _DonorAppBar extends State<DonorAppBar> {
  void setState(VoidCallback fn) {
    ngoId = int.parse(widget.ngo_Id);
    // TODO: implement setState
    super.setState(fn);
    Ngo_Home(widget.username, widget.storage, widget.ngo_Id, widget.image,
        widget.email, widget.fow);
  }

  var currentPage = DrawerSections.Ngo_Home;

  @override
  Widget build(BuildContext context) {
    // int ngoId = int.parse(widget.ngo_Id);
    var container;
    if (currentPage == DrawerSections.Ngo_Home) {
      container = Ngo_Home(widget.username, widget.storage, widget.ngo_Id,
          widget.image, widget.email, widget.fow);
    } else if (currentPage == DrawerSections.home) {
      container = Ngo_Home(widget.username, widget.storage, widget.ngo_Id,
          widget.image, widget.email, widget.fow);
    } else if (currentPage == DrawerSections.myprofile) {
      container = EditProfile(widget.ngo_Id, widget.address, widget.username,
          widget.contact, widget.email, widget.description, widget.image);
    } 
    else if (currentPage == DrawerSections.dist_donation) {
      container = DistDonation(widget.ngo_Id, widget.fow, widget.username);
    }
    else if (currentPage == DrawerSections.settings) {
      container = ChangePassword(widget.username, widget.password, widget.email,
          widget.storage, widget.ngo_Id, widget.image, widget.fow);
      }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFF7643),
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text('NGOs Dashboard'),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(widget.email, widget.username, widget.image),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 15,
          ),
          child: Column(
            // shows the list of menu drawer
            children: [
              menuItem(1, "Home", Icons.home,
                  currentPage == DrawerSections.myprofile ? true : false),
              menuItem(2, "My Profile", Icons.image,
                  currentPage == DrawerSections.myprofile ? true : false),
              menuItem(3, "Distributed Donations", Icons.shopping_cart,
                  currentPage == DrawerSections.dist_donation ? true : false),
              menuItem(4, "Settings", Icons.online_prediction,
                  currentPage == DrawerSections.settings ? true : false),
              logout('Logout', Icons.logout)
            ],
          ),
        ),
        // logoutbutton("Logout", Icons.logout),
        // Container(
        //   margin: EdgeInsets.only(top: 50),
        //   child: RaisedButton.icon(
        //       onPressed: () {
        //         Navigator.push(
        //             context, MaterialPageRoute(builder: (context) => Login()));
        //       },
        //       icon: Icon(Icons.logout),
        //       label: Text('Logout')),
        // )
      ],
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.myprofile;
            } else if (id == 3) {
              currentPage = DrawerSections.dist_donation;
            } else if (id == 4) {
              currentPage = DrawerSections.settings;
            } 
            
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logout(String title, IconData icon) {
    return Material(
      child: InkWell(
        onTap: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Login()),
              ModalRoute.withName('/login'));
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget logoutbutton(String title, IconData icon) {
  //   return Container(child: InkWell(
  //     onTap: () {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Login()));
  //     },
  //   ));
  // }
}

enum DrawerSections {
  home,
  myprofile,
  settings,
  notifications,
  notes,
  Ngo_Home,
  dist_donation,
}
