import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:score/customer/AddCompetionFav.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Competations extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;


  Competations(this._scafold, );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<Competations> {
  var _champions = [];
  bool _loading = true;

  Future _getTeams() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {"user_id": "$_user", "lang": "$_lang"};
    var _data = await Http(widget._scafold, )
        .get("AppApi/AllChampions", body, context);
    if (_data["key"] == 1) {
      setState(() {
        _champions = _data["tab1"];
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _getTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: MyColors.white,
        body: _loading
            ? Container(
                child: Center(
                  child: LoadingDialog(widget._scafold, )
                      .showLoadingView(),
                ),
              )
            : ListView.builder(
                itemCount: _champions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        color: Color(0xffffc400).withOpacity(.1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            MyText(
                              title: _champions[index]["name"],
                              size: 14,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              image: _champions[index]["type"] == 1
                                  ? AssetImage("images/basket_ball.png")
                                  : _champions[index]["type"] == 2
                                      ? AssetImage("images/vollyBall.png")
                                      : _champions[index]["type"] == 3
                                          ? AssetImage("images/handBall.png")
                                          : AssetImage("images/tensBall.png"),
                              width: 20,
                              height: 20,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(_champions[index]["main_champion"].length, (i){
                          return Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SlideRightRoute(
                                          page: AddCompetionFav(
                                              _champions[index]
                                              ["main_champion"][i]
                                              ["sub_champion"],
                                              _champions[index]
                                              ["main_champion"][i]
                                              ["name"],
                                              1)));
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
                                          title: _champions[index]
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
                                                _champions[index]
                                                ["main_champion"][i]
                                                ["img"]),
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          );
                        }),
                      )

                    ],
                  );
                },
              ));
  }
}
