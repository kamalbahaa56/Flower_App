// ignore_for_file: unused_catch_clause

import 'package:ecomirce_shop/components/formfield.dart';
import 'package:ecomirce_shop/shared/tostfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ResetPasswordScreen extends StatefulWidget {
   ResetPasswordScreen({Key? key}) : super(key: key);
  static String id = 'Reset Password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var EmailController = TextEditingController();
  var _FormKey = GlobalKey<FormState>();
  bool islaoading = false ; 

  resetPassword() async
  {
    setState(() {
      islaoading = true;
    });
    try {
      await FirebaseAuth.instance
    .sendPasswordResetEmail(email: EmailController.text);
    DefultTost(masseg: 'Done please check your email', color: Colors.green);
    }on FirebaseAuthException catch (e) {
      DefultTost(masseg: 'user not found', color: Colors.red);
    }
    setState(() {
      islaoading = false;
    });
  }

  @override
  void dispose() {
    EmailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Reset Password')),),
      body: Padding(
        padding: const EdgeInsets.only(right: 20,left: 20),
        child: Form(
          key: _FormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter your email to reset your password'),
              SizedBox(height: 40,),
              DefultFormFiled(
                controller: EmailController, 
                Label: 'Your Email', 
                typee: TextInputType.emailAddress,
              Validator: (value) 
                        {
                          return value!.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")) ? null : "Enter a valid email"  ;
                        },
                        autovalidate:AutovalidateMode.onUserInteraction ,
                 PreFixIcon: Icons.email_outlined,
                 ),
                 SizedBox(height: 20,),
                 ElevatedButton(
                  onPressed: () async
                  {
                    if(_FormKey.currentState!.validate())
                    {
                  await resetPassword();
                    }

                  }, 
                  child:islaoading? CircularProgressIndicator(color: Colors.white,): Text('ResetS passwords')
                  ),
            ],
          ),
        ),
      ),
    );
  }
}