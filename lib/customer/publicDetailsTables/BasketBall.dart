
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';

// ignore: must_be_immutable
class BasketBallPublicDetailsTables extends StatefulWidget {
  var arrange = [];
  var type;
  GlobalKey<ScaffoldState> _scafold;

  BasketBallPublicDetailsTables(
      this._scafold, this.type, this.arrange);
  @override
  _BasketBallPublicDetailsTablesState createState() =>
      _BasketBallPublicDetailsTablesState();
}

class _BasketBallPublicDetailsTablesState
    extends State<BasketBallPublicDetailsTables> {
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
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
                  title: tr("arrangement"),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: "${tr("team")}",
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: "${tr("play")}",
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: "${tr("win")}",
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: "${tr("lose")}",
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: "${tr("have")}",
                  size: 16,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: "${tr("on")}",
                  size: 16,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: "${tr("different")}",
                  size: 16,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: "${tr("points")}",
                  size: 11,
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
                  title: widget.arrange[0]["index"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                width: 100,
                child: MyText(
                  title: "${widget.arrange[0]["teamname"].toString()}",
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[0]["play"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[0]["win"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[0]["lost"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[0]["plus"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[0]["minus"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[0]["difference"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[0]["point"].toString(),
                  size: 11,
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
                  title: widget.arrange[1]["index"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                width: 100,
                child: MyText(
                  title: "${widget.arrange[1]["teamname"]}",
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[1]["play"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[1]["win"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[1]["lost"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[1]["plus"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[1]["minus"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[1]["difference"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
              Container(
                height: 50,
                child: MyText(
                  title: widget.arrange[1]["point"].toString(),
                  size: 11,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
              ),
            ]),
      ],
    );
  }
}
