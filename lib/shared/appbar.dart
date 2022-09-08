
import 'package:badges/badges.dart';
import 'package:ecomirce_shop/pages/chuckout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class APPBAR extends StatelessWidget {
  const APPBAR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return Consumer<Carrt>(
              builder: (context,cart,child)
              {
             return Row(
              children: [
                Badge
                (
                  badgeContent:Text('${cart.selectProduct.length}',style: TextStyle(color: Colors.white,fontSize: 12),), 
                  position: const BadgePosition(end: 30, bottom: 30),
                  child:  IconButton(
                            onPressed: () 
                            {
                              Navigator.push(
                                context, 
                              MaterialPageRoute(builder: (context)=>CheckOutScreen()
                              ),);
                            },
                            icon: Icon(Icons.add_shopping_cart_outlined)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "\$${cart.Price} ",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            );
               
              }
              );  
  }
}
        