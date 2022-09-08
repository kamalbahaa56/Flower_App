// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecomirce_shop/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CheckOutScreen extends StatelessWidget {
 static final String id = 'CheckOutScreen';
  @override
  Widget build(BuildContext context) {
    var carret = Provider.of<Carrt>(context);
    return Scaffold(
      appBar: AppBar
      (
        title: Text('Chekout'),
        actions: [
          APPBAR(),
        ],
      ),
  
    body: ConditionalBuilder(
      condition: carret.selectProduct.length>0, 
      builder: (context)=>Column(
      children: [
        SizedBox
        (
          height: 500,
          child: ListView.builder(
            physics:BouncingScrollPhysics(),
            
            itemBuilder:(contex,index)=>Card 
            (
              child: ListTile
              (
                subtitle: Row(
                  children: [
                    Text('\$${carret.selectProduct[index].Num}'),
                    SizedBox(width: 20,),
                    Text('${carret.selectProduct[index].location}'),
                    ],
                    ),
                leading: CircleAvatar(backgroundImage: AssetImage('${carret.selectProduct[index].image}'),),
                title: Text('${carret.selectProduct[index].name}'),
                trailing: IconButton(
                  onPressed: ()
                  {
                    carret.RemoveProdct(carret.selectProduct[index]);
                  },
                  icon:Icon(Icons.remove),
                  ),
              ),
            ) ,
            itemCount: carret.selectProduct.length,
           
          ),
        ),
      SizedBox(height: 20,),
      ElevatedButton(
      onPressed: (){}, 
      child:Text('Pay \$ ${carret.Price}') ,
      style: ButtonStyle(),
      ),
      ],
    ), 
      fallback: (context)=>Center(
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            Text('No items to buy',style: TextStyle(fontSize: 30,color: Colors.grey),), 
            SizedBox(height: 20,),
            Icon(Icons.remove_shopping_cart_outlined,size: 30,color: Colors.grey,)
          ],
        ),
      )
      ),
   );
  }
}
