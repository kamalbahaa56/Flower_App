// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  GetDataFromFirestore({required this.documentId});

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  var DialogUsernameController = TextEditingController();
  var PasswordControllerr = TextEditingController();
  var Titlecontrollerr = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;

  MyDilalog(Map data, dynamic mykey) {
    return showDialog(
        context: context,
        builder: (contex) {
          return Dialog(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: DialogUsernameController,
                    maxLength: 20,
                    decoration: InputDecoration(hintText: '${data[mykey]}'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          var collection =
                              FirebaseFirestore.instance.collection('users');
                          collection.doc(credential!.uid).update({
                            mykey: DialogUsernameController.text,
                          }) // <-- Updated data
                              .then((_) {
                            DialogUsernameController.clear();
                            setState(() {
                              Navigator.pop(context);
                            });
                            print('Success');
                          }).catchError((error) => print('Failed: $error'));
                        },
                        child: Text('Edit'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Full Name: ${data['full_name']} "),
                  IconButton(
                    onPressed: () {
                      MyDilalog(data, 'full_name');
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Title : ${data['title'] == null ? '' : data['title']}'),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            // Delete Filed
                            CollectionReference users =
                                FirebaseFirestore.instance.collection('users');
                            final credential =
                                FirebaseAuth.instance.currentUser;
                            users
                                .doc(credential!.uid)
                                .update({"title": FieldValue.delete()});
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          MyDilalog(data, 'title');
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('age  :  ${data['age']}'),
                  IconButton(
                    onPressed: () {
                      MyDilalog(data, 'age');
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Password  :  ${data['Password']}'),
                  IconButton(
                    onPressed: () {
                      MyDilalog(data, 'Password');
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
