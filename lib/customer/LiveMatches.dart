import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:score/customer/MatchDetails.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LiveMatches extends StatefulWidget {
  bool fav;

  LiveMatches(this.fav);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<LiveMatches> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var _teams = [];

//  var _heightPlayed, _heightNotPlayed;
  var played = [], notPlayed = [];
  bool _loading = true;

  Future _getData() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "lang": "$_lang",
      "favourite": "${widget.fav}"
    };
    var _data =
        await Http(_scafold).get("AppApi/GetMatchesToExpect", body, context);
    if (_data["key"] == 1) {
      setState(() {
        _teams = _data["appHomeViewModelMatches"];
        played = _data["played"];
        notPlayed = _data["not_played"];
        _loading = false;
//        _heightPlayed = .08 * _data["played"].length;
//        _heightNotPlayed = .08 * _data["not_played"].length;
      });
    } else {
      LoadingDialog(_scafold).showNotification(_data["msg"]);
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: Scaffold(
        key: _scafold,
        backgroundColor: MyColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 25),
          child: Container(
            height: kToolbarHeight + 25,
            color: MyColors.primary,
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () =>
                          Navigator.of(context).pushNamed("/allCompetations"),
                      child: Container(
                        margin: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Icon(
                          FontAwesomeIcons.trophy,
                          size: 20,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.update,
                          color: MyColors.white,
                          size: 25,
                        ),
                        onPressed: () => _getData())
                  ],
                ),
                Image(
                  image: AssetImage("images/scorelogo.png"),
                  fit: BoxFit.contain,
                  width: 100,
                  height: 50,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        child: Icon(
                          FontAwesomeIcons.clock,
                          size: 20,
                          color: MyColors.yellow,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed("/search"),
                      child: Container(
                        child: Icon(
                          Icons.search,
                          size: 25,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: _loading
            ? Container(
                child: Center(
                  child: LoadingDialog(_scafold).showLoadingView(),
                ),
              )
            : _teams.length == 0 || _teams.length == null
                ? RefreshIndicator(
                    backgroundColor: MyColors.primary,
                    onRefresh: () => _getData(),
                    child: ListView(
                      itemExtent: 600,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: MyText(
                              title: "${tr("noLiveMatches")}",
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: MyColors.primary,
                    onRefresh: () => _getData(),
                    child: ListView(
                      children: <Widget>[
                        _teams.length == 0 || _teams.length == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    MyText(
                                      title: "${tr("later")}",
                                      size: 12,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                        notPlayed.length == 0 || notPlayed.length == null
                            ? Container(
                                height: MediaQuery.of(context).size.height * .5,
                                child: Center(
                                  child: MyText(
                                    title:
                                        "${tr("noFavouriteMatchesInThisDate")}",
                                  ),
                                ),
                              )
                            : Container(
                                child: Column(
                                    children: List.generate(notPlayed.length,
                                        (index) {
                                  return InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        SlideRightRoute(
                                            page: MatchDetails(
                                          matchId: notPlayed[index]["MatchId"],
                                          championId: notPlayed[index]
                                              ["fk_subshampion"],
                                          typeId: notPlayed[index]
                                              ["type_champion"],
                                          gameType: notPlayed[index]
                                              ["type_game"],
                                        ))),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          top: 5,
                                          bottom: 5),
                                      decoration: BoxDecoration(
                                          color:
                                              Color(0xffffc400).withOpacity(.1),
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(.2),
                                                  width: 2))),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                MyText(
                                                  title: notPlayed[index]
                                                      ["HomeTeamName"],
                                                  size: 12,
                                                  color: Colors.black,
                                                ),
                                                MyText(
                                                  title:
                                                      "(${notPlayed[index]["HomeTeamCountry"]})",
                                                  size: 9,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 47,
                                                        height: 50,
                                                        color: MyColors.primary,
                                                        alignment:
                                                            Alignment.center,
                                                        child: MyText(
                                                          title: notPlayed[
                                                                      index][
                                                                  "HomeTeamGoals"]
                                                              .toString(),
                                                          size: 14,
                                                          color: MyColors.white,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 45,
                                                        height: 50,
                                                        color: MyColors.yellow,
                                                        alignment:
                                                            Alignment.center,
                                                        child: MyText(
                                                          title: notPlayed[
                                                                      index][
                                                                  "AwayTeamGoals"]
                                                              .toString(),
                                                          size: 14,
                                                          color:
                                                              MyColors.primary,
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
                                                            color:
                                                                MyColors.white,
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                MyText(
                                                  title: notPlayed[index]
                                                      ["AwayTeamName"],
                                                  size: 12,
                                                  color: Colors.black,
                                                ),
                                                MyText(
                                                  title:
                                                      "(${notPlayed[index]["AwayTeamCountry"].toString()})",
                                                  size: 9,
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
                                                title: notPlayed[index]["Time"],
                                                size: 10,
                                                color: MyColors.primary,
                                              ),
                                              MyText(
                                                title: notPlayed[index]
                                                            ["IsPlay"] ==
                                                        false
                                                    ? ""
                                                    : "${tr("fullTime")}",
                                                size: 10,
                                                color: MyColors.primary,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                              ),
                        played.length == 0 || played.length == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    MyText(
                                      title: "${tr("finished")}",
                                      size: 12,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                        played.length == 0 || played.length == null
                            ? Container()
                            : Column(
                                children: List.generate(played.length, (index) {
                                  return InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        SlideRightRoute(
                                            page: MatchDetails(
                                          matchId: played[index]["MatchId"],
                                          championId: played[index]
                                              ["fk_subshampion"],
                                          typeId: played[index]
                                              ["type_champion"],
                                          gameType: played[index]["type_game"],
                                        ))),
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: 10,
                                                left: 10,
                                                top: 5,
                                                bottom: 5),
                                            decoration: BoxDecoration(
                                                color: Color(0xffffc400)
                                                    .withOpacity(.1),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(.2),
                                                        width: 2))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      MyText(
                                                        title: played[index]
                                                            ["HomeTeamName"],
                                                        size: 12,
                                                        color: Colors.black,
                                                      ),
                                                      MyText(
                                                        title:
                                                            "(${played[index]["HomeTeamCountry"]})",
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
                                                          color:
                                                              MyColors.yellow,
                                                          width: 1)),
                                                  child: Container(
                                                    color: MyColors.yellow,
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: <Widget>[
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              width: 47,
                                                              height: 50,
                                                              color: MyColors
                                                                  .primary,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: MyText(
                                                                title: played[
                                                                            index]
                                                                        [
                                                                        "HomeTeamGoals"]
                                                                    .toString(),
                                                                size: 14,
                                                                color: MyColors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 45,
                                                              height: 50,
                                                              color: MyColors
                                                                  .yellow,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: MyText(
                                                                title: played[
                                                                            index]
                                                                        [
                                                                        "AwayTeamGoals"]
                                                                    .toString(),
                                                                size: 14,
                                                                color: MyColors
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: MyColors
                                                                  .yellow,
                                                              border: Border.all(
                                                                  color: MyColors
                                                                      .white,
                                                                  width: .5)),
                                                          alignment:
                                                              Alignment.center,
                                                          child: MyText(
                                                            title: "VS",
                                                            size: 10,
                                                            color:
                                                                MyColors.darken,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      MyText(
                                                        title: played[index]
                                                            ["AwayTeamName"],
                                                        size: 12,
                                                        color: Colors.black,
                                                      ),
                                                      MyText(
                                                        title:
                                                            "(${played[index]["AwayTeamCountry"]})",
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    MyText(
                                                      title: played[index]
                                                          ["Time"],
                                                      size: 10,
                                                      color: MyColors.primary,
                                                    ),
                                                    MyText(
                                                      title: played[index]
                                                                  ["IsPlay"] ==
                                                              false
                                                          ? ""
                                                          : "${tr("fullTime")}",
                                                      size: 12,
                                                      color: MyColors.primary,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              )
                      ],
                    ),
                  ),
      ),
    );
  }
}
//ListView.builder(
//                itemCount: _teams.length,
//                itemBuilder: (context, index) {
//                  return Container(
//                    padding: EdgeInsets.only(
//                        right: 5, left: 5, top: 5, bottom: 5),
//                    margin: EdgeInsets.only(right: 5, left: 5, top: 5),
//                    decoration: BoxDecoration(
//                      color: Color(0xffffc400).withOpacity(.1),
//                    ),
//                    child: InkWell(
//                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) => Expectations(
//                                championId: _teams[index]["fk_subshampion"],
//                                matchId: _teams[index]["MatchId"],
//                                team1Name: _teams[index]["HomeTeamName"],
//                                team2Name: _teams[index]["AwayTeamName"],
//                            type:_teams[index]["type_champion"],
//                            gameType: _teams[index]["type_game"],
//                              ))),
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            mainAxisAlignment: MainAxisAlignment.spaceAround,
//                            children: <Widget>[
//                              Column(
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                children: <Widget>[
//                                  MyText(
//                                    title: _teams[index]["HomeTeamName"],
//                                    size: 14,
//                                    color: Colors.black,
//                                  ),
//                                  MyText(
//                                    title:  "(${_teams[index]["HomeTeamCountry"]})",
//                                    size: 9,
//                                    color: Colors.black,
//                                  ),
//                                ],
//                              ),
//                              Column(
//                                children: <Widget>[
//                                  Container(
//                                    height: 40,
//                                    width: 100,
//                                    padding: EdgeInsets.all(2),
//                                    decoration: BoxDecoration(
//                                        border: Border.all(
//                                            color: MyColors.yellow, width: 1)),
//                                    child: Container(
//                                      color: MyColors.yellow,
//                                      child: Stack(
//                                        alignment: Alignment.center,
//                                        children: <Widget>[
//                                          Row(
//                                            crossAxisAlignment:
//                                                CrossAxisAlignment.start,
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.spaceBetween,
//                                            children: <Widget>[
//                                              Container(
//                                                width: 47,
//                                                height: 50,
//                                                color: MyColors.primary,
//                                                alignment: Alignment.center,
//                                                child: MyText(
//                                                  title: _teams[index]
//                                                          ["HomeTeamGoals"]
//                                                      .toString(),
//                                                  size: 14,
//                                                  color: MyColors.white,
//                                                ),
//                                              ),
//                                              Container(
//                                                width: 45,
//                                                height: 50,
//                                                color: MyColors.yellow,
//                                                alignment: Alignment.center,
//                                                child: MyText(
//                                                  title: _teams[index]
//                                                          ["AwayTeamGoals"]
//                                                      .toString(),
//                                                  size: 14,
//                                                  color: MyColors.primary,
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                          Container(
//                                            width: 20,
//                                            height: 20,
//                                            decoration: BoxDecoration(
//                                                shape: BoxShape.circle,
//                                                color: MyColors.yellow,
//                                                border: Border.all(
//                                                    color: MyColors.white,
//                                                    width: .5)),
//                                            alignment: Alignment.center,
//                                            child: MyText(
//                                              title: "VS",
//                                              size: 10,
//                                              color: Colors.black,
//                                            ),
//                                          )
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                  SizedBox(height: 2,),
//                                  Container(
//                                    height: 30,
//                                    width: 80,
//                                    decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(15),
//                                      border: Border.all(color: Colors.green)
//                                    ),
//                                    child: Center(
//                                      child: MyText(
//                                        title: "${tr("expectResult")}",
//                                        color: MyColors.primary,
//                                        size: 12,
//                                      ),
//                                    ),
//                                  )
//                                ],
//                              ),
//                              Column(
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                children: <Widget>[
//                                  MyText(
//                                    title: _teams[index]["AwayTeamName"],
//                                    size: 14,
//                                    color: Colors.black,
//                                  ),
//                                  MyText(
//                                    title: "(${_teams[index]["AwayTeamCountry"]})",
//                                    size: 9,
//                                    color: Colors.black,
//                                  ),
//                                  Container(
//                                    width: 55,
//                                    child: MyText(
//                                      title: _teams[index]["Time"].toString(),
//                                      size: 10,
//                                      color: MyColors.primary,
//                                    ),
//                                  ),
//                                ],
//                              ),
////                              Column(
////                                crossAxisAlignment: CrossAxisAlignment.end,
////                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                                children: <Widget>[
////                                  MyText(
////                                    title: _teams[index]["Time"].toString(),
////                                    size: 10,
////                                    color: MyColors.primary,
////                                  ),
////                                  MyText(
////                                    title: "",
////                                    size: 12,
////                                    color: MyColors.primary,
////                                  ),
////                                ],
////                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                  );
//                },
//              )
