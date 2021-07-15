import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:score/customer/tablesForStatistics/basketBall.dart';
import 'package:score/customer/tablesForStatistics/handBall.dart';
import 'package:score/customer/tablesForStatistics/tennis.dart';
import 'package:score/customer/tablesForStatistics/volleyBall.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';



// ignore: must_be_immutable
class Statestics extends StatefulWidget{

  GlobalKey<ScaffoldState> _scafold;

  var gameType;
  var card;
//gameType(1//basket ball  && 3 // handball && 2//VolleyBall && 4//Tennis)


  Statestics(this._scafold,this.gameType,this.card);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }

}

class _classState extends State<Statestics>{
  @override
  Widget build(BuildContext context) {
    print("_______ 22${widget.card}");

    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child:MyText(title: "",size: 16,color: MyColors.primary,),
        ),
        Container(// التفاصيل بتضرب لان الكارد راجع ب نل !! وانت عاطيله شرط يملى الكارد فى حاله HaveCard
            color: Color(0xffffc400).withOpacity(.1),
          child:widget.gameType==1?widget.card!= null? BasketBallTable(widget._scafold,widget.card):Container(
            alignment:Alignment.center ,
            child: MyText(
              title: tr("noDetails"),
              size: 16,
              color: Colors.black,
              alien: TextAlign.center,
            ),
          ):
          widget.gameType==2? widget.card != null ?VolleyBallTable(widget._scafold,widget.card):Container(
            alignment:Alignment.center ,
            child: MyText(
              title: tr("noDetails"),
              size: 16,
              color: Colors.black,
              alien: TextAlign.center,
            ),
          ):
          widget.gameType==3? widget.card != null ?HandBallTable(widget._scafold,widget.card):Container(
            alignment:Alignment.center ,
            child: MyText(
              title: tr("noDetails"),
              size: 16,
              color: Colors.black,
              alien: TextAlign.center,
            ),
          ):
          Tennis(widget._scafold,widget.card)

        )
      ],
    );
  }


}