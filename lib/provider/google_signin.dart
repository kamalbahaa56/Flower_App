// ignore_for_file: unnecessary_null_comparison

import 'package:ecomirce_shop/shared/cachhelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/home_screen.dart';

class GoogleSignInProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  googlelogin(context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleSignIn == null) return;
    _user = googleUser;
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
      
    );
    CachHelper.SaveData(key: 'token', value: googleAuth?.idToken).then((value){
               Navigator.popAndPushNamed(context, HomeScreen.id);
            });
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }
}
