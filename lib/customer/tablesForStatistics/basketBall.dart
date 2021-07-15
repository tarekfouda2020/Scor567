import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';

// ignore: must_be_immutable
class BasketBallTable extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  var gameType;
  var card;
  BasketBallTable(this._scafold, this.card);
  @override
  _BasketBallTableState createState() => _BasketBallTableState();
}

class _BasketBallTableState extends State<BasketBallTable> {
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
            decoration: BoxDecoration(
                color: Color(0xffffc400).withOpacity(.05),
                border: Border(
                    bottom: BorderSide(
                        color: MyColors.grey.withOpacity(.3), width: 1))),
            children: [
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Qtr1Team1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("1stQuarter"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Qtr1Team2"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: MyColors.grey.withOpacity(.3), width: 1))),
            children: [
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Qtr2Team1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("2ndQuarter"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Qtr2Team2"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
                color: Color(0xffffc400).withOpacity(.05),
                border: Border(
                    bottom: BorderSide(
                        color: MyColors.grey.withOpacity(.3), width: 1))),
            children: [
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Qtr3Team1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("3rdQuarter"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Qtr3Team2"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: MyColors.grey.withOpacity(.3), width: 1))),
            children: [
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Qtr4Team1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("4thQuarter"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Qtr4Team2"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
                color: Color(0xffffc400).withOpacity(.05),
                border: Border(
                    bottom: BorderSide(
                        color: MyColors.grey.withOpacity(.3), width: 1))),
            children: [
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["ExtraTeam1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("ExtraTime"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["ExtraTeam2"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: MyColors.grey.withOpacity(.3), width: 1))),
            children: [
              Container(
                height: widget.card["PenaltiesTeam1"] != 0 &&
                        widget.card["PenaltiesTeam2"] != 0
                    ? 50
                    : 0,
                child: MyText(
                  title: widget.card["PenaltiesTeam1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: widget.card["PenaltiesTeam1"] != 0 &&
                        widget.card["PenaltiesTeam2"] != 0
                    ? 50
                    : 0,
                child: MyText(
                  title: tr("Penalties"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: widget.card["PenaltiesTeam1"] != 0 &&
                        widget.card["PenaltiesTeam2"] != 0
                    ? 50
                    : 0,
                child: MyText(
                  title: widget.card["PenaltiesTeam2"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
            ]),
      ],
    );
  }
}
