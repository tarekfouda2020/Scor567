import 'package:score/publaic/constants/MyColors.dart';
import 'package:flutter/material.dart';

import 'MyColors.dart';

// ignore: must_be_immutable
class IconTextFiled extends StatelessWidget{

  TextEditingController controller;
  String label;
  EdgeInsets margin=EdgeInsets.all(0);
  TextInputType type=TextInputType.text;
  Widget icon;
  bool isPassword=false;
  IconTextFiled({this.label,this.controller,this.margin,this.type,this.icon,this.isPassword});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      margin: margin,
      decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        enabled: true,
        obscureText: isPassword,
        style: TextStyle(fontSize: 16,fontFamily: "cairo",color: MyColors.white),
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.yellow,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            hintText: "$label",
            hintStyle: TextStyle(fontFamily: "cairo",fontSize: 14,color: MyColors.grey),
            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
          suffixIcon: icon,
        ),
      ),
    );
  }


}