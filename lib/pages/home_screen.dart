// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecomirce_shop/pages/login_screen.dart';
import 'package:ecomirce_shop/pages/profile_page.dart';
import 'package:ecomirce_shop/provider/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/items.dart';
import '../shared/appbar.dart';
import '../shared/cachhelper.dart';
import '../shared/imgfromfirestore.dart';
import '../shared/navigator.dart';
import 'chuckout_screen.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'Home';

  @override
  Widget build(BuildContext context) {
    final userr =FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            APPBAR(),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/image/proo.png',
                    ),
                  ),
                ),
                 accountName: Text(
                   '${userr?.displayName==null?'':userr!.displayName}',
                 ),
                 accountEmail: Text('${userr?.email==null?'':userr!.email}'),
                currentAccountPicture:ImgformFirestore()
              ),
              ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
              ListTile(
                title: Text('My Products'),
                leading: Icon(Icons.add_shopping_cart),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckOutScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('About'),
                leading: Icon(Icons.help_center),
                onTap: () {},
              ),
              ListTile(
                title: Text('My Profile'),
                leading: Icon(Icons.person_outline),
                onTap: () {
                  DefultNavigator(
                    context: context,
                    widget: ProfilePage(),
                  );
                },
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),
                onTap: ()  {
                   FirebaseAuth.instance.signOut();
                   CachHelper.removeData(key: 'token');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Developed by Kamal Bahaa © 2022 ',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ConditionalBuilder(
            condition: plantess.length > 0,
            builder: (context) => Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 33),
                      itemCount: plantess.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Details(modell: plantess[index])));
                          },
                          child: GridTile(
                            footer: GridTileBar(
                              title: Text(''),
                              trailing: Consumer<Carrt>(
                                  builder: ((context, classInstancee, child) {
                                return IconButton(
                                  onPressed: () {
                                    classInstancee.AddProduct(plantess[index]);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                );
                              })),
                              leading: Text("\$${plantess[index].Num}"),
                            ),
                            child: Stack(children: [
                              Positioned(
                                right: 0,
                                left: 0,
                                top: -3,
                                bottom: -9,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(55),
                                    child: Image.asset(
                                        '${plantess[index].image}')),
                              )
                            ]),
                          ),
                        );
                      }),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
