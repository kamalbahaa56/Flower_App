import 'package:flutter/material.dart';

Widget DefultFormFiled({
required TextEditingController controller,
bool ispassword = false,
GestureTapCallback ?onTap,
ValueChanged<String>? OnSubmitted,
required String Label ,
required FormFieldValidator<String> Validator,
VoidCallback? SuffixIcon,
 IconData ?SufFixIcon ,
 required IconData PreFixIcon ,
  TextInputType ?typee ,
  AutovalidateMode ? autovalidate,
  ValueChanged<String>? onChanged,
})=>TextFormField(
  onChanged: onChanged,
  keyboardType:typee ,
  controller:controller ,
  obscureText:ispassword ,
  onTap:onTap ,
  onFieldSubmitted: OnSubmitted,
  validator: Validator,
  autovalidateMode: autovalidate,
  decoration: InputDecoration(
    border: OutlineInputBorder
    (
      borderRadius:  BorderRadius.all(Radius.circular(10.0)),
    ),
    label: Text(Label),
     prefixIcon: Icon(PreFixIcon) ,
     suffixIcon: SufFixIcon!=null?IconButton(onPressed: SuffixIcon, icon: Icon(SufFixIcon),):null,
  ),
);