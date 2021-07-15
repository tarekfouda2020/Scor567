import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/ballSpin.dart';

import 'MyText.dart';

class LoadingDialog {

   var _scafold;


  LoadingDialog(this._scafold);

   showDialogMethod(){
    showDialog(
        barrierDismissible: false,
        context: _scafold.currentContext,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            content: Container(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MyText(title: "${tr("loading")}",size: 18,color: Colors.black54,),
                  BallSpin()
                ],
              ),
            ),
          );
        }
    );
  }

  showLoadingView(){
     return BallSpin();

  }

   showMapLoadinView(){
     return BallSpin();
   }

   showNotification(msg){
    _scafold.currentState.showSnackBar(
      SnackBar(
        content: Container(
          height: 30,
          alignment: Alignment.center,
          child: MyText(title: msg,color: Colors.white,size: 16,),
        ),
        backgroundColor: MyColors.yellow,
        duration: Duration(seconds: 2),
      ),
    );
  }

   showBlackNotification(msg){
     _scafold.currentState.showSnackBar(
       SnackBar(
         content: Container(
           height: 30,
           alignment: Alignment.center,
           child: MyText(title: msg,color: Colors.white,size: 16,),
         ),
         backgroundColor: Color(0xff191919),
         duration: Duration(seconds: 2),
       ),
     );
   }


}