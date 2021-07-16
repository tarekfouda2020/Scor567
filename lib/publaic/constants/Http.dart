import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'LoadingDialog.dart';


class Http{

  var _scafold;
  String baseUrl="https://score567.4hoste.com/";


  Http(this._scafold);



  post(url,body,context)async{
    LoadingDialog(_scafold).showDialogMethod();
    var response = await http.post(Uri.parse("$baseUrl$url"),body: body);
    if(response.statusCode==200){
      var data=json.decode(response.body);
      if(data["key"]==1){
        Navigator.of(context).pop();
//        LoadingDialog(_scafold).showNotification(data["msg"].toString());
        return data;
      }else{
        Navigator.of(context).pop();
        return data;
//        LoadingDialog(_scafold).showNotification("${data["msg"].toString()}");
      }
    }else{
      Navigator.of(context).pop();
      LoadingDialog(_scafold).showNotification("${tr("chickNet")}");
    }

    return null;

  }

  get(url,body,context,{close=false})async{
    var response = await http.post(Uri.parse("$baseUrl$url"),body: body);
    if(close){
      Navigator.of(context).pop();
    }
    if(response.statusCode==200){
      var data=json.decode(response.body);
      if(data["key"]==1){

        return data;
      }else{
//        LoadingDialog(_scafold).showNotification(data["msg"].toString());
        return data;
      }
    }else{
      LoadingDialog(_scafold).showNotification("${tr("chickNet")}");
    }
    return null;
  }



}