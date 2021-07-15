
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';

// ignore: must_be_immutable
class HandBallScheduleTable extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  var arrangedTeams = [];
  var lastIndex, upIndex;
  var identifiers;
  HandBallScheduleTable(this._scafold, this.arrangedTeams,
      this.lastIndex, this.upIndex, this.identifiers);
  @override
  _HandBallScheduleTableState createState() => _HandBallScheduleTableState();
}

class _HandBallScheduleTableState extends State<HandBallScheduleTable> {
  var down = 0;
  setNum() {
    setState(() {
      widget.upIndex == null ? widget.upIndex = 0 : null;
      widget.lastIndex == null ? widget.lastIndex = 0 : null;
      down = widget.arrangedTeams.length - widget.lastIndex;
    });
  }

  @override
  void initState() {
    setNum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setNum();
//    final landScape =
//        MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: MyColors.grey.withOpacity(.3), width: 1))),
                  children: [
                    Container(
                      height: 50,
                      child: MyText(
                        title: '',
                        size: 10,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      child: MyText(
                        title: "${tr("team")}",
                        size: 10,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      child: MyText(
                        title: "${tr("play")}",
                        size: 10,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      child: MyText(
                        title: "${tr("win")}",
                        size: 10,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      child: MyText(
                        title: "${tr("Draw")}",
                        size: 10,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      child: MyText(
                        title: "${tr("lose")}",
                        size: 10,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),

                    Container(
                      height: 50,
                      child: MyText(
                        title: "+",
                        size: 18,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      child: MyText(
                        title: "-",
                        size: 18,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      child: MyText(
                        title: "+/-",
                        size: 18,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 50,
                      child: MyText(
                        title: "${tr("points")}",
                        size: 10,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                  ]),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.arrangedTeams.length, (index) {
            return Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(1.2),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: MyColors.grey.withOpacity(.3), width: 1),
                      ),
                      color: index.isOdd
                          ? Color(0xffffc400).withOpacity(.05)
                          : Colors.white,
                    ),
                    children: [
                      Container(
                        height: 50,
                        child: Container(
                          width: 25,
                          height: 25,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index + 1 <= widget.upIndex
                                  ? MyColors.primary
                                  : down <= index
                                      ? Colors.red
                                      : Colors.transparent),
                          alignment: Alignment.center,
                          child: MyText(
                            title: "${index + 1}",
                            size: 13,
                            color: Colors.black,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        child: MyText(
                          title: "${widget.arrangedTeams[index]["TeamName"]}",
                          size: 10,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 50,
                        child: MyText(
                          title:
                              "${widget.arrangedTeams[index]["Play"] ?? "0"}",
                          size: 11,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 50,
                        child: MyText(
                          title: "${widget.arrangedTeams[index]["Win"] ?? "0"}",
                          size: 11,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 50,
                        child: MyText(
                          title:
                          "${widget.arrangedTeams[index]["Draw"] ?? "0"}",
                          size: 11,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 50,
                        child: MyText(
                          title:
                              "${widget.arrangedTeams[index]["Lost"] ?? "0"}",
                          size: 11,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                      ),

                      Container(
                        height: 50,
                        child: MyText(
                          title:
                              "${widget.arrangedTeams[index]["Plus"] ?? "0"}",
                          size: 11,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 50,
                        child: MyText(
                          title:
                              "${widget.arrangedTeams[index]["Minus"] ?? "0"}",
                          size: 11,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 50,
                        child: MyText(
                          title:
                              "${widget.arrangedTeams[index]["Difference"] ?? "0"}",
                          size: 11,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 50,
                        child: MyText(
                          title:
                              "${widget.arrangedTeams[index]["Points"] ?? "0"}",
                          size: 11,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                      ),
                    ]),
              ],
            );
          }),
        ),
        widget.identifiers == null || widget.identifiers == {}
            ? Container()
            : Container(
//                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: <Widget>[
//                    Container(
//                      color: Colors.grey.withOpacity(.2),
//                      margin: EdgeInsets.only(top: 5),
//                      padding:
//                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          MyText(
//                            title: "${tr("colorKey")}",
//                            size: 16,
//                            color: MyColors.primary,
//                          )
//                        ],
//                      ),
//                    ),
                    widget.identifiers["Qualified"] == null
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: MyColors.grey.withOpacity(.3),
                                        width: 1))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 15,
                                  height: 15,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: MyColors.primary,
                                      shape: BoxShape.circle),
                                ),
                                MyText(
                                  title: widget.identifiers["Qualified"],
                                  size: 12,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                    widget.identifiers["Down"] == null
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: MyColors.grey.withOpacity(.3),
                                        width: 1))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 15,
                                  height: 15,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                ),
                                MyText(
                                  title: widget.identifiers["Down"],
                                  size: 12,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              )
      ],
    );
  }
}
