import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:score/Bloc/DaysModel.dart';
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
class Today extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  Today(
    this._scafold,
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<Today> {
  var _champions = [];
  var _fav = [];
  bool _loading = true;
//  var _allData = [];
//  Future _getHome() async {
//    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    var _lang = _prefs.get("lang");
//    var _user = _prefs.get("user");
//    final model = Provider.of<AddFavouriteModel>(context);
//    final days = Provider.of<DaysModel>(context);
//    model.playedMatches.clear();
//    model.notPlayedMatches.clear();
//    var today = DateTime.now();
//    var date = DateFormat("dd/MM/yyyy").format(today);
//    var body = {
//      "user_id": "${_user ?? ""}",
//      "date": date.toString(),
//      "lang": "$_lang",
//    };
//    var _data = await Http(widget._scafold, )
//        .get("AppApi/GetFavourites", body, context);
//    if (_data["key"] == 1) {
//      model.setPlayedMatches(_data["played"]);
//      model.setNotPlayedMatches(_data["not_played"]);
//      _allData = _data["data"];
//      _loading = false;
//      days.setDays([]);
//      days.setDays(_data["data"]);
//    } else {
//      LoadingDialog(widget._scafold, )
//          .showNotification("${_data["msg"]}");
//    }
//  }
//
//  Future _removeFavouritePlayedMatches(matchID, championId, index) async {
//    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    final model = Provider.of<AddFavouriteModel>(context);
//    var _user = _prefs.get("user");
//    var _lang = _prefs.get("lang");
//    var body = {
//      "user_id": "$_user",
//      "match_id": "$matchID",
//      "champion_id": "$championId",
//      "lang": "$_lang",
//    };
//    var _data = await Http(widget._scafold, )
//        .post("AppApi/AddMatchToFavouritOrRemove", body, context);
//    if (_data["key"] == 1) {
//      model.removePlayedMatches(index);
//    } else {
//      LoadingDialog(widget._scafold, )
//          .showNotification(_data["msg"]);
//    }
//  }
//
//  Future _removeFavouriteNotPlayedMatches(matchID, championId, index) async {
//    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    final model = Provider.of<AddFavouriteModel>(context);
//    var _user = _prefs.get("user");
//    var _lang = _prefs.get("lang");
//    var body = {
//      "user_id": "$_user",
//      "match_id": "$matchID",
//      "champion_id": "$championId",
//      "lang": "$_lang",
//    };
//    var _data = await Http(widget._scafold, )
//        .post("AppApi/AddMatchToFavouritOrRemove", body, context);
//    if (_data["key"] == 1) {
//      model.removeNotPlayedMatches(index);
//    } else {
//      LoadingDialog(widget._scafold, )
//          .showNotification(_data["msg"]);
//    }
//  }
  Future _getHome() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var today = DateTime.now();
    var date = DateFormat("dd/MM/yyyy").format(today);
    var body = {
      "user_id": "$_user",
      "date": date.toString(),
      "lang": "$_lang",
      "mytime": today.timeZoneOffset.inHours.toString(),
    };
    var _data = await Http(
      widget._scafold,
    ).get("AppApi/GetFavourites", body, context);
    if (_data["key"] == 1) {
      final model = Provider.of<AddFavouriteModel>(context);
      final days = Provider.of<DaysModel>(context);
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
      final model = Provider.of<AddFavouriteModel>(context);
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
    _getHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final model = Provider.of<AddFavouriteModel>(context);
//    final landScape =
//        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        backgroundColor: MyColors.white,
        body: _loading
            ? Container(
                child: Center(
                  child: LoadingDialog(
                    widget._scafold,
                  ).showLoadingView(),
                ),
              )
            : model.matches.length == 0
                ? RefreshIndicator(
                    backgroundColor: MyColors.primary,
                    onRefresh: () => _getHome(),
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
                    onRefresh: () => _getHome(),
                    backgroundColor: MyColors.back_red,
                    child: Container(
                      child: ListView.builder(
                          itemCount: model.matches.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      SlideRightRoute(
                                          page: League(
                                        championId: model.matches[index]
                                            ["ChampionId"],
                                        typeId: model.matches[index]["CupType"],
                                        gameType: model.matches[index]
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
                                          image: NetworkImage(
                                              model.matches[index]["Img"]),
                                          width: 25,
                                          height: 20,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        MyText(
                                          title: model.matches[index]
                                              ["ChampionName"],
                                          size: 13,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image(
                                          image: model.matches[index]
                                                      ["ChampionType"] ==
                                                  1
                                              ? AssetImage(
                                                  "images/basket_ball.png")
                                              : model.matches[index]
                                                          ["ChampionType"] ==
                                                      2
                                                  ? AssetImage(
                                                      "images/vollyBall.png")
                                                  : model.matches[index][
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
                                                  championId:
                                                      model.matches[index]
                                                          ["ChampionId"],
                                                  typeId: model.matches[index]
                                                      ["CupType"],
                                                  gameType: model.matches[index]
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
                                      model
                                          .matches[index]
                                              ["AppHomeViewModelMatch"]
                                          .length, (i) {
                                    return Container(
                                      color: Color(0xffffc400).withOpacity(.1),
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
                                                            .withOpacity(.2),
                                                        width: 2))),
                                            child: InkWell(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  SlideRightRoute(
                                                      page: MatchDetails(
                                                    matchId: model
                                                                .matches[index][
                                                            "AppHomeViewModelMatch"]
                                                        [i]["MatchId"],
                                                    championId:
                                                        model.matches[index]
                                                            ["ChampionId"],
                                                    typeId: model.matches[index]
                                                        ["CupType"],
                                                    gameType:
                                                        model.matches[index]
                                                            ["ChampionType"],
                                                  ))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      _addFavourite(
                                                          model.matches[index][
                                                                  "AppHomeViewModelMatch"]
                                                              [i]["MatchId"],
                                                          model.matches[index]
                                                              ["ChampionId"],
                                                          index,
                                                          i);
                                                    },
                                                    child: Icon(
                                                      model.favourites[index]
                                                                      ["list"]
                                                                  [i]["fav"] ==
                                                              "true"
                                                          ? Icons.star
                                                          : Icons.star_border,
                                                      size: 25,
                                                      color: MyColors.primary,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .2,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        MyText(
                                                          title: model.matches[
                                                                      index][
                                                                  "AppHomeViewModelMatch"]
                                                              [
                                                              i]["HomeTeamName"],
                                                          size: 12,
                                                          color: Colors.black,
                                                        ),
                                                        MyText(
                                                          title:
                                                              "(${model.matches[index]["AppHomeViewModelMatch"][i]["HomeTeamCountry"]})",
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
                                                                  title: model
                                                                      .matches[
                                                                          index]
                                                                          [
                                                                          "AppHomeViewModelMatch"]
                                                                          [i][
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
                                                                  title: model
                                                                      .matches[
                                                                          index]
                                                                          [
                                                                          "AppHomeViewModelMatch"]
                                                                          [i][
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
                                                            alignment: Alignment
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .2,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        MyText(
                                                          title: model.matches[
                                                                      index][
                                                                  "AppHomeViewModelMatch"]
                                                              [
                                                              i]["AwayTeamName"],
                                                          size: 12,
                                                          color: Colors.black,
                                                        ),
                                                        MyText(
                                                          title:
                                                              "(${model.matches[index]["AppHomeViewModelMatch"][i]["AwayTeamCountry"]})",
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
                                                        title: model
                                                            .matches[index][
                                                                "AppHomeViewModelMatch"]
                                                                [i]["Time"]
                                                            .toString(),
                                                        size: 10,
                                                        color: MyColors.primary,
                                                      ),
                                                      MyText(
                                                        title: model.matches[
                                                                            index]
                                                                        [
                                                                        "AppHomeViewModelMatch"][i]
                                                                    [
                                                                    "IsPlay"] ==
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
                  ));
  }
}
