import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:score/Bloc/addOrRemoveFavouritePublicClub.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AddCompetionFav.dart';

// ignore: must_be_immutable
class Teams extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;


  Teams(this._scafold, );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<Teams> {
  var _teams = [];
  bool _loading = true;

  Future _getTeams() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final _favModel = Provider.of<AddOrRemoveFavouritePublicClub>(context);
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {"user_id": "$_user", "lang": "$_lang"};
    var _data = await Http(widget._scafold, )
        .get("AppApi/AllChampions", body, context);
    if (_data["key"] == 1) {
      setState(() {
        _teams = _data["tab2"];
        _loading = false;
      });
      _favModel.setFav(_data["tab2FavouritTeams"]);
    }
  }

  @override
  void initState() {
    _getTeams();
    super.initState();
  }

//  Future _removeFavFromFavourite(id, index) async {
//    final _favModel = Provider.of<AddOrRemoveFavouritePublicClub>(context);
//    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    var _user = _prefs.get("user");
//    var _lang = _prefs.get("lang");
//    var body = {"user_id": "$_user", "team_id": "$id", "lang": "$_lang"};
//    var _data = await Http(widget._scafold, )
//        .post("AppApi/AddTeamToFavouritOrRemove", body, context);
//    if (_data["key"] == 1) {
//      _favModel.removeFav(index);
//      await _getTeams();
//    } else {}
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final _favModel = Provider.of<AddOrRemoveFavouritePublicClub>(context);
    return Scaffold(
        backgroundColor: MyColors.white,
        body: _loading
            ? Container(
                child: Center(
                  child: LoadingDialog(widget._scafold, )
                      .showLoadingView(),
                ),
              )
            : ListView(
                children: <Widget>[
//                  _favModel.favourites.length == 0 ||
//                          _favModel.favourites.length == null
//                      ? Container()
//                      : Container(
//                    color: Color(0xffffc400).withOpacity(.1),
//                          padding: EdgeInsets.symmetric(
//                              horizontal: 10, vertical: 10),
//                          child: Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            children: <Widget>[
//                              MyText(
//                                title: tr("favouriteTeams"),
//                                size: 14,
//                                color: Colors.black,
//                              ),
//                              SizedBox(
//                                width: 10,
//                              ),
//                            ],
//                          ),
//                        ),
//                  _favModel.favourites.length == 0 ||
//                          _favModel.favourites.length == null
//                      ? Container()
//                      : Container(
//                          height: _favModel.favourites.length <= 1
//                              ? MediaQuery.of(context).size.height * .1
//                              : _favModel.favourites.length <= 2
//                                  ? MediaQuery.of(context).size.height * .2
//                                  : MediaQuery.of(context).size.height * .25,
//                          child: ListView.builder(
//                            itemCount: _favModel.favourites.length,
//                            itemBuilder: (context, i) {
//                              return Column(
//                                children: <Widget>[
//                                  InkWell(
//                                    onTap: () {
//                                      _removeFavFromFavourite(
//                                          _favModel.favourites[i]["id"], i);
//                                    },
//                                    child: Container(
//                                        height: 50,
//                                        decoration: BoxDecoration(
//                                            border: Border(
//                                                bottom: BorderSide(
//                                                    color: Color(0xffe1e1e1),
//                                                    width: 1))),
//                                        child: Row(
//                                          children: <Widget>[
//                                            SizedBox(
//                                              width: 8,
//                                            ),
//                                            MyText(
//                                              title: _favModel.favourites[i]
//                                                  ["name"],
//                                              size: 14,
//                                              color: Colors.black,
//                                            ),
//                                            Spacer(),
//                                            Checkbox(
//                                              value: true,
//                                              onChanged: (val) {
//                                                _removeFavFromFavourite(
//                                                    _favModel.favourites[i]
//                                                        ["id"],
//                                                    i);
//                                              },
//                                              activeColor: MyColors.yellow,
//                                              checkColor: MyColors.white,
//                                            )
//                                          ],
//                                        )),
//                                  ),
//                                ],
//                              );
//                            },
//                          )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(_teams.length, (index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            color: Color(0xffffc400).withOpacity(.1),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                MyText(
                                  title: _teams[index]["name"],
                                  size: 14,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image(
                                  image: _teams[index]["type"] == 1
                                      ? AssetImage("images/basket_ball.png")
                                      : _teams[index]["type"] == 2
                                          ? AssetImage("images/vollyBall.png")
                                          : _teams[index]["type"] == 3
                                              ? AssetImage(
                                                  "images/handBall.png")
                                              : AssetImage(
                                                  "images/tensBall.png"),
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                _teams[index]["main_champion"].length, (i) {
                              return Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          SlideRightRoute(
                                              page: AddCompetionFav(
                                                  _teams[index]["main_champion"]
                                                      [i]["sub_champion"],
                                                  _teams[index]["main_champion"]
                                                      [i]["name"],
                                                  2)));
                                    },
                                    child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Color(0xffe1e1e1),
                                                    width: 1))),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 8,
                                            ),
                                            MyText(
                                              title: _teams[index]
                                                  ["main_champion"][i]["name"],
                                              size: 14,
                                              color: Colors.black,
                                            ),
                                            Spacer(),
                                            Container(
                                              width: 40,
                                              height: 50,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Image(
                                                image: NetworkImage(
                                                    _teams[index]
                                                            ["main_champion"][i]
                                                        ["img"]),
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
//                                  Offstage(
//                                    offstage: _teams[index]["main_champion"][i]
//                                        ["choose"],
//                                    child: Container(
//                                      height: _teams[index]
//                                      ["main_champion"][i]
//                                      ["sub_champion"]
//                                          .length==1?
//                                      _teams[index]
//                                      ["main_champion"]
//                                      [i]["sub_champion"][_countSecond]
//                                      ["choose"]==false?
//                                      _teams[index][
//                                      "main_champion"][i]
//                                      [
//                                      "sub_champion"]
//                                      [_countSecond]["teams"].length==1?MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .12:_teams[index][
//                                      "main_champion"][i]
//                                      [
//                                      "sub_champion"]
//                                      [_countSecond]["teams"].length==2?MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .16:_teams[index][
//                                      "main_champion"][i]
//                                      [
//                                      "sub_champion"]
//                                      [_countSecond]["teams"].length==3?MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .2:MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .28:MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .08: _teams[index]
//                                      ["main_champion"][i]
//                                      ["sub_champion"]
//                                          .length==2?
//                                      _teams[index]
//                                      ["main_champion"]
//                                      [i]["sub_champion"][_countSecond]
//                                      ["choose"]==false?
//                                      _teams[index][
//                                      "main_champion"][i]
//                                      [
//                                      "sub_champion"]
//                                      [_countSecond]["teams"].length==1?MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .16:_teams[index][
//                                      "main_champion"][i]
//                                      [
//                                      "sub_champion"]
//                                      [_countSecond]["teams"].length==2?MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .18:_teams[index][
//                                      "main_champion"][i]
//                                      [
//                                      "sub_champion"]
//                                      [_countSecond]["teams"].length==3?MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .2:MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .2:MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .2: _teams[index]
//                                      ["main_champion"][i]
//                                      ["sub_champion"]
//                                          .length==3?
//                                      _teams[index]
//                                      ["main_champion"]
//                                      [i]["sub_champion"][_countSecond]
//                                      ["choose"]==false?
//                                      _teams[index][
//                                      "main_champion"][i]
//                                      [
//                                      "sub_champion"]
//                                      [_countSecond]["teams"].length==1?MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .15:_teams[index][
//                                      "main_champion"][i]
//                                      [
//                                      "sub_champion"]
//                                      [_countSecond]["teams"].length==2?MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .19:_teams[index][
//                                      "main_champion"][i]
//                                      [
//                                      "sub_champion"]
//                                      [_countSecond]["teams"].length==3?MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .22:MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .28:MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .23:MediaQuery.of(context)
//                                          .size
//                                          .height *
//                                          .33,
//                                      child: ListView.builder(
//                                          itemCount: _teams[index]
//                                                      ["main_champion"][i]
//                                                  ["sub_champion"]
//                                              .length,
//                                          itemBuilder: (BuildContext con, q) {
//                                            return Column(
//                                              children: <Widget>[
//                                                InkWell(
//
////                                                  ال on tap فيها check علي الفرق اللي هتبقي موجوده ف الدوري لو ب 0 يبقي هظهر رسالة ومش هشتغل ال offStage غير كدا بعمل لوب جوا الدوري لحد العنصر اللي واقف عنده ومن اخر الليست حد العنصر اللي واقف عنده عشان كل ما اضغط علي واحده يقفل الباقي
//                                                  onTap: () {
//                                                    setState(() {
//                                                      _countSecond=q;
//                                                      if(_teams[index][
//                                                      "main_champion"][i]
//                                                      [
//                                                      "sub_champion"]
//                                                      [q]["teams"].length==0||_teams[index][
//                                                      "main_champion"][i]
//                                                      [
//                                                      "sub_champion"]
//                                                      [q]["teams"].length==null){
//                                                        LoadingDialog(widget._scafold, ).
//                                                        showNotification("${tr("noMatchesInThisLeague")}");
//                                                        return;
//                                                      }
//                                                      for(int x=0;x< q;x++){
//                                                        setState(() {
//                                                          _teams[index]["main_champion"]
//                                                          [i]
//                                                          ["sub_champion"]
//                                                          [
//                                                          x]["choose"] = true;
//                                                        });
//                                                      }
//                                                      for(int x=_teams[index]["main_champion"]
//                                                      [i]
//                                                      ["sub_champion"].length-1;x> q;x--){
//                                                        setState(() {
//                                                          _teams[index]["main_champion"]
//                                                          [i]
//                                                          ["sub_champion"]
//                                                          [
//                                                          x]["choose"] = true;
//                                                        });
//
//                                                      }
//                                                      _teams[index]["main_champion"]
//                                                                  [i][
//                                                              "sub_champion"][q]
//                                                          ["choose"] =!_teams[
//                                                                      index]
//                                                                  ["main_champion"]
//                                                              [i]["sub_champion"]
//                                                          [q]["choose"];
//
//                                                    });
//
//                                                  },
//                                                  child: Container(
//                                                    height: 50,
//                                                    padding:
//                                                        EdgeInsets.symmetric(
//                                                            horizontal: 5),
//                                                    decoration: BoxDecoration(
//                                                        color:
//                                                            Color(0xffFFF9E5),
//                                                        border: Border(
//                                                            bottom: BorderSide(
//                                                                color: MyColors
//                                                                    .grey
//                                                                    .withOpacity(
//                                                                        .3),
//                                                                width: 1))),
//                                                    child: Row(
//                                                      mainAxisAlignment:
//                                                          MainAxisAlignment
//                                                              .spaceBetween,
//                                                      children: <Widget>[
//                                                        MyText(
//                                                          title:
//                                                              "${_teams[index]["main_champion"][i]["sub_champion"][q]["name"]}",
//                                                          size: 14,
//                                                          color: Colors.black54,
//                                                        ),
//                                                      ],
//                                                    ),
//                                                  ),
//                                                ),
//                                                Offstage(
//                                                  offstage: _teams[index]
//                                                              ["main_champion"]
//                                                          [i]["sub_champion"][q]
//                                                      ["choose"],
//                                                  child: Container(
//                                                    height:
//                                                    _teams[index][
//                                                    "main_champion"][i]
//                                                    [
//                                                    "sub_champion"]
//                                                    [q]["teams"].length==1?MediaQuery.of(context)
//                                                        .size
//                                                        .height *
//                                                        .1:_teams[index][
//                                                    "main_champion"][i]
//                                                    [
//                                                    "sub_champion"]
//                                                    [q]["teams"].length==2?MediaQuery.of(context)
//                                                        .size
//                                                        .height *
//                                                        .15:_teams[index][
//                                                    "main_champion"][i]
//                                                    [
//                                                    "sub_champion"]
//                                                    [q]["teams"].length==3?MediaQuery.of(context)
//                                                        .size
//                                                        .height *
//                                                        .2:MediaQuery.of(context)
//                                                        .size
//                                                        .height *
//                                                        .26,
//                                                    child: ListView.builder(
//                                                      itemCount: _teams[index][
//                                                                      "main_champion"][i]
//                                                                  [
//                                                                  "sub_champion"]
//                                                              [q]["teams"]
//                                                          .length,
//                                                      itemBuilder:
//                                                          (context, z) {
//                                                        return Container(
//                                                          height: 50,
//                                                          padding: EdgeInsets
//                                                              .symmetric(
//                                                                  horizontal:
//                                                                      5),
//                                                          decoration: BoxDecoration(
//                                                              color: Colors.green.withOpacity(.2),
//                                                              border: Border(
//                                                                  bottom: BorderSide(
//                                                                      color: MyColors
//                                                                          .grey
//
//                                                                          .withOpacity(
//                                                                              .3),
//                                                                      width:
//                                                                          1))),
//                                                          child: Row(
//                                                            mainAxisAlignment:
//                                                                MainAxisAlignment
//                                                                    .spaceBetween,
//                                                            children: <Widget>[
//                                                              MyText(
//                                                                title:
//                                                                    "${_teams[index]["main_champion"][i]["sub_champion"][q]["teams"][z]["name"]}",
//                                                                size: 14,
//                                                                color: Colors
//                                                                    .black54,
//                                                              ),
//                                                              Checkbox(
//                                                                value: _teams[index]["main_champion"][i]["sub_champion"][q]["teams"][z]["favourite"] ==
//                                                                            "false" ||
//                                                                        _teams[index]["main_champion"][i]["sub_champion"][q]["teams"][z]["favourite"] ==
//                                                                            false
//                                                                    ? false
//                                                                    : true,
//                                                                onChanged: (val) {
//                                                                  _sendFav(
//                                                                      val,
//                                                                      index,
//                                                                      i,
//                                                                      q,
//                                                                      _teams[index]["main_champion"][i]["sub_champion"][q]
//                                                                      ["teams"][z]
//                                                                      ["id"],
//                                                                      z,_teams[index]["main_champion"][i]["sub_champion"][q]
//                                                                  ["teams"][z]);
//                                                                },
//                                                                activeColor:
//                                                                    MyColors
//                                                                        .yellow,
//                                                                checkColor:
//                                                                    MyColors
//                                                                        .white,
//                                                              )
//                                                            ],
//                                                          ),
//                                                        );
//                                                      },
//                                                    ),
//                                                  ),
//                                                )
//                                              ],
//                                            );
//                                          }),
//                                    ),
//                                  ),
                                ],
                              );
                            }),
                          )
                        ],
                      );
                    }),
                  )
                ],
              ));
  }
}
