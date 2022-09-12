// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../components/formfield.dart';
import '../shared/navigator.dart';
import '../shared/tostfile.dart';
import 'login_screen.dart';
import 'dart:io';
 import 'package:path/path.dart' show basename;
 import "dart:math";

class Register extends StatefulWidget {
  static final String id = 'register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var EmailController = TextEditingController();

  var PasswordController = TextEditingController();

  var UserName = TextEditingController();

  var TitleController = TextEditingController();

  var AgeController = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  bool ispaswwordshow = false;

  IconData iconData = Icons.visibility_off_outlined;

  bool ispassword8Charcter = false;

  bool ispasswordAtLest1number = false;

  bool passwordHasUpperCase = false;

  bool passwordHasLowercase = false;

  bool hasSpecialCharacters = false;
  File? imgPath;
  String ? imgName ; 
  onPasswordChanged(String password) {
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        ispassword8Charcter = true;
      } else
        ispassword8Charcter = false;

      if (password.contains(RegExp(r'[0-9]'))) {
        ispasswordAtLest1number = true;
      } else
        ispasswordAtLest1number = false;

      if (password.contains(RegExp(r'[A-Z]'))) {
        passwordHasUpperCase = true;
      } else
        passwordHasUpperCase = false;

      if (password.contains(RegExp(r'[a-z]'))) {
        passwordHasLowercase = true;
      } else
        passwordHasLowercase = false;

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      } else
        hasSpecialCharacters = false;
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailController.text,
        password: PasswordController.text,
      );
    // Upload image to firebase storage
  final storageRef = FirebaseStorage.instance.ref(imgName);
  await storageRef.putFile(imgPath!); 
     String url = await storageRef.getDownloadURL();
      DefultTost(
          masseg: 'An account has been created successfully',
          color: Colors.green);
          DefultNavigator(context: context,widget: Login());
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users
          .doc('${credential.user!.uid}')
          .set({
            'imgLink':   url  ,
            'full_name': UserName.text,
            'title': TitleController.text,
            'age': AgeController.text,
            'Email': EmailController.text,
            'Password': PasswordController.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        DefultTost(
            masseg: 'The password provided is too weak',
            color: Colors.deepOrange);
      } else if (e.code == 'email-already-in-use') {
        //print('The account already exists for that email.');
        DefultTost(
            masseg: 'The account already exists for that email.',
            color: Colors.deepOrange);
      } else {
        DefultTost(
            masseg: 'Error - Please try again later', color: Colors.deepOrange);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  showsheet() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await uploadImageScreen(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt, color: Colors.deepOrange),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        'From Camera',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    await uploadImageScreen(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.photo, color: Colors.deepOrange),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        'From Gallery',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  uploadImageScreen(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
         imgName = basename(pickedImg.path);
         int random = Random().nextInt(9999999);
         imgName = "$random$imgName";
         print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  void dispose() {
    UserName.dispose();
    AgeController.dispose();
    TitleController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      //width: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          imgPath == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 60,
                                  backgroundImage:
                                      AssetImage('assets/image/avatar.png'),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    imgPath!,
                                    width: 145,
                                    height: 145,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          Positioned(
                            bottom: -10,
                            left: 85,
                            child: IconButton(
                                onPressed: () {
                                  // uploadImageScreen();
                                  showsheet();
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.deepOrange,
                                )),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    DefultFormFiled(
                      controller: UserName,
                      typee: TextInputType.text,
                      Label: 'user name',
                      Validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter your user name';
                        }
                      },
                      PreFixIcon: Icons.person,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    DefultFormFiled(
                      controller: TitleController,
                      typee: TextInputType.text,
                      Label: 'Title',
                      Validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter your title';
                        }
                      },
                      PreFixIcon: Icons.title,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    DefultFormFiled(
                      controller: AgeController,
                      typee: TextInputType.number,
                      Label: 'Age',
                      Validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter your Age';
                        }
                      },
                      PreFixIcon: Icons.assignment_ind_outlined,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    DefultFormFiled(
                      controller: EmailController,
                      typee: TextInputType.emailAddress,
                      Label: 'Email Address',
                      Validator: (value) {
                        return value!.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                            ? null
                            : "Enter a valid email";
                      },
                      autovalidate: AutovalidateMode.onUserInteraction,
                      PreFixIcon: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefultFormFiled(
                      onChanged: (value) {
                        onPasswordChanged(value);
                      },
                      controller: PasswordController,
                      SufFixIcon: iconData,
                      ispassword: ispaswwordshow,
                      Label: 'Password',
                      Validator: (value) {
                        return value!.length < 8
                            ? "Enter at least 6 characters"
                            : null;
                      },
                      PreFixIcon: Icons.lock_outlined,
                      autovalidate: AutovalidateMode.onUserInteraction,
                      SuffixIcon: () {
                        setState(() {
                          ispaswwordshow = !ispaswwordshow;
                          iconData = ispaswwordshow
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined;
                        });
                      },
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    ///--------- Desighn chick validate ..................
                    ///------ 1 ----------
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: ispassword8Charcter
                                  ? Colors.deepOrange
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('At least 8 characters')
                      ],
                    ),

                    /// -----2----------
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: ispasswordAtLest1number
                                  ? Colors.deepOrange
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('At least 1 number')
                      ],
                    ),

                    ///---------3-------------
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: passwordHasUpperCase
                                  ? Colors.deepOrange
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Has Uppercase')
                      ],
                    ),

                    ///---------4------------
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: passwordHasLowercase
                                  ? Colors.deepOrange
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Has Lowercase')
                      ],
                    ),

                    ///-----------5------------

                    SizedBox(
                      height: 12,
                    ),

                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: hasSpecialCharacters
                                  ? Colors.deepOrange
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('has Special Characters ')
                      ],
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()&&imgName!=null&&imgPath!=null)
                            await register();
                        },
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text('Register'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't Have an account ?"),
                        SizedBox(
                          width: 1,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, Login.id);
                          },
                          child: Text('sign in'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
