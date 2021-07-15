import 'package:score/publaic/constants/MyColors.dart';
import 'package:flutter/material.dart';

import 'MyColors.dart';

// ignore: must_be_immutable
class InkWellTextField extends StatelessWidget{

  TextEditingController controller;
  String label;
  EdgeInsets margin=EdgeInsets.all(0);
  TextInputType type=TextInputType.text;
  Widget icon;
  Function onTab;
  double size=16;
  InkWellTextField({this.label,this.controller,this.margin,this.type,this.onTab,this.icon,this.size});


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
      child: InkWell(
        onTap: onTab,
        child: TextFormField(
          controller: controller,
          keyboardType: type,
          enabled: false,
          style: TextStyle(fontSize: this.size,fontFamily: "cairo",color: MyColors.white),
          decoration: InputDecoration(
              disabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.yellow.withOpacity(.8),width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              hintText: "$label",
              hintStyle: TextStyle(fontFamily: "cairo",fontSize: this.size,color: MyColors.grey),
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
              suffixIcon: icon
          ),
        ),
      ),
    );
  }


}