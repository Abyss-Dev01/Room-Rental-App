import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:room_rental_app/screens/mainScreen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:room_rental_app/services/maps.dart';

class AddRoom extends StatefulWidget {
  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _price = TextEditingController();

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("rooms");

  String roomImageUrl = "";

  String roomId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  File _file;
  final picker = ImagePicker();

  Future captureImageWithCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(
      () {
        if (pickedFile != null) {
          _file = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      },
    );
  }

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(
      () {
        if (pickedFile != null) {
          _file = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      },
    );
  }

  _uploadImage(imgContext) {
    return showDialog(
      context: imgContext,
      builder: (cont) {
        return SimpleDialog(
          title: Text(
            "Room images",
            style: TextStyle(
              color: Colors.blue[400],
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                "Caputer with camera",
                style: TextStyle(
                  color: Colors.orange[300],
                  fontSize: 12,
                ),
              ),
              onPressed: captureImageWithCamera,
            ),
            SimpleDialogOption(
              child: Text(
                "Select from gallery",
                style: TextStyle(
                  color: Colors.orange[300],
                  fontSize: 12,
                ),
              ),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GenerateMaps>(context, listen: false).getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Room here"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () => _uploadImage(context),
                  child: Icon(Icons.add_a_photo),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: _file == null
                      ? Text('No image selected.')
                      : Image.file(_file),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formkey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                          hintText: "Enter Username here",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.person_outlined,
                            color: Colors.blue[200],
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter username";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Enter Phone number here",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: Colors.blue[200],
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 10 ||
                              value.length > 10) {
                            return "Invalid phone number";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _address,
                        decoration: InputDecoration(
                          hintText: "Enter Location here",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue[200],
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter location";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter Price here",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            color: Colors.blue[200],
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Price";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {},
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                        child: Text("Add"),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            await collectionReference.add(
                              {
                                'username': _username.text,
                                'phone': _phone.text.trim(),
                                'address': _address.text,
                                'price': _price.text.trim(),
                              },
                            );
                            final snackBar =
                                SnackBar(content: Text('Room added'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MainScreen(),
                              ),
                            );
                            print("Validated");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      _username.clear();
      _phone.clear();
      _address.clear();
      _price.clear();
    });
  }

  uploadImageAndSaveRoomInfo() async {
    uploadRoomImage(_file);
    saveRoomInfo(roomImageUrl);
  }

  Future<String> uploadRoomImage(mFileImage) async {
    final firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref().child("rooms");
    firebase_storage.UploadTask uploadTask =
        storageRef.child("room_$roomId.jpg").putFile(mFileImage);
    final link = await storageRef.getDownloadURL();
    roomImageUrl = link;
    return link;
  }

  saveRoomInfo(String link) {
    final roomref = FirebaseFirestore.instance.collection("rooms");
    roomref.doc(roomId).set(
      {
        "username": _username.text,
        "phone": _phone.text.trim(),
        "address": _address.text,
        "price": _price.text.trim(),
        "thumbnailUrl": link,
      },
    );
    setState(() {
      _file = null;
      uploading = false;
      roomId = DateTime.now().millisecondsSinceEpoch.toString();
      clearFormInfo();
    });
  }
}
