
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';

// ignore: must_be_immutable
class VolleyBallTable extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  var gameType;
  var card;
  VolleyBallTable(this._scafold, this.card);
  @override
  _VolleyBallTableState createState() => _VolleyBallTableState();
}

class _VolleyBallTableState extends State<VolleyBallTable> {

  @override
  Widget build(BuildContext context) {
    print("_______ ${widget.card}");
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
                  title:"${widget.card["Shoot1Team1"]}",
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("set1"),
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
                  title: tr("set2"),
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
                  title: widget.card["Shoot3Team1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("set3"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Shoot3Team2"].toString(),
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
                  title: widget.card["Shoot4Team1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("set4"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Shoot4Team2"].toString(),
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
                  title: widget.card["Shoot5Team1"].toString(),
                  size: 14,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: tr("set5"),
                  size: 14,
                  color: MyColors.primary,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.card["Shoot5Team2"].toString(),
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
