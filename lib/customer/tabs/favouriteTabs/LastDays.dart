import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:score/Bloc/DaysModel.dart';
import 'package:score/Bloc/FavouriteModel.dart';
import 'package:score/Bloc/addFavoriteModel.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../League.dart';
import '../../MatchDetails.dart';

// ignore: must_be_immutable
class LastDays extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  LastDays(
    this._scafold,
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<LastDays> {
  GlobalKey<ScaffoldState> _currentScafold = new GlobalKey<ScaffoldState>();
  bool _loading = true;
  var _days = [];
  var _champions = [];
  var _fav = [];
  var _dayIndex;
  var _monthIndex;
  bool chooseDate = false;
  int _year;
  Future _getHome(day, month) async {
    setState(() {
      chooseDate = true;
      _loading = true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    final favourite = Provider.of<AddFavouriteModel>(context,listen: false);
    favourite.playedMatches.clear();
    favourite.notPlayedMatches.clear();

    String date = "$day/$month/$_year";
    var body = {
      "user_id": "$_user",
      "date": "$date",
      "lang": "$_lang",
      "mytime": DateTime(
        _year,
        int.parse(month),
        int.parse(day),
      ).timeZoneOffset.inHours.toString(),
    };
    var _data = await Http(
      widget._scafold,
    ).get("AppApi/GetFavourites", body, context);
    if (_data["key"] == 1) {
      final model = Provider.of<AddFavouriteModel>(context,listen: false);
      final days = Provider.of<DaysModel>(context,listen: false);
      days.setDays(_data["data"]);
      setState(() {
        _champions = _data["data"];
        _loading = false;
      });
      for (int i = 0; i < _champions.length; i++) {
        _fav.add({"id": "${_champions[i]["ChampionId"]}", "list": new List()});
      }
      for (int i = 0; i < _champions.length; i++) {
        for (int index = 0;
            index < _champions[i]["AppHomeViewModelMatch"].length;
            index++) {
          _fav[i]["list"].add({
            "fav":
                "${_champions[i]["AppHomeViewModelMatch"][index]["Favourite"]}"
          });
        }
      }
      model.setMatches(_champions);
      model.setFav(_fav);
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  _setDate() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _lang = _prefs.get("lang");
    var today = DateTime.now();
    for (int i = 2; i <= 7; i++) {
      var _prevYear =
          DateFormat('yyyy', "en").format(today.subtract(Duration(days: i)));
      var _prevNum =
          DateFormat('dd', "en").format(today.subtract(Duration(days: i)));
      var _prevName = DateFormat('EEEE', "$_lang")
          .format(today.subtract(Duration(days: i)));
      var _prevMonth =
          DateFormat('MM', "en").format(today.subtract(Duration(days: i)));
      bool selected = (i == 2) ? true : false;
      _days.add({
        "name": "$_prevName",
        "num": "$_prevNum",
        "selected": selected,
        "_prevMonth": "$_prevMonth",
        "year": "$_prevYear"
      });
    }
    setState(() {});
  }

  Future _addFavourite(matchID, championId, index, q) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "match_id": "$matchID",
      "champion_id": "$championId",
      "lang": "$_lang",
    };
    var _data = await Http(
      widget._scafold,
    ).post("AppApi/AddMatchToFavouritOrRemove", body, context);
    if (_data["key"] == 1) {
      final model = Provider.of<AddFavouriteModel>(context,listen: false);
      model.removeMatches(index, q);
      if (model.matches[index]["AppHomeViewModelMatch"].length == 0 ||
          model.matches[index]["AppHomeViewModelMatch"].length == null) {
        model.removeMatch(index);
        for (int i = 0; i < model.matches.length; i++) {
          for (int index = 0;
              index < model.matches[i]["AppHomeViewModelMatch"].length;
              index++) {
            _fav[i]["list"].add({
              "fav":
                  "${model.matches[i]["AppHomeViewModelMatch"][index]["Favourite"]}"
            });
          }
        }
      } else {
        for (int i = 0; i < model.matches.length; i++) {
          for (int index = 0;
              index < model.matches[i]["AppHomeViewModelMatch"].length;
              index++) {
            _fav[i]["list"].add({
              "fav":
                  "${model.matches[i]["AppHomeViewModelMatch"][index]["Favourite"]}"
            });
          }
        }
      }
    } else {
      LoadingDialog(
        widget._scafold,
      ).showNotification(_data["msg"]);
    }
  }

  @override
  void initState() {
    super.initState();
    _setDate();
  }

  _setSelectedDay(index) {
    final model = Provider.of<FavouriteModel>(context,listen: false);
    _days.forEach((obj) {
      obj["selected"] = false;
    });
    _days[index]["selected"] = true;
    model.changePrev(false);
    setState(() {
      _year = int.parse(_days[index]["year"]);
    });
    _getHome(_days[index]["num"], _days[index]["_prevMonth"]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final model = Provider.of<FavouriteModel>(context);
    final favourite = Provider.of<AddFavouriteModel>(context);
//    final landScape=MediaQuery.of(context).orientation==Orientation.portrait;
    return Scaffold(
      key: _currentScafold,
      backgroundColor: MyColors.white,
      body: Stack(
        children: <Widget>[
          chooseDate == false
              ? Container(
                  child: Center(
                      child: MyText(
                    title: "${tr("chooseDate")}",
                  )),
                )
              : _loading
                  ? Container(
                      child: Center(
                        child: LoadingDialog(
                          widget._scafold,
                        ).showLoadingView(),
                      ),
                    )
                  : favourite.matches.length == 0 ||
                          favourite.matches.length == null
                      ? RefreshIndicator(
                          backgroundColor: MyColors.back_red,
                          onRefresh: () => _getHome(_dayIndex, _monthIndex),
                          child: ListView(
                            itemExtent: 400,
                            children: <Widget>[
                              Center(
                                child: MyText(
                                  title: "${tr("noMatchesToday")}",
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () => _getHome(_dayIndex, _monthIndex),
                          backgroundColor: MyColors.primary,
                          child: Container(
                            child: ListView.builder(
                                itemCount: favourite.matches.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            SlideRightRoute(
                                                page: League(
                                              championId: favourite
                                                  .matches[index]["ChampionId"],
                                              typeId: favourite.matches[index]
                                                  ["CupType"],
                                              gameType: favourite.matches[index]
                                                  ["ChampionType"],
                                            ))),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image(
                                                image: NetworkImage(favourite
                                                    .matches[index]["Img"]),
                                                width: 25,
                                                height: 20,
                                                fit: BoxFit.fill,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              MyText(
                                                title: favourite.matches[index]
                                                    ["ChampionName"],
                                                size: 13,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Image(
                                                image: favourite.matches[index]
                                                            ["ChampionType"] ==
                                                        1
                                                    ? AssetImage(
                                                        "images/basket_ball.png")
                                                    : favourite.matches[index][
                                                                "ChampionType"] ==
                                                            2
                                                        ? AssetImage(
                                                            "images/vollyBall.png")
                                                        : favourite.matches[
                                                                        index][
                                                                    "ChampionType"] ==
                                                                3
                                                            ? AssetImage(
                                                                "images/handBall.png")
                                                            : AssetImage(
                                                                "images/tensBall.png"),
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.fill,
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      SlideRightRoute(
                                                          page: League(
                                                        championId: favourite
                                                                .matches[index]
                                                            ["ChampionId"],
                                                        typeId: favourite
                                                                .matches[index]
                                                            ["CupType"],
                                                        gameType: favourite
                                                                .matches[index]
                                                            ["ChampionType"],
                                                      )));
                                                },
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 20,
                                                  color: MyColors.primary,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                            favourite
                                                .matches[index]
                                                    ["AppHomeViewModelMatch"]
                                                .length, (i) {
                                          return Container(
                                            color: Color(0xffffc400)
                                                .withOpacity(.1),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10,
                                                      left: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      .2),
                                                              width: 2))),
                                                  child: InkWell(
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        SlideRightRoute(
                                                            page: MatchDetails(
                                                          matchId: favourite
                                                                          .matches[
                                                                      index][
                                                                  "AppHomeViewModelMatch"]
                                                              [i]["MatchId"],
                                                          championId: favourite
                                                                      .matches[
                                                                  index]
                                                              ["ChampionId"],
                                                          typeId: favourite
                                                                  .matches[
                                                              index]["CupType"],
                                                          gameType: favourite
                                                                      .matches[
                                                                  index]
                                                              ["ChampionType"],
                                                        ))),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () {
                                                            _addFavourite(
                                                                favourite.matches[
                                                                            index]
                                                                        [
                                                                        "AppHomeViewModelMatch"][i]
                                                                    ["MatchId"],
                                                                favourite.matches[
                                                                        index][
                                                                    "ChampionId"],
                                                                index,
                                                                i);
                                                          },
                                                          child: Icon(
                                                            favourite.favourites[index]
                                                                            [
                                                                            "list"][i]
                                                                        [
                                                                        "fav"] ==
                                                                    "true"
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border,
                                                            size: 25,
                                                            color: MyColors
                                                                .primary,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .2,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              MyText(
                                                                title: favourite
                                                                            .matches[index]
                                                                        [
                                                                        "AppHomeViewModelMatch"][i]
                                                                    [
                                                                    "HomeTeamName"],
                                                                size: 12,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              MyText(
                                                                title:
                                                                    "(${favourite.matches[index]["AppHomeViewModelMatch"][i]["HomeTeamCountry"]})",
                                                                size: 10,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          width: 100,
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: MyColors
                                                                      .yellow,
                                                                  width: 1)),
                                                          child: Container(
                                                            color:
                                                                MyColors.yellow,
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      width: 47,
                                                                      height:
                                                                          50,
                                                                      color: MyColors
                                                                          .primary,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          MyText(
                                                                        title: favourite
                                                                            .matches[index]["AppHomeViewModelMatch"][i]["HomeTeamGoals"]
                                                                            .toString(),
                                                                        size:
                                                                            14,
                                                                        color: MyColors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: 45,
                                                                      height:
                                                                          50,
                                                                      color: MyColors
                                                                          .yellow,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          MyText(
                                                                        title: favourite
                                                                            .matches[index]["AppHomeViewModelMatch"][i]["AwayTeamGoals"]
                                                                            .toString(),
                                                                        size:
                                                                            14,
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
                                                                          width:
                                                                              .5)),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: MyText(
                                                                    title: "VS",
                                                                    size: 10,
                                                                    color: MyColors
                                                                        .darken,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .2,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              MyText(
                                                                title: favourite
                                                                            .matches[index]
                                                                        [
                                                                        "AppHomeViewModelMatch"][i]
                                                                    [
                                                                    "AwayTeamName"],
                                                                size: 12,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              MyText(
                                                                title:
                                                                    "(${favourite.matches[index]["AppHomeViewModelMatch"][i]["AwayTeamCountry"]})",
                                                                size: 10,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            MyText(
                                                              title: favourite
                                                                  .matches[
                                                                      index][
                                                                      "AppHomeViewModelMatch"]
                                                                      [i]
                                                                      ["Time"]
                                                                  .toString(),
                                                              size: 10,
                                                              color: MyColors
                                                                  .primary,
                                                            ),
                                                            MyText(
                                                              title: favourite.matches[index]["AppHomeViewModelMatch"]
                                                                              [
                                                                              i]
                                                                          [
                                                                          "IsPlay"] ==
                                                                      false
                                                                  ? ""
                                                                  : "${tr("fullTime")}",
                                                              size: 10,
                                                              color: MyColors
                                                                  .primary,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ),
          Visibility(
            child: Scaffold(
              backgroundColor: Colors.black54.withOpacity(.3),
              body: ListView(
                children: <Widget>[
                  Container(
                    color: MyColors.white,
                    height: 70,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      children: List.generate(_days.length, (index) {
                        return InkWell(
                          onTap: () {
                            _setSelectedDay(index);
                            _getHome(_days[index]["num"],
                                _days[index]["_prevMonth"]);
                            setState(() {
                              _dayIndex = "${_days[index]["num"]}";
                              _monthIndex = "${_days[index]["_prevMonth"]}";
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .2,
                            color: (_days[index]["selected"])
                                ? MyColors.primary
                                : MyColors.white,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MyText(
                                  title: "${_days[index]["name"]}",
                                  size: 14,
                                  color: (_days[index]["selected"])
                                      ? MyColors.white
                                      : MyColors.darken,
                                ),
                                MyText(
                                  title: "${_days[index]["num"]}",
                                  size: 14,
                                  color: (_days[index]["selected"])
                                      ? MyColors.white
                                      : MyColors.darken,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            visible: model.showPrev,
          )
        ],
      ),
    );
  }
}
