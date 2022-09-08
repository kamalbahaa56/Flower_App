// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../shared/dataformfirestor.dart';
import '../shared/imgfromfirestore.dart';
class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;

  File? imgPath;
  String? imgName;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  uploadImageScreen() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {imgPath = File(pickedImg.path);});
    } else {print("NO img selected");}
    } catch (e) {print("Error => $e");}
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile page'),
        actions: [
          TextButton.icon(
            onPressed: ()  {
              FirebaseAuth.instance.signOut();
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => Login()),
                 // (route) => false);
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: Text(
              'logout',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        
                      ),
                      width: double.infinity,
                      child: Stack(
                        alignment:AlignmentDirectional.center ,
                        children: [
                          imgPath==null?
                         ImgformFirestore():
                        ClipOval(
                          child: Image.file(imgPath!,
                          width: 145,
                          height: 145,
                          fit: BoxFit.cover,
                          ),
                        ),
  
                          Positioned(
                            bottom: 0,
                            left: 240,
                            child: IconButton(onPressed: () async
                            {
                            await  uploadImageScreen();
                           if(imgPath!=null){
                             // Upload image to firebase storage
                            final storageRef = FirebaseStorage.instance.ref('${imgName}');
                            await storageRef.putFile(imgPath!);
                            String url = await storageRef.getDownloadURL();
                             users.doc(credential!.uid).update({"imgLink": url,});
                           }
                            }, 
                            icon: Icon(Icons.edit,)),
                          ),
                        ],
                      ),
                    ),










 SizedBox(
                    height: 11,
                  ),




              Center(
                child: Container(
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    'Info from firebase Auth',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    'Email : ${credential!.email} ',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    'Created date : ${DateFormat("MMM d, y").format(credential!.metadata.creationTime!)} ',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    'Last Signed in : ${DateFormat("MMM d, y").format(credential!.metadata.lastSignInTime!)} ',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    'Info from firebase Firestore',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GetDataFromFirestore(
                documentId: '${credential!.uid}',
              )
            ],
          ),
        ),
      ),
    );
  }
}
