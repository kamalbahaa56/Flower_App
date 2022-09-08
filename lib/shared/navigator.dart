import 'package:flutter/material.dart';

 DefultNavigator({
 required context,
required  Widget widget,
})=>Navigator.push(context, MaterialPageRoute(builder:(context)=>widget));