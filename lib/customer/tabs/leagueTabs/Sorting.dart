import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:score/customer/tablesOfSchedule/basketBall.dart';
import 'package:score/customer/tablesOfSchedule/handBall.dart';
import 'package:score/customer/tablesOfSchedule/tennis.dart';
import 'package:score/customer/tablesOfSchedule/volleyBall.dart';

// ignore: must_be_immutable
class Sorting extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  var arrangedTeams = [];
  var gameType;
  var identifierNumber;
//gameType(1//basket ball  && 3 // handball && 2//VolleyBall && 4//Tennis)

  Sorting(this._scafold, this.arrangedTeams, this.gameType,
      this.identifierNumber);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<Sorting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.gameType == 1
        ? BasketBallScheduleTable(
            widget._scafold,
            widget.arrangedTeams,
            widget.identifierNumber["Count_Down"],
            widget.identifierNumber["Count_Qualified"],widget.identifierNumber)
        : widget.gameType == 2
            ? VolleyBallScheduleTable(
                widget._scafold,
                widget.arrangedTeams,
                widget.identifierNumber["Count_Down"],
                widget.identifierNumber["Count_Qualified"],widget.identifierNumber)
            :widget.gameType==3? HandBallScheduleTable(
                widget._scafold,
                widget.arrangedTeams,
                widget.identifierNumber["Count_Down"],
                widget.identifierNumber["Count_Qualified"],widget.identifierNumber):TennisScheduleTable(
        widget._scafold,
        widget.arrangedTeams,
        widget.identifierNumber["Count_Down"],
        widget.identifierNumber["Count_Qualified"],widget.identifierNumber);
  }
}
