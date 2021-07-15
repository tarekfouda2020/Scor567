import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/customer/publicDetailsTables/BasketBall.dart';
import 'package:score/customer/publicDetailsTables/Tennis.dart';
import 'package:score/customer/publicDetailsTables/VolleyBall.dart';
import 'package:score/customer/publicDetailsTables/handBall.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';

// ignore: must_be_immutable
class PublicDetails extends StatefulWidget {
  var meats = [];
  var arrange = [];
  var type;
  GlobalKey<ScaffoldState> _scafold;

  PublicDetails(this._scafold, this.meats, this.arrange, this.type);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<PublicDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final landScape =
//        MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.arrange.length == 0 || widget.arrange.length == null
            ? Container()
            : Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: MyText(
                  title: tr("teamsArrangement"),
                  size: 14,
                  color: MyColors.primary,
                ),
              ),
        Container(
          color: Color(0xffffc400).withOpacity(.1),
          child: widget.arrange.length == 0 || widget.arrange.length == null
              ? Container()
              : widget.type == 1
                  ? BasketBallPublicDetailsTables(
                      widget._scafold, widget.type, widget.arrange)
                  : widget.type == 2
                      ? VolleyBallPublicDetailsTables(
                          widget._scafold, widget.type, widget.arrange)
                      : widget.type == 3
                          ? HandBallPublicDetailsTables(
                              widget._scafold, widget.type, widget.arrange)
                          : TennisPublicDetailsTables(
                              widget._scafold, widget.type, widget.arrange),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: MyText(
            title:
                widget.type == 4 ? "${tr("lastMeats")}" : "${tr("lastMeats")}",
            size: 14,
            color: MyColors.primary,
          ),
        ),
        Container(
          child: Center(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: widget.meats.length == 0 || widget.meats.length == null
                      ? Container(
                          child: Center(
                            child: MyText(
                              title: tr("noMeets"),
                            ),
                          ),
                        )
                      : Container(
                          color: MyColors.back_red.withOpacity(.02),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(widget.meats.length, (index) {
                              return Container(
                                padding: EdgeInsets.only(
                                    right: 5, left: 5, top: 5, bottom: 5),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xffffc400).withOpacity(.1),
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.withOpacity(.2),
                                            width: 2))),
                                child: InkWell(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              MyText(
                                                title: '',
                                                size: 10,
                                                color: MyColors.primary,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              MyText(
                                                title: widget.meats[index]["teamhost"],
                                                size: 12,
                                                color: Colors.black,
                                              ),
                                              MyText(
                                                title:
                                                    "(${widget.meats[index]["countryhost"]})",
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                width:
                                                    MediaQuery.of(context).size.width *
                                                        .5,
                                                child: MyText(
                                                  title: widget.meats[index]
                                                      ["championname"],
                                                  size: 13,
                                                  color: MyColors.primary,
                                                  maxLines: 1,
                                                  textOverflow: TextOverflow.ellipsis,
                                                  alien: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 100,
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: MyColors.yellow,
                                                        width: 1)),
                                                child: Container(
                                                  color: MyColors.yellow,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 47,
                                                            height: 50,
                                                            color: MyColors.primary,
                                                            alignment: Alignment.center,
                                                            child: MyText(
                                                              title: widget.meats[index]
                                                                      ["resulthost"]
                                                                  .toString(),
                                                              size: 14,
                                                              color: MyColors.white,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 45,
                                                            height: 50,
                                                            color: MyColors.yellow,
                                                            alignment: Alignment.center,
                                                            child: MyText(
                                                              title: widget.meats[index]
                                                                      ["resultaway"]
                                                                  .toString(),
                                                              size: 14,
                                                              color: MyColors.primary,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: MyColors.yellow,
                                                            border: Border.all(
                                                                color: MyColors.white,
                                                                width: .5)),
                                                        alignment: Alignment.center,
                                                        child: MyText(
                                                          title: "VS",
                                                          size: 10,
                                                          color: MyColors.darken,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              MyText(
                                                title: widget.meats[index]["date"]
                                                    .toString(),
                                                size: 12,
                                                color: Colors.black,
                                              ),
                                              MyText(
                                                title: widget.meats[index]["teamaway"],
                                                size: 12,
                                                color: Colors.black,
                                              ),
                                              MyText(
                                                title:
                                                    "(${widget.meats[index]["countryAway"]})",
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
