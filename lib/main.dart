import 'package:ecomirce_shop/pages/chuckout_screen.dart';
import 'package:ecomirce_shop/pages/login_screen.dart';
import 'package:ecomirce_shop/pages/register_screen.dart';
import 'package:ecomirce_shop/provider/cart.dart';
import 'package:ecomirce_shop/provider/google_signin.dart';
import 'package:ecomirce_shop/shared/cachhelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await CachHelper.init();
   String token = CachHelper.getData(key: 'token');
    print(token);
    Widget widget;
    // ignore: unnecessary_null_comparison
    if(token!=null)
    {
      widget = HomeScreen();
    }else{
      widget = Login();
    }
  runApp( MyApp(startwidget:widget ,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,required this.startwidget}) : super(key: key);
   final Widget startwidget ;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
      create: (context) {
        return Carrt();
      },
        ),
        ChangeNotifierProvider(
          create: (context){
            return GoogleSignInProvider();
          }
          ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: startwidget,
          initialRoute: '/',
        routes: {
          Login.id: (context) => Login(),
          Register.id: (context) => Register(),
          HomeScreen.id: (context) => HomeScreen(),
          CheckOutScreen.id: (context) => CheckOutScreen(),
        },
      ),
      );
  }
}
// TestCamera(),

/*
StreamBuilder(
           stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ));
              } else if (snapshot.hasError) {
                return DefultTost(masseg: "Something went wrong", color: Colors.red);
              } else if (snapshot.hasData) {
                // return VerifyEmailPage();
                return HomeScreen(); // home() OR verify email
              } else {
                return Login();
              }
            },
          ),
ecomirce_shop
*/