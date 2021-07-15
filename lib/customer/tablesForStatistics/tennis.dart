
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';

// ignore: must_be_immutable
class Tennis extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  var gameType;
  var card;

  Tennis(this._scafold, this.card);

  @override
  _TennisState createState() => _TennisState();
}

class _TennisState extends State<Tennis> {
  int _checkServe = 1;

  @override
  void initState() {
    setState(() {
      _checkServe = widget.card["Serve"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.card["Serve"] == 0
            ? Container()
            : Container(
          color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Radio(
                          value: 1, groupValue: _checkServe, onChanged: (val){},activeColor: MyColors.primary,),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      width: 130,
                      child: MyText(
                        title: tr("serve"),
                        size: 14,
                        color: MyColors.primary,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      child: Radio(
                          value: 2, groupValue: _checkServe, onChanged: (val){},activeColor: MyColors.primary),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
        Table(
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
                      title: widget.card["ShootTeam1"].toString(),
                      size: 14,
                      color: Colors.black,
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    height: 50,
                    child: MyText(
                      title: tr("game"),
                      size: 14,
                      color: MyColors.primary,
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    height: 50,
                    child: MyText(
                      title: widget.card["ShootTeam2"].toString(),
                      size: 14,
                      color: Colors.black,
                    ),
                    alignment: Alignment.center,
                  ),
                ]),
            widget.card["Grp1Team1"].toString() == "0" &&
                    widget.card["Grp1Team2"].toString() == "0"
                ? TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        ),
                    children: [
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                      ])
                : TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    children: [
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp1Team1"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: tr("group1"),
                            size: 14,
                            color: MyColors.primary,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp1Team2"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
            widget.card["Tie1Team1"].toString() == "0" &&
                    widget.card["Tie1Team2"].toString() == "0"
                ? TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                       ),
                    children: [
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                      ])
                : TableRow(
                    decoration: BoxDecoration(
                        color: Color(0xffffc400).withOpacity(.05),
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    children: [
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Tie1Team1"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: tr("breakEqual"),
                            size: 14,
                            color: MyColors.primary,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Tie1Team2"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
            widget.card["Grp2Team1"].toString() == "0" &&
                    widget.card["Grp2Team2"].toString() == "0"
                ? TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                       ),
                    children: [
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                      ])
                : TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    children: [
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp2Team1"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: tr("group2"),
                            size: 14,
                            color: MyColors.primary,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp2Team2"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
            widget.card["Tie2Team1"].toString() == "0" &&
                    widget.card["Tie2Team2"].toString() == "0"
                ? TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        ),
                    children: [
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                      ])
                : TableRow(
                    decoration: BoxDecoration(
                        color: Color(0xffffc400).withOpacity(.05),
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    children: [
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Tie2Team1"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: tr("breakEqual"),
                            size: 14,
                            color: MyColors.primary,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Tie2Team2"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
            widget.card["Grp3Team1"].toString() == "0" &&
                    widget.card["Grp3Team2"].toString() == "0"
                ? TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        ),
                    children: [
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                      ])
                : TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    children: [
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp3Team1"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: tr("group3"),
                            size: 14,
                            color: MyColors.primary,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp3Team2"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
            widget.card["Tie3Team1"].toString() == "0" &&
                    widget.card["Tie3Team2"].toString() == "0"
                ? TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        ),
                    children: [
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                      ])
                : TableRow(
                    decoration: BoxDecoration(
                        color: Color(0xffffc400).withOpacity(.05),
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    children: [
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Tie3Team1"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: tr("breakEqual"),
                            size: 14,
                            color: MyColors.primary,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Tie3Team2"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
            widget.card["Grp4Team1"].toString() == "0" &&
                    widget.card["Grp4Team2"].toString() == "0"
                ? TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                    ),
                    children: [
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                      ])
                : TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    children: [
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp4Team1"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: tr("group4"),
                            size: 14,
                            color: MyColors.primary,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp4Team2"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
            widget.card["Tie4Team1"].toString() == "0" &&
                    widget.card["Tie4Team1"].toString() == "0"
                ? TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        ),
                    children: [
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                      ])
                : TableRow(
                    decoration: BoxDecoration(
                        color: Color(0xffffc400).withOpacity(.05),
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    children: [
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Tie4Team1"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: tr("breakEqual"),
                            size: 14,
                            color: MyColors.primary,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Tie4Team2"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
            widget.card["Grp5Team1"].toString() == "0" &&
                    widget.card["Grp5Team2"].toString() == "0"
                ? TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                       ),
                    children: [
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 1,
                          alignment: Alignment.center,
                        ),
                      ])
                : TableRow(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    children: [
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp5Team1"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: tr("group5"),
                            size: 14,
                            color: MyColors.primary,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          child: MyText(
                            title: widget.card["Grp5Team2"].toString(),
                            size: 14,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
          ],
        ),
      ],
    );
  }
}
