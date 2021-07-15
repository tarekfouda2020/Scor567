import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

// ignore: must_be_immutable
class Expectations extends StatefulWidget {
  var matchId, championId;
  String team1Name, team2Name;
  var type,gameType;
  Expectations({this.championId, this.matchId, this.team1Name, this.team2Name,this.type,this.gameType});
  @override
  _ExpectationsState createState() => _ExpectationsState();
}

class _ExpectationsState extends State<Expectations> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  int _place = 0;
  var _details;
  bool _loading = true;
  Future _expectMatch() async {
    if (_place == 0) {
      LoadingDialog(_scafold)
          .showNotification("${tr("ChooseExpectation")}");
      return;
    }
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "lang": "$_lang",
      "match_id": "${widget.matchId}",
      "champion_id": "${widget.championId}",
      "expect_value": "$_place",
    };
    var _data = await Http(_scafold)
        .post("AppApi/ExpectMatch", body, context);
    if (_data["key"] == 1) {
      LoadingDialog(_scafold).showNotification(_data["msg"]);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);
      });
    } else {
      LoadingDialog(_scafold).showNotification(_data["msg"]);
    }
  }

  Future _getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "lang": "$_lang",
      "match_id": "${widget.matchId}",
      "champion_id": "${widget.championId}"
    };
    var _data = await Http(_scafold)
        .get("AppApi/GetMatchExpect", body, context);
    if (_data["key"] == 1) {
      setState(() {
        _details=_data;
        _place = _data["client_exp"];
        _loading = false;
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


    return Container(
      child: Scaffold(
        key: _scafold,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyColors.primary,
          title: MyText(
            title: "${tr("expectations")}",
            size: 16,
            color: MyColors.white,
          ),
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: MyColors.white,
            ),
          ),
        ),
        body: _loading
            ? Container(
          child: Center(
            child: LoadingDialog(_scafold).showLoadingView(),
          ),
        )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage("images/scorelogo.png"),
                        fit: BoxFit.contain,
                        width: 200,
                        height: 80,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText(
                          title: "${tr("expectators")}",
                          color: MyColors.darken,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20),
                          child: MyText(
                            title:
                                "${_details["all_count"]} %",
                            color: MyColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      color: MyColors.back_red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MyText(
                            title: "${tr("win")} ${widget.team1Name}",
                            color: MyColors.darken,
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20),
                            child: MyText(
                              title:
                                  "${_details["team1_win_count"]} %",
                              color: MyColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText(
                          title: "${tr("win")} ${widget.team2Name}",
                          color: MyColors.darken,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20),
                          child: MyText(
                            title:
                                "${_details["team2_win_count"]} %",
                            color: MyColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                   widget.gameType==3&&widget.type==1? Container(
                      height: 40,
                      color: MyColors.back_red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MyText(
                            title: "${tr("equal")}",
                            color: MyColors.darken,
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20),
                            child: MyText(
                              title:
                                  "${_details["teams_equals_count"]}",
                              color: MyColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ):Container(),
                    SizedBox(
                      height: 20,
                    ),
                    MyText(
                      title: "${tr("expectResult")}",
                      color: MyColors.primary,
                      size: 16,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText(
                          title: "${tr("win")} ${widget.team1Name}",
                          size: 14,
                          color: MyColors.darken,
                        ),
                        Radio(
                          value: 1,
                          groupValue: _place,
                          activeColor: MyColors.primary,
                          onChanged: (val) {
                            setState(() {
                              _place = val;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText(
                          title: "${tr("win")} ${widget.team2Name}",
                          size: 14,
                          color: MyColors.darken,
                        ),
                        Radio(
                          value: 2,
                          groupValue: _place,
                          activeColor: MyColors.primary,
                          onChanged: (val) {
                            setState(() {
                              _place = val;
                            });
                          },
                        ),
                      ],
                    ),
                    widget.gameType==3&&widget.type==1? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText(
                          title: "${tr("equal")}",
                          size: 14,
                          color: MyColors.darken,
                        ),
                        Radio(
                          value: 3,
                          groupValue: _place,
                          activeColor: MyColors.primary,
                          onChanged: (val) {
                            setState(() {
                              _place = val;
                            });
                          },
                        ),
                      ],
                    ):Container(),
                  ],
                ),
              ),
        bottomNavigationBar: InkWell(
          onTap: () => _expectMatch(),
          child: Container(
            height: 55,
            decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            alignment: Alignment.center,
            child: MyText(
              title: "${tr("confirm")}",
              size: 16,
              color: MyColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
