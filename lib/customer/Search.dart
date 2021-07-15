import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score/Bloc/DaysModel.dart';
import 'package:score/customer/Home.dart';
import 'package:score/customer/League.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';

import 'MatchDetails.dart';

// ignore: must_be_immutable
class Search extends StatefulWidget {
  var index;
  Search({this.index});
  //  لو بيساوي 1 يبقي من الجدول العام لو 2 يبقي من المفضلة
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<Search> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var _listSearch = [];
  TextEditingController _search = TextEditingController();

//  Future _addFavourite(matchID, championId, index, q) async {
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
//    var _data = await Http(_scafold)
//        .post("AppApi/AddMatchToFavouritOrRemove", body, context);
//    if (_data["key"] == 1) {
//      model.changeFav(index, q);
//    } else {
//      LoadingDialog(_scafold).showNotification(_data["msg"]);
//    }
//  }
//
//  Future _removeFavouriteNotPlayedMatches(matchID, championId, index) async {
//    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    var _user = _prefs.get("user");
//    var _lang = _prefs.get("lang");
//    var body = {
//      "user_id": "$_user",
//      "match_id": "$matchID",
//      "champion_id": "$championId",
//      "lang": "$_lang",
//    };
//    var _data = await Http(_scafold)
//        .post("AppApi/AddMatchToFavouritOrRemove", body, context);
//    if (_data["key"] == 1) {
//      _listSearch.removeAt(index);
//    } else {
//      LoadingDialog(_scafold).showNotification(_data["msg"]);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final days = Provider.of<DaysModel>(context);

    final landScape =
        MediaQuery.of(context).orientation == Orientation.portrait;
//    final model = Provider.of<AddFavouriteModel>(context);
    return Container(
      child: Scaffold(
        key: _scafold,
        appBar: PreferredSize(
            child: Container(
              color: MyColors.primary,
              padding: EdgeInsets.only(top: 40, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 48,
                    decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: TextFormField(
                      controller: _search,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "cairo",
                          color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColors.grey.withOpacity(.5),
                                  width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyColors.yellow, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          hintText: "  ${tr("search")} ",
                          hintStyle: TextStyle(
                              fontFamily: "cairo",
                              fontSize: 12,
                              color: MyColors.grey),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14)),
                      onChanged: (val) {
                        setState(() {
                          for (int i = 0; i < days.daysList.length; i++) {
                            if (widget.index == 2) {
                              _listSearch = days.daysList
                                  .where((x) => x["ChampionName"]
                                      .toLowerCase()
                                      .contains(val))
                                  .toList();
                            } else {
                              _listSearch = days.daysList
                                  .where((x) => x["ChampionName"]
                                      .toLowerCase()
                                      .contains(val))
                                  .toList();
                            }
                          }
                        });
                        if (_search.text.trim().isEmpty) {
                          setState(() {
                            _listSearch = [];
                          });
                        }
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () => widget.index == 2
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            SlideRightRoute(
                                page: Home(
                              forFav: 1,
                            )),
                            (Route<dynamic> route) => false)
                        : Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 50,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.clear,
                        size: 20,
                        color: MyColors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            preferredSize: Size.fromHeight(80)),
        body: ListView.builder(
            itemCount: _listSearch.length,
            itemBuilder: (context, index) {
              return widget.index == 2
                  ? InkWell(
                      onTap: () => Navigator.push(
                          context,
                          SlideRightRoute(
                              page: MatchDetails(
                            matchId: _listSearch[index]["match"]["match_id"],
                            championId: _listSearch[index]["match"]
                                ["champion_id"],
                            typeId: _listSearch[index]["match"]["CupType"],
                            gameType: _listSearch[index]["match"]["type"],
                          ))),
                      child: Container(
                        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffffc400).withOpacity(.1),
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.withOpacity(.2),
                                    width: 2))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * .2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  MyText(
                                    title: _listSearch[index]["match"]
                                        ["home_name"],
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  MyText(
                                    title: _listSearch[index]["match"]
                                        ["home_country"],
                                    size: 12,
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
                                          width: 47,
                                          height: 50,
                                          color: MyColors.primary,
                                          alignment: Alignment.center,
                                          child: MyText(
                                            title: _listSearch[index]["match"]
                                                    ["home_goals"]
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
                                            title: _listSearch[index]["match"]
                                                    ["away_goals"]
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
                              width: MediaQuery.of(context).size.width * .2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  MyText(
                                    title: _listSearch[index]["match"]
                                        ["away_home"],
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  MyText(
                                    title: _listSearch[index]["match"]
                                            ["away_country"]
                                        .toString(),
                                    size: 12,
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
                                  title: _listSearch[index]["match"]["time"],
                                  size: 10,
                                  color: MyColors.primary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: League(
                                championId: _listSearch[index]["ChampionId"],
                                typeId: _listSearch[index]["CupType"],
                                gameType: _listSearch[index]["ChampionType"],
                              ))),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image:
                                      NetworkImage(_listSearch[index]["Img"]),
                                  width: 25,
                                  height: 20,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                MyText(
                                  title: _listSearch[index]["ChampionName"],
                                  size: 13,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image(
                                  image: _listSearch[index]["ChampionType"] == 1
                                      ? AssetImage("images/basket_ball.png")
                                      : _listSearch[index]["ChampionType"] == 2
                                          ? AssetImage("images/vollyBall.png")
                                          : _listSearch[index]
                                                      ["ChampionType"] ==
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
                                          championId: _listSearch[index]
                                              ["ChampionId"],
                                          typeId: _listSearch[index]["CupType"],
                                          gameType: _listSearch[index]
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
                              _listSearch[index]["AppHomeViewModelMatch"]
                                  .length, (i) {
                            return Container(
                              color: MyColors.back_red,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 5, bottom: 5),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xffffc400).withOpacity(.1),
                                        border: Border(
                                            bottom: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                width: 2))),
                                    child: InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          SlideRightRoute(
                                              page: MatchDetails(
                                            matchId: _listSearch[index]
                                                    ["AppHomeViewModelMatch"][i]
                                                ["MatchId"],
                                            championId: _listSearch[index]
                                                ["ChampionId"],
                                            typeId: _listSearch[index]
                                                ["CupType"],
                                            gameType: _listSearch[index]
                                                ["ChampionType"],
                                          ))),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
//                                              InkWell(
//                                                onTap: () {
//                                                  _addFavourite(
//                                                      _listSearch[index][
//                                                              "AppHomeViewModelMatch"]
//                                                          [i]["MatchId"],
//                                                      _listSearch[index]
//                                                          ["ChampionId"],
//                                                      index,
//                                                      i);
//                                                },
//                                                child: Icon(
//                                                  model.favourites[index]
//                                                                  ["list"][i]
//                                                              ["fav"] ==
//                                                          "true"
//                                                      ? Icons.star
//                                                      : Icons.star_border,
//                                                  size: 25,
//                                                  color: MyColors.primary,
//                                                ),
//                                              ),
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
                                                  title: _listSearch[index][
                                                          "AppHomeViewModelMatch"]
                                                      [i]["HomeTeamName"],
                                                  size: 12,
                                                  color: Colors.grey,
                                                ),
                                                MyText(
                                                  title: _listSearch[index][
                                                          "AppHomeViewModelMatch"]
                                                      [i]["HomeTeamCountry"],
                                                  size: 12,
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
                                                          title: _listSearch[
                                                                          index]
                                                                      [
                                                                      "AppHomeViewModelMatch"][i]
                                                                  [
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
                                                          title: _listSearch[
                                                                          index]
                                                                      [
                                                                      "AppHomeViewModelMatch"][i]
                                                                  [
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
                                                  title: _listSearch[index][
                                                          "AppHomeViewModelMatch"]
                                                      [i]["AwayTeamName"],
                                                  size: 12,
                                                  color: Colors.grey,
                                                ),
                                                MyText(
                                                  title: _listSearch[index][
                                                          "AppHomeViewModelMatch"]
                                                      [i]["AwayTeamCountry"],
                                                  size: 12,
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
                                                title: _listSearch[index][
                                                            "AppHomeViewModelMatch"]
                                                        [i]["Time"]
                                                    .toString(),
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
    );
  }
}
