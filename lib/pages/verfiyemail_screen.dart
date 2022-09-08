import 'dart:async';

import 'package:ecomirce_shop/pages/home_screen.dart';
import 'package:ecomirce_shop/shared/tostfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class VerfiyEmailScreen extends StatefulWidget {
  const VerfiyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerfiyEmailScreen> createState() => _VerfiyEmailScreenState();
}

class _VerfiyEmailScreenState extends State<VerfiyEmailScreen> {

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

   void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
       sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        // when we click on the link that existed on yahoo
        await FirebaseAuth.instance.currentUser!.reload();

        // is email verified or not (clicked on the link or not) (true or false)
        setState(() {
          isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        });

        if (isEmailVerified) {
          timer.cancel();
        }
      });
    }
  }

  sendVerificationEmail() async {
    try {
 //      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      DefultTost(masseg: "ERROR => ${e.toString()}", color: Colors.red);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return isEmailVerified ?HomeScreen() :
     Scaffold(
      appBar: AppBar(
        title: const Text ('Verify Email'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        const    Text('A verification email has been sent to your email'), 
        const    SizedBox(
              height: 10,
            ) , 
            ElevatedButton(onPressed: ()
            {
            canResendEmail? sendVerificationEmail() : null;

            }, 
            child: Text('Resent Email'), 
            ), 
           const SizedBox(
              height: 10,
            ) , 
            TextButton(onPressed: ()
            {
               FirebaseAuth.instance.signOut();
            }, 
            child: Text('Cancel')
            ),
          ],
        ),
      ),
    );
  }
}