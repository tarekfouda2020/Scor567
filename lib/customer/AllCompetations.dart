import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'League.dart';

class AllCompetations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<AllCompetations> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var _competition = [];
  var _basketBall = [];
  var _volleyBall = [];
  var _handBall = [];
  var _tennis = [];
  bool _loading = true;
  Future _getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {"user_id": "$_user", "lang": "$_lang"};
    var _data = await Http(_scafold)
        .get("AppApi/InterestedChampions", body, context);
    if (_data["key"] == 1) {
      setState(() {
        _competition = _data["tab1"];
        _loading = false;
      });

      for (int i = 0; i < _competition.length; i++) {
        if (_competition[i]["type"] == 1) {
          _basketBall.add(_competition[i]);
        } else if (_competition[i]["type"] == 2) {
          _volleyBall.add(_competition[i]);
        } else if (_competition[i]["type"] == 3) {
          _handBall.add(_competition[i]);
        } else if (_competition[i]["type"] == 4) {
          _tennis.add(_competition[i]);
        }
      }
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: MyColors.primary,
          centerTitle: true,
          title: MyText(
            title: "${tr("competition")}",
            size: 16,
            color: MyColors.white,
          ),
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
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
            : _competition.length == 0 || _competition.length == null
                ? Container(
                    child: Center(
                      child: MyText(
                        title: "${tr("noFavChampions")}",
                      ),
                    ),
                  )
                : Container(
                    color: Color(0xffffc400).withOpacity(.1),
                    margin: EdgeInsets.all(8.0),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        _basketBall.length == 0 || _basketBall.length == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.all(8.0),
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Image(
                                      image:
                                          AssetImage("images/basket_ball.png"),
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    MyText(
                                      title: "${tr("basketBall")}",
                                      color: MyColors.primary,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                        _basketBall.length == 0 || _basketBall.length == null
                            ? Container()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    List.generate(_basketBall.length, (index) {
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                SlideRightRoute(
                                                    page: League(
                                                  championId: _basketBall[index]
                                                      ["id"],
                                                  typeId: _basketBall[index]
                                                      ["CupType"],
                                                  gameType: _basketBall[index]
                                                      ["type"],
                                                )));
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Image(
                                                image: NetworkImage(
                                                    "${_basketBall[index]["img"]}"),
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              MyText(
                                                title:
                                                    "${_basketBall[index]["name"]}",
                                                color: Colors.black,
                                                size: 14,
                                              ),
                                              Expanded(child: Container()),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      index == _basketBall.length - 1
                                          ? Container()
                                          : Divider(
                                              color: Colors.grey,
                                            )
                                    ],
                                  );
                                }),
                              ),
                        _volleyBall.length == 0 || _volleyBall.length == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.all(8.0),
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage("images/vollyBall.png"),
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    MyText(
                                      title: "${tr("volleyBall")}",
                                      color: MyColors.primary,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                        _volleyBall.length == 0 || _volleyBall.length == null
                            ? Container()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    List.generate(_volleyBall.length, (index) {
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                SlideRightRoute(
                                                    page: League(
                                                  championId: _volleyBall[index]
                                                      ["id"],
                                                  typeId: _volleyBall[index]
                                                      ["CupType"],
                                                  gameType: _volleyBall[index]
                                                      ["type"],
                                                )));
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Image(
                                                image: NetworkImage(
                                                    "${_volleyBall[index]["img"]}"),
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              MyText(
                                                title:
                                                    "${_volleyBall[index]["name"]}",
                                                color: Colors.black,
                                                size: 14,
                                              ),
                                              Expanded(child: Container()),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      index == _volleyBall.length - 1
                                          ? Container()
                                          : Divider(
                                              color: Colors.grey,
                                            )
                                    ],
                                  );
                                }),
                              ),
                        _handBall.length == 0 || _handBall.length == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.all(8.0),
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage("images/handBall.png"),
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    MyText(
                                      title: "${tr("handBall")}",
                                      color: MyColors.primary,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                        _handBall.length == 0 || _handBall.length == null
                            ? Container()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    List.generate(_handBall.length, (index) {
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                SlideRightRoute(
                                                    page: League(
                                                  championId: _handBall[index]
                                                      ["id"],
                                                  typeId: _handBall[index]
                                                      ["CupType"],
                                                  gameType: _handBall[index]
                                                      ["type"],
                                                )));
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Image(
                                                image: NetworkImage(
                                                    "${_handBall[index]["img"]}"),
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              MyText(
                                                title:
                                                    "${_handBall[index]["name"]}",
                                                color: Colors.black,
                                                size: 14,
                                              ),
                                              Expanded(child: Container()),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      index == _handBall.length - 1
                                          ? Container()
                                          : Divider(
                                              color: Colors.grey,
                                            )
                                    ],
                                  );
                                }),
                              ),
                        _tennis.length == 0 || _tennis.length == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.all(8.0),
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage("images/tensBall.png"),
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    MyText(
                                      title: "${tr("tennis")}",
                                      color: MyColors.primary,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                        _tennis.length == 0 || _tennis.length == null
                            ? Container()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    List.generate(_tennis.length, (index) {
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                SlideRightRoute(
                                                    page: League(
                                                  championId: _tennis[index]
                                                      ["id"],
                                                  typeId: _tennis[index]
                                                      ["CupType"],
                                                  gameType: _tennis[index]
                                                      ["type"],
                                                )));
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Image(
                                                image: NetworkImage(
                                                    "${_tennis[index]["img"]}"),
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width*.75,
                                                child: MyText(
                                                  title:
                                                      "${_tennis[index]["name"]}",
                                                  color: Colors.black,
                                                  size: 14,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      index == _tennis.length - 1
                                          ? Container()
                                          : Divider(
                                              color: Colors.grey,
                                            )
                                    ],
                                  );
                                }),
                              ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
