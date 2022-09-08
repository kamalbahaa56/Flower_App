import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImgformFirestore extends StatefulWidget {
 

  @override
  State<ImgformFirestore> createState() => _ImgformFirestoreState();
}

class _ImgformFirestoreState extends State<ImgformFirestore> {
  var DialogUsernameController = TextEditingController();
  var PasswordControllerr = TextEditingController();
  var Titlecontrollerr = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;

 

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
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
          return CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 60,
                            backgroundImage: NetworkImage( '${data['imgLink']}'),
                          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}




//  Text('Password  :  ${data['Password']}'),