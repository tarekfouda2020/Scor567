import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:score/Bloc/addLeagueFav.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../MatchDetails.dart';

// ignore: must_be_immutable
class Matches extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  var matches = [], tabs = [];
  var championID, typeId, gameId;

  Matches(this._scafold, this.matches, this.championID,
      this.typeId, this.gameId, this.tabs);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<Matches> {
  var count = 0;
  Future _addFavourite(matchID, index, val) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final model = Provider.of<FavLeague>(context);
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "match_id": "$matchID",
      "champion_id": "${widget.championID}",
      "lang": "$_lang",
    };

    var _data = await Http(widget._scafold, )
        .post("AppApi/AddMatchToFavouritOrRemove", body, context);
    if (_data["key"] == 1) {
      widget.typeId == 2
          ? model.addFavCup(count, index, val)
          : model.addFav(index, val);
    } else {
      LoadingDialog(widget._scafold, )
          .showNotification(_data["msg"]);
    }
  }

  Future _addFavouriteTennis(matchID, index, val, i) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final model = Provider.of<FavLeague>(context);
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "match_id": "$matchID",
      "champion_id": "${widget.championID}",
      "lang": "$_lang",
    };
    var _data = await Http(widget._scafold, )
        .post("AppApi/AddMatchToFavouritOrRemove", body, context);
    if (_data["key"] == 1) {
      model.addFavCupTennis(count, index, val, i);
    } else {
      LoadingDialog(widget._scafold, )
          .showNotification(_data["msg"]);
    }
  }

  @override
  void initState() {
    widget.typeId == 2
        ? widget.gameId == 4
            ? setState(() {
                widget.matches[0]["color"] = true;
              })
            : setState(() {
                widget.tabs[0]["Color"] = true;
              })
        : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FavLeague>(context);
    final landScape =
        MediaQuery.of(context).orientation == Orientation.portrait;
    model.setFav(widget.matches);
// TODO: implement build
    return widget.typeId == 2
//      لو اللبعه كاس
        ? widget.gameId == 4
//      لو هي تنس
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * .06,
                    color: Color(0xffffc400).withOpacity(.1),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.matches.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              count = index;
                              widget.matches[index]["color"] = true;
                              for (int x = 0; x < index; x++) {
                                setState(() {
                                  widget.matches[x]["color"] = false;
                                });
                              }
                              for (int x = widget.matches.length - 1;
                                  x > index;
                                  x--) {
                                setState(() {
                                  widget.matches[x]["color"] = false;
                                });
                              }
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color:
                                      widget.matches[index]["color"] == true ||
                                              widget.matches[index]["color"] ==
                                                  "true"
                                          ? MyColors.primary
                                          : MyColors.back_red,
                                ))),
                                child: Center(
                                  child: MyText(
                                    title: "${widget.matches[index]["name"]}",
                                    size: 12,
                                    color: widget.matches[index]["color"] ==
                                                true ||
                                            widget.matches[index]["color"] ==
                                                "true"
                                        ? Colors.green
                                        : Colors.black,
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Column(
                    children: List.generate(
                        widget.matches[count]["matches"].length, (index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: <Widget>[
                                  MyText(
                                    title: widget.matches[count]["matches"]
                                        [index]["Day"],
                                    size: 12,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  MyText(
                                    title: widget.matches[count]["matches"]
                                        [index]["date"],
                                    size: 12,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                widget
                                    .matches[count]["matches"][index]
                                        ["submatches"]
                                    .length, (i) {
                              return Container(
                                padding: EdgeInsets.only(
                                    right: 10, left: 10, top: 5.0, bottom: 5.0),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xffffc400).withOpacity(.1),
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.withOpacity(.2),
                                            width: 2))),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        SlideRightRoute(
                                            page: MatchDetails(
                                          matchId: widget.matches[count]
                                                  ["matches"][index]
                                              ["submatches"][i]["matchId"],
                                          championId: widget.championID,
                                          typeId: 1,
                                          gameType: widget.gameId,
                                        )));
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          _addFavouriteTennis(
                                              widget.matches[count]["matches"]
                                                      [index]["submatches"][i]
                                                  ["matchId"],
                                              index,
                                              !model.fav[count]["matches"]
                                                      [index]["submatches"][i]
                                                  ["Favourite"],
                                              i);
                                        },
                                        child: Icon(
                                          model.fav[count]["matches"][index]
                                                          ["submatches"][i]
                                                      ["Favourite"] ==
                                                  false
                                              ? Icons.star_border
                                              : Icons.star,
                                          size: 25,
                                          color: MyColors.primary,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            MyText(
                                              title: widget.matches[count]
                                                      ["matches"][index]
                                                  ["submatches"][i]["teamhost"],
                                              size: 10,
                                              color: Colors.black,
                                            ),
                                            MyText(
                                              title:
                                                  "(${widget.matches[count]["matches"][index]["submatches"][i]["Countryhost"]})",
                                              size: 10,
                                              color: Colors.grey,
                                            ),
                                          ],
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
                                                      title: widget
                                                          .matches[count]
                                                              ["matches"][index]
                                                              ["submatches"][i]
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
                                                      title: widget
                                                          .matches[count]
                                                              ["matches"][index]
                                                              ["submatches"][i]
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
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            MyText(
                                              title: widget.matches[count]
                                                      ["matches"][index]
                                                  ["submatches"][i]["teamaway"],
                                              size: 10,
                                              color: Colors.black,
                                            ),
                                            MyText(
                                              title:
                                                  "(${widget.matches[count]["matches"][index]["submatches"][i]["CountryAway"]})",
                                              size: 10,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          MyText(
                                            title: widget.matches[count]
                                                    ["matches"][index]
                                                    ["submatches"][i]["Time"]
                                                .toString(),
                                            size: 10,
                                            color: Colors.black,
                                            alien: TextAlign.center,
                                          ),
                                          MyText(
                                            title: widget.matches[count]
                                                                    ["matches"]
                                                                [index]
                                                            ["submatches"][i]
                                                        ["Isplay"] ==
                                                    false
                                                ? ""
                                                : "${tr("fullTime")}",
                                            size: 10,
                                            color: MyColors.primary,
                                            alien: TextAlign.center,
                                          ),
//                              MyText(
//                                title: widget.matches[count]["DoorName"][index]["Time"].toString(),
//                                size: 12,
//                                color: MyColors.primary,
//                              ),
//                        MyText(
//                          title: "${tr("fullTime")}",
//                          size: 12,
//                          color: MyColors.primary,
//                        ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      );
                    }),
                  )
                ],
              )
            :
//      لو كاس ومش تنس
            Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: Color(0xffffc400).withOpacity(.1),
                    height: landScape
                        ? MediaQuery.of(context).size.height * .05
                        : MediaQuery.of(context).size.height * .07,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.tabs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              count = index;
                              widget.tabs[index]["Color"] = true;
                              for (int x = 0; x < index; x++) {
                                setState(() {
                                  widget.tabs[x]["Color"] = false;
                                });
                              }
                              for (int x = widget.tabs.length - 1;
                                  x > index;
                                  x--) {
                                setState(() {
                                  widget.tabs[x]["Color"] = false;
                                });
                              }
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: widget.tabs[index]["Color"] == true ||
                                          widget.tabs[index]["Color"] == "true"
                                      ? MyColors.primary
                                      : MyColors.back_red,
                                ))),
                                child: Center(
                                  child: MyText(
                                    title: "${widget.tabs[index]["DoorName"]}",
                                    size: 12,
                                    color:
                                        widget.tabs[index]["Color"] == true ||
                                                widget.tabs[index]["Color"] ==
                                                    "true"
                                            ? Colors.green
                                            : Colors.black,
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Column(
                    children: List.generate(
                        widget.matches[count]["DoorName"].length, (index) {
                      return Container(
                        padding: EdgeInsets.only(
                            right: 10, left: 10, top: 5, bottom: 5),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffffc400).withOpacity(.1),
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffffc400).withOpacity(.1),
                                    width: 2))),
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: MatchDetails(
                                matchId: widget.matches[count]["DoorName"]
                                    [index]["matchId"],
                                championId: widget.championID,
                                typeId: widget.typeId,
                                gameType: widget.gameId,
                              ))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  _addFavourite(
                                      widget.matches[count]["DoorName"][index]
                                          ["matchId"],
                                      index,
                                      !model.fav[count]["DoorName"][index]
                                          ["Favourite"]);
                                },
                                child: Icon(
                                  model.fav[count]["DoorName"][index]
                                              ["Favourite"] ==
                                          false
                                      ? Icons.star_border
                                      : Icons.star,
                                  size: 25,
                                  color: MyColors.primary,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  MyText(
                                    title: widget.matches[count]["DoorName"]
                                        [index]["teamhost"],
                                    size: 10,
                                    color: Colors.black,
                                  ),
                                  MyText(
                                    title:
                                        "(${widget.matches[count]["DoorName"][index]["Countryhost"]})",
                                    size: 9,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 90,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MyColors.yellow, width: 1)),
                                child: Container(
                                  color: MyColors.yellow,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 40,
                                            height: 50,
                                            color: MyColors.primary,
                                            alignment: Alignment.center,
                                            child: MyText(
                                              title: widget.matches[count]
                                                      ["DoorName"][index]
                                                      ["resulthost"]
                                                  .toString(),
                                              size: 14,
                                              color: MyColors.white,
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            height: 50,
                                            color: MyColors.yellow,
                                            alignment: Alignment.center,
                                            child: MyText(
                                              title: widget.matches[count]
                                                      ["DoorName"][index]
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
                              Container(
                                width: MediaQuery.of(context).size.width * .15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    MyText(
                                      title: widget.matches[count]["DoorName"]
                                          [index]["teamaway"],
                                      size: 11,
                                      color: Colors.black,
                                    ),
                                    MyText(
                                      title:
                                          "(${widget.matches[count]["DoorName"][index]["CountryAway"]})",
                                      size: 9,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText(
                                    title: widget.matches[count]["DoorName"]
                                            [index]["Time"]
                                        .toString(),
                                    size: 10,
                                    color: Colors.black,
                                    alien: TextAlign.center,
                                  ),
                                  MyText(
                                    title: widget.matches[count]["DoorName"]
                                            [index]["date"]
                                        .toString(),
                                    size: 10,
                                    color: Colors.black,
                                    alien: TextAlign.center,
                                  ),
                                  MyText(
                                    title: widget.matches[count]["DoorName"]
                                                [index]["Isplay"] ==
                                            false
                                        ? ""
                                        : "${tr("fullTime")}",
                                    size: 10,
                                    color: MyColors.primary,
                                    alien: TextAlign.center,
                                  ),
//                              MyText(
//                                title: widget.matches[count]["DoorName"][index]["Time"].toString(),
//                                size: 12,
//                                color: MyColors.primary,
//                              ),
//                        MyText(
//                          title: "${tr("fullTime")}",
//                          size: 12,
//                          color: MyColors.primary,
//                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                ],
              )
        :
//      لو مش كاس اصلا
        Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.matches.length, (index) {
              return Container(
                padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Color(0xffffc400).withOpacity(.1),
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(.2), width: 2))),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      SlideRightRoute(
                          page: MatchDetails(
                        matchId: widget.matches[index]["MatchId"],
                        championId: widget.championID,
                        typeId: widget.typeId,
                        gameType: widget.gameId,
                      ))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _addFavourite(widget.matches[index]["MatchId"], index,
                              !model.fav[index]["Favourite"]);
                        },
                        child: Icon(
                          model.fav[index]["Favourite"] == false
                              ? Icons.star_border
                              : Icons.star,
                          size: 25,
                          color: MyColors.primary,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .18,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MyText(
                              title: widget.matches[index]["TeamHost"],
                              size: 12,
                              color: Colors.black,
                            ),
                            MyText(
                              title:
                                  "(${widget.matches[index]["Countryhost"]})",
                              size: 10,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: MyColors.yellow, width: 1)),
                        child: Container(
                          color: MyColors.yellow,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 47,
                                    height: 50,
                                    color: MyColors.primary,
                                    alignment: Alignment.center,
                                    child: MyText(
                                      title: widget.matches[index]
                                              ["ResultTeamHost"]
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
                                      title: widget.matches[index]
                                              ["ResultTeamAway"]
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
                                        color: MyColors.white, width: .5)),
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
                      Container(
                        width: MediaQuery.of(context).size.width * .18,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MyText(
                              title: widget.matches[index]["TeamAway"],
                              size: 12,
                              color: Colors.black,
                            ),
                            MyText(
                              title:
                                  "(${widget.matches[index]["CountryAway"]})",
                              size: 10,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MyText(
                            title: widget.matches[index]["Time"].toString(),
                            size: 10,
                            color: Colors.black,
                          ),
                          MyText(
                            title: widget.matches[index]["Date"].toString(),
                            size: 10,
                            color: Colors.black,
                          ),
                          MyText(
                            title: widget.matches[index]["IsPlay"] == false ||
                                    widget.matches[index]["IsPlay"] == "false"
                                ? ""
                                : "${tr("fullTime")}",
                            size: 10,
                            color: MyColors.primary,
                            alien: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
  }
}
