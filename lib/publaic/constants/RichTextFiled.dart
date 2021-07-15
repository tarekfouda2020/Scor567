import 'package:score/publaic/constants/MyColors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RichTextFiled extends StatelessWidget{

  TextEditingController controller;
  String label;
  EdgeInsets margin=EdgeInsets.all(0);
  TextInputType type=TextInputType.text;
  int min,max;
  double height;

  RichTextFiled({this.label,this.controller,this.margin,this.type,this.max,this.min,this.height});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: MyColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        minLines: min,
        maxLines: max,
        style: TextStyle(fontFamily: "cairo",fontSize: 14,color: MyColors.white),
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.yellow,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            hintText: "$label",
            hintStyle: TextStyle(fontFamily: "cairo",fontSize: 12,color: MyColors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 5)
        ),
      ),
    );
  }


}