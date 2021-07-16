import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score/Bloc/DaysModel.dart';
import 'package:score/Bloc/addFavoriteModel.dart';
import 'package:score/customer/League.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../MatchDetails.dart';

// ignore: must_be_immutable
class PreviousDay extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  var date, month, year;

  PreviousDay(this._scafold, this.date, this.month, this.year);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<PreviousDay> {
  FirebaseMessaging _firebaseMessaging =  FirebaseMessaging.instance;
  bool _loading = true;
  var _champions = [];
  var _fav = [];

  Future _getHome() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final model = Provider.of<AddFavouriteModel>(context,listen: false);
    final days = Provider.of<DaysModel>(context,listen: false);
    var _user = _prefs.get("user");
    // var year = DateTime.now().year;
    String date = "${widget.date}/${widget.month}/${widget.year}";
    var _lang = _prefs.get("lang");
    var _token = await _firebaseMessaging.getToken();
    print("year ${int.parse(widget.year)}");
    var body = {
      "user_id": "$_user",
      "date": "$date",
      "token": "$_token",
      "lang": "$_lang",
      "mytime": DateTime(int.parse(widget.year), int.parse(widget.month),
              int.parse(widget.date))
          .timeZoneOffset
          .inHours
          .toString(),
    };
    print("prev date $date");
    var _data = await Http(
      widget._scafold,
    ).get("AppApi/Home", body, context);
    if (_data["key"] == 1) {
      setState(() {
        _champions = _data["data"];
        _loading = false;
      });
      model.favourites.clear();
      days.setDays(_champions);

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
      model.setFav(_fav);
    } else {
      LoadingDialog(
        widget._scafold,
      ).showNotification("${_data["msg"]}");
    }
  }

  Future _addFavourite(matchID, championId, index, q) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final model = Provider.of<AddFavouriteModel>(context,listen: false);
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
      model.changeFav(index, q);
    } else {
      LoadingDialog(
        widget._scafold,
      ).showNotification(_data["msg"]);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200),(){
      _getHome();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final model = Provider.of<AddFavouriteModel>(context);
//    final landScape=MediaQuery.of(context).orientation==Orientation.portrait;
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
            : _champions.length == 0 || _champions.length == null
                ? RefreshIndicator(
                    backgroundColor: MyColors.back_red,
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
                    backgroundColor: MyColors.primary,
                    child: Container(
                      child: ListView.builder(
                          itemCount: _champions.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        SlideRightRoute(
                                            page: League(
                                          championId: _champions[index]
                                              ["ChampionId"],
                                          typeId: _champions[index]["CupType"],
                                          gameType: _champions[index]
                                              ["ChampionType"],
                                        )));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image(
                                          image: NetworkImage(
                                              _champions[index]["Img"]),
                                          width: 25,
                                          height: 20,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        MyText(
                                          title: _champions[index]
                                              ["ChampionName"],
                                          size: 13,
                                          color: Colors.black,
                                          maxLines: 1,
                                          textOverflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image(
                                          image: _champions[index]
                                                      ["ChampionType"] ==
                                                  1
                                              ? AssetImage(
                                                  "images/basket_ball.png")
                                              : _champions[index]
                                                          ["ChampionType"] ==
                                                      2
                                                  ? AssetImage(
                                                      "images/vollyBall.png")
                                                  : _champions[index][
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
                                                  championId: _champions[index]
                                                      ["ChampionId"],
                                                  typeId: _champions[index]
                                                      ["CupType"],
                                                  gameType: _champions[index]
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
                                      _champions[index]["AppHomeViewModelMatch"]
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
                                                    matchId: _champions[index][
                                                            "AppHomeViewModelMatch"]
                                                        [i]["MatchId"],
                                                    championId:
                                                        _champions[index]
                                                            ["ChampionId"],
                                                    typeId: _champions[index]
                                                        ["CupType"],
                                                    gameType: _champions[index]
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
                                                          _champions[index][
                                                                  "AppHomeViewModelMatch"]
                                                              [i]["MatchId"],
                                                          _champions[index]
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
                                                          title: _champions[
                                                                      index][
                                                                  "AppHomeViewModelMatch"]
                                                              [
                                                              i]["HomeTeamName"],
                                                          size: 12,
                                                          color: Colors.black,
                                                        ),
                                                        MyText(
                                                          title:
                                                              "(${_champions[index]["AppHomeViewModelMatch"][i]["HomeTeamCountry"]})",
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
                                                                  title: _champions[index]["AppHomeViewModelMatch"]
                                                                              [
                                                                              i]
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
                                                                  title: _champions[index]["AppHomeViewModelMatch"]
                                                                              [
                                                                              i]
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
                                                          title: _champions[
                                                                      index][
                                                                  "AppHomeViewModelMatch"]
                                                              [
                                                              i]["AwayTeamName"],
                                                          size: 12,
                                                          color: Colors.black,
                                                        ),
                                                        MyText(
                                                          title:
                                                              "(${_champions[index]["AppHomeViewModelMatch"][i]["AwayTeamCountry"]})",
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
                                                        title: _champions[index]
                                                                    [
                                                                    "AppHomeViewModelMatch"]
                                                                [i]["Time"]
                                                            .toString(),
                                                        size: 10,
                                                        color: MyColors.primary,
                                                      ),
                                                      MyText(
                                                        title: _champions[index]
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
