import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score/Bloc/addLeagueFav.dart';
import 'package:score/customer/tabs/leagueTabs/Sorting.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'tabs/leagueTabs/Matches.dart';

// ignore: must_be_immutable
class League extends StatefulWidget {
  //  championId (id البطولة)
//  typeId (كاس او ليجا)
//  gameType (نوع اللعبة باسكت او سلة او طايرة او يد)
//typeId( 2 كاس)
//typeId( 1 ليجا)
//gameType(1//basket ball  && 3 // handball && 2//VolleyBall && 4//Tennis)

  var championId, typeId, gameType;
  League({this.championId, this.typeId, this.gameType});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<League> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();


  bool _showStatistics = false;
  bool _loading = true;
  var adverts = [];
  var matchDetails;
  var arrangeTeams = [];
  var _matches = [];
  var _tap = [];
  var _discription;
  Future _getData() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "champion_id": "${widget.championId}",
      "typegame": "${widget.gameType}",
      "lang": "$_lang",
    };
    var _data = await Http(_scafold)
        .get("AppApi/GetArrangeChampionLeague", body, context);
    if (_data["key"] == 1) {
      setState(() {
        adverts = _data["Adverts"];
        matchDetails = _data["MatchDetails"];
        arrangeTeams = _data["ArrangeTeams"];
        _discription = _data["Description"];
      });
      await _getMatches();
    }
  }

  Future _getMatchesCup() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final model = Provider.of<FavLeague>(context);
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "champion_id": "${widget.championId}",
      "typegame": "${widget.gameType}",
      "lang": "$_lang",
      "mytime": DateTime.now().timeZoneOffset.inHours.toString(),
    };
    var _data =
        await Http(_scafold).get("AppApi/CupDetails", body, context);
    if (_data["key"] == 1) {
      model.setFav([]);
      model.setFav(_data["DetailsList"]);
      setState(() {
        adverts = _data["Adverts"];
        matchDetails = _data["Champion"];
        _matches = _data["DetailsList"];
        _tap = _data["ListDoors"];
        _loading = false;
      });
    }
  }

  Future _getMatchesTennis() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final model = Provider.of<FavLeague>(context);
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "champion_id": "${widget.championId}",
      "lang": "$_lang",
    };
    var _data = await Http(_scafold)
        .get("AppApi/TennisCupDetails", body, context);
//    print("data is $_data");
//    print("body is $body");
    if (_data["key"] == 1) {
      model.setFav([]);
      model.setFav(_data["DetailsList"]);
      setState(() {
        adverts = _data["Adverts"];
        _matches = _data["data"];
        matchDetails = _data["Champion"];
        _loading = false;
      });
    }
  }

  Future _getMatches() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final model = Provider.of<FavLeague>(context);
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "champion_id": "${widget.championId}",
      "typegame": "${widget.gameType}",
      "lang": "$_lang",
      "myTime": DateTime.now().timeZoneOffset.inHours.toString(),
    };
    var _data = await Http(_scafold)
        .get("AppApi/MatchInChampion", body, context);
    if (_data["key"] == 1) {
      model.fav.clear();
      model.setFav(_data["Matchs"]);
      setState(() {
        _matches = _data["Matchs"];
        _loading = false;
      });
    }
  }

  _launchURL(url) async {
    String _url = url;
    if (!_url.startsWith('https://')) {
      _url = 'https://' + _url;
    }
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      LoadingDialog(_scafold)
          .showNotification('${tr("checkUrl")}');
    }
  }

  @override
  void initState() {
    widget.typeId == 2 ? _showStatistics = true : _showStatistics = false;
    widget.typeId == 1
        ? _getData()
        : widget.gameType == 4 ? _getMatchesTennis() : _getMatchesCup();

//    _getMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Container(
      child: DefaultTabController(
        length: widget.typeId == 1 ? 2 : 1,
        initialIndex: 0,
        child: Scaffold(
          key: _scafold,
          appBar: AppBar(
            backgroundColor: MyColors.primary,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyText(
                    title: widget.gameType == 1
                        ? "${tr("basketBall")}"
                        : widget.gameType == 2
                            ? "${tr("volleyBall")}"
                            : widget.gameType == 3
                                ? "${tr("handBall")}"
                                : "${tr("tennis")}",
                    size: 16,
                    color: MyColors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage("images/scorelogo.png"),
                    fit: BoxFit.contain,
                    width: 60,
                    height: 40,
                  )
                ],
              ),
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
          backgroundColor: Colors.white,
          body: _loading
              ? Container(
                  child: Center(
                    child: LoadingDialog(_scafold).showLoadingView(),
                  ),
                )
              : ListView(
                  children: <Widget>[
                    Container(
                      height: 150,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 2),
                            child: adverts.length == 0 || adverts.length == null
                                ? Container(
                                    height: 135.0,
                                    decoration: BoxDecoration(
                                        color: MyColors.primary,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "images/appIcon.png"),
                                            fit: BoxFit.contain)),
                                  )
                                : CarouselSlider(
                              options: CarouselOptions(
                                height: 135.0,
                                aspectRatio: 16 / 9,
                                viewportFraction: 1.0,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                                autoPlayCurve: Curves.easeOutSine,
                                enlargeCenterPage: true,
                                pauseAutoPlayOnTouch: true,
                              ),

                              items: adverts.map((obj) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return InkWell(
                                            onTap: () => _launchURL(obj["Url"]),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 135,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "${obj["Img"]}"),
                                                      fit: BoxFit.fill)),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 2,
                              left: 2,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 55,
                                    height: 35,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: MyColors.darken,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              matchDetails["SubChampionImg"]),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Center(
                                    child: MyText(
                                      title: matchDetails["subChampionName"],
                                      size: 14,
                                      color: MyColors.primary,
                                      alien: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )),
//                          Positioned(
//                            bottom: 0,
//                            left: 5,
//                            child: Container(
//                              child: Center(
//                                child: MyText(
//                                  title: matchDetails["subChampionName"],
//                                  size: 14,
//                                  color: MyColors.primary,
//                                  alien: TextAlign.center,
//                                ),
//                              ),
//                              alignment: Alignment.center,
//                            ),
//                          )
                        ],
                      ),
                    ),
                    widget.typeId == 1
                        ? Card(
                            color: Color(0xffffc400).withOpacity(.1),
                            elevation: 0,
                            margin: EdgeInsets.only(top: 10),
                            child: TabBar(
                              onTap: (index) {
                                _showStatistics = (index == 0) ? false : true;
                                setState(() {});
                              },
                              labelColor: MyColors.white,
                              indicatorColor: MyColors.yellow,
                              indicatorSize: TabBarIndicatorSize.tab,
                              unselectedLabelColor: MyColors.darken,
                              labelPadding: EdgeInsets.symmetric(vertical: 0),
                              labelStyle:
                                  TextStyle(fontSize: 14, fontFamily: "cairo"),
                              indicator: BoxDecoration(color: MyColors.primary),
                              tabs: [
                                Tab(
                                  text: "${tr("arrangement")}",
                                ),
                                Tab(
                                  text: "${tr("matches")}",
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
//                    Card(
//                      margin: EdgeInsets.only(top: 10),
//                      child: TabBar(
//                        onTap: (index) {
//
//                          setState(() {
//                            _showStatistics = false;
//                          });
//                        },
//                        labelColor: MyColors.white,
//                        indicatorColor: MyColors.yellow,
//                        indicatorSize: TabBarIndicatorSize.tab,
//                        unselectedLabelColor: MyColors.darken,
//                        labelPadding: EdgeInsets.symmetric(vertical: 0),
//                        labelStyle:
//                        TextStyle(fontSize: 14, fontFamily: "cairo"),
//                        indicator: BoxDecoration(color: MyColors.primary),
//                        tabs: [
//
//                          Tab(
//                            text: "${tr("matches")}",
//                          ),
//                        ],
//                      ),
//                    ),
                    Visibility(
                      child: Matches(
                          _scafold,
                          _matches,
                          widget.championId,
                          widget.typeId,
                          widget.gameType,
                          _tap),
                      visible: _showStatistics,
                      replacement: Sorting(_scafold, arrangeTeams,
                          widget.gameType, _discription ?? {}),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
