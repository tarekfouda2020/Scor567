import 'package:score/publaic/constants/MyColors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LabelTextField extends StatelessWidget{

  TextEditingController controller;
  String label;
  EdgeInsets margin=EdgeInsets.all(0);
  bool isPassword=false;
  TextInputType type=TextInputType.text;
  double size=14;

  LabelTextField({this.label,this.controller,this.margin,this.isPassword,this.type,this.size});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        style: TextStyle(fontSize: size,fontFamily: "cairo",color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.grey.withOpacity(.5),width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.primary,width: 2),
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          hintText: "  $label  ",
          hintStyle: TextStyle(fontFamily: "cairo",fontSize: size,color: MyColors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 14)
        ),
      ),
    );
  }


}