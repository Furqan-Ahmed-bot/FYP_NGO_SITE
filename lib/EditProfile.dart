// ignore_for_file: deprecated_member_use, file_names, prefer_const_constructors, unused_label, curly_braces_in_flow_control_structures, unnecessary_null_comparison

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'NGO_dashboard.dart';

Future<String> pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? _imagePicker =
      await _picker.pickImage(source: ImageSource.gallery);
  if (_imagePicker != null) {
    // Now we're converting our image into Uint8List
    Uint8List bytes = await _imagePicker.readAsBytes();

    // Here we're converting our image to Base64
    String encode = base64Encode(bytes);

    // Returning Base64 Encoded Image
    return encode;
  } else {
    if (kDebugMode) {
      print('Pick Image First');
    }
    return 'Error';
  }
}

class EditProfile extends StatefulWidget {
  final ngoId;
  final username;
  final address;
  final contact;
  final email;
  final desc;
  final image;
  const EditProfile(this.ngoId, this.address, this.username, this.contact,
      this.email, this.desc, this.image);

  @override
  _EditProfileState createState() => _EditProfileState();
}

// late final username;
// late final contact;

class _EditProfileState extends State<EditProfile> {
  String localimage = "";
  TextEditingController usernamee = TextEditingController();
  TextEditingController contactt = TextEditingController();
  TextEditingController addresss = TextEditingController();
  TextEditingController description = TextEditingController();
  bool showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localimage = widget.image;
    print(localimage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async=> false,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Stack(
                    children: [
                      localimage.isNotEmpty
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  MemoryImage(base64Decode(localimage)),
                            )
                          : const CircleAvatar(
                              radius: 50,
                            ),
                      // Container(
                      //   width: 130,
                      //   height: 130,
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //           width: 4,
                      //           color: Theme.of(context).scaffoldBackgroundColor),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             spreadRadius: 2,
                      //             blurRadius: 10,
                      //             color: Colors.black.withOpacity(0.1),
                      //             offset: Offset(0, 10))
                      //       ],
                      //       shape: BoxShape.circle,
                      //       image: DecorationImage(
                      //           fit: BoxFit.cover,
                      //           image: NetworkImage(
                      //             "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                      //           ))),
                      // ),
                      InkWell(
                        onTap: () {
                          chooseImage();
                        },
                        child: Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Color(0xFFFF7643),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                buildTextField("Full Name", widget.username, false, usernamee),
                SizedBox(
                  height: 25,
                ),
                buildTextField("Address", widget.address, false, addresss),
                SizedBox(
                  height: 25,
                ),
                buildTextField("Contact", widget.contact, true, contactt),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1, //Normal textInputField will be displayed
                  maxLines: 10, // when user presses enter it will adapt to it
                  controller: description,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'Description',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.desc,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updatedata();
                      },
                      // color: Color(0xFFFF7643),
                      // padding: EdgeInsets.symmetric(horizontal: 50),
                      // elevation: 2,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      // color: Color(0xFFFF7643),
                      // padding: EdgeInsets.symmetric(horizontal: 50),
                      // elevation: 2,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController ctrl) {
    return TextField(
      obscureText: isPasswordTextField ? showPassword : false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      controller: ctrl,
    );
  }

  Future updatedata() async {
    String url = 'https://edonations.000webhostapp.com/api-updatengo.php';
    var data = {
      'ngo_name': usernamee.text == "" ? widget.username : usernamee.text,
      'address': addresss.text == "" ? widget.address : addresss.text,
      'contact': contactt.text == "" ? widget.contact : contactt.text,
      'description': description.text == "" ? widget.address : description.text,
      'email': widget.email,
      'image': localimage
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg[0] != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DonorAppBar(
                int.parse(msg[0]['ngo_id']),
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
      SnackBar(content: Text('Not Registered!'));
    }
  }

  void chooseImage() async {
    localimage = await pickImage();
    setState(() {});
    if (localimage != null)
      image:
      localimage;
    // password: password.text,
    // fullname: fullName.text,
    // username: username.text,
  }
}
