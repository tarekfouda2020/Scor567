
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';

// ignore: must_be_immutable
class HandBallTable extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  var gameType;
  var card;
  HandBallTable(this._scafold, this.card);
  @override
  _HandBallTableState createState() => _HandBallTableState();
}

class _HandBallTableState extends State<HandBallTable> {
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
                  title: widget.card["Shoot1Team1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("half1"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Shoot1Team2"].toString(),
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
                  title: widget.card["Shoot2Team1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("half2"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Shoot2Team2"].toString(),
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
                height: 50,
                child: MyText(
                  title: widget.card["PenaltiesTeam1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("Penalties"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
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
