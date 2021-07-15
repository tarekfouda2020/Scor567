import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score/customer/tabs/matchTabs/PublicDetails.dart';
import 'package:score/customer/tabs/matchTabs/Statestics.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class MatchDetails extends StatefulWidget {
//  championId (id البطولة)
//  matchId (id الماتش)
//  typeId (كاس او ليجا)
//  gameType (نوع اللعبة باسكت او سلة او طايرة او يد)
//typeId( 2 كاس)
//typeId( 1 ليجا)
//gameType(1//basket ball  && 3 // handball && 2//VolleyBall && 4//Tennis)

  var championId, matchId, typeId, gameType;
  MatchDetails({this.championId, this.matchId, this.typeId, this.gameType});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<MatchDetails> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  bool _loading = true;
  bool _showCard = true;
  var _advert = [];
  var _arrangeTeams = [];
  var _histroyModel = [];
  var _card;
  var _matchTeams;
  bool _showStatistics = true;
  Future _getData() async {
    setState(() {
      _loading=true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "champion_id": "${widget.championId}",
      "match_id": "${widget.matchId}",
      "typegame": "${widget.gameType}",
      "lang": "$_lang",
      "typechampion": widget.gameType == 4 ? "1" : "${widget.typeId}"
    };
    print("__________ $body");
    var _data = await Http(_scafold).get("AppApi/GetDetailMatch", body, context);
    print("__________ data $_data");
    if (_data["key"] == 1) {
      setState(() {
        _advert = _data["Adverts"];
        _matchTeams = _data["MatchDetails"];
        _histroyModel = _data["Historymodel"];
        _showCard = _matchTeams["HaveCard"];
        widget.typeId == 1
        ? _data["ArrangeTeams"] == ""
        ? _arrangeTeams = []
            : _arrangeTeams = _data["ArrangeTeams"]
            : null;
        if (_matchTeams["HaveCard"] == true) {
          setState(() {
            _card = _data["Card"];
          });
        }
        _loading = false;
      });
    }

  }

  @override
  void initState() {
    _getData();
    super.initState();
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
  Widget build(BuildContext context) {
    // TODO: implement build
    print("________33 $_card}");
    return Container(
      child: DefaultTabController(
        length: _showCard == true ? 2 : 1,
        initialIndex: 0,
        child: Scaffold(
          key: _scafold,
          appBar: AppBar(
            backgroundColor: MyColors.primary,
            centerTitle: true,
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
              : RefreshIndicator(
            onRefresh: ()=>_getData(),
                backgroundColor: MyColors.primary,
                child: ListView(
                    children: <Widget>[
                      Container(
                        height: 150,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 2,bottom: 10),
                              child:_advert.length==0||_advert.length==null?
                              Container(
                                height: 135.0,
                                decoration: BoxDecoration(
                                    color: MyColors.primary,
                                    image: DecorationImage(image:
                                    AssetImage("images/appIcon.png"),fit: BoxFit.contain)
                                ),
                              )
                                  : CarouselSlider(
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
                                pauseAutoPlayOnTouch: Duration(seconds: 10),
                                enlargeCenterPage: true,
                                items: _advert.map((obj) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return InkWell(
                                        onTap: () => _launchURL(obj["Url"]),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 140,
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
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: MyColors.darken,
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  _matchTeams["subchampion"]
                                                      ["SubChampionImg"]),
                                              fit: BoxFit.fill),
                                          ),
                                    ),
                                    Center(
                                      child: MyText(
                                        title: _matchTeams["subchampion"]
                                            ["subChampionName"],
                                        size: 13,
                                        color: MyColors.primary,
                                      ),
                                    )
                                  ],
                                )),
//                          Positioned(
//                            bottom: 0,
//                            child: MyText(
//                              title: _matchTeams["subchampion"]
//                                  ["subChampionName"],
//                              size: 13,
//                              color: MyColors.primary,
//                            ),
//                          )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 120,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/playground.png"),
                                fit: BoxFit.fill)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MyText(
                                  title: _matchTeams["teamhost"],
                                  size: 12,
                                  color: Colors.white,
                                ),
                                MyText(
                                  title: "(${_matchTeams["countryhost"]})",
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
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
                                            title: _matchTeams["resulthost"]
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
                                            title: _matchTeams["resultaway"]
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
                                              color: MyColors.white, width: .5)),
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
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MyText(
                                  title: _matchTeams["teamaway"],
                                  size: 12,
                                  color: Colors.white,
                                ),
                                MyText(
                                  title: "(${_matchTeams["countryaway"]})",
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _showCard == true
                          ? Card(
                        elevation: 0,
                        color: Color(0xffffc400).withOpacity(.1),
                        margin: EdgeInsets.all(0),
                              child: TabBar(
                                onTap: (index) {
                                  setState(() {
                                    _showStatistics = (index == 1) ? false : true;
                                  });
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
                                    text: "${tr("afterMatch")}",
                                  ),
                                  Tab(
                                    text: "${tr("overview")}",
                                  ),
                                ],
                              ),
                            )
                          : Card(
                              margin: EdgeInsets.all(0),
                              child: TabBar(
                                onTap: (index) {
                                  if (index == 0) {
                                    setState(() {
                                      _showStatistics = false;
                                    });
                                  } else if (index == 1) {
                                    _showStatistics = true;
                                  } else {
                                    setState(() {
                                      _showStatistics = true;
                                    });
                                  }
//                                _showStatistics = (index == 1) ? false : true;
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
                                    text: "${tr("afterMatch")}",
                                  ),
                                ],
                              ),
                            ),
                      Visibility(
                        child: Statestics(
                            _scafold, widget.gameType, _card),
                        visible: !_showStatistics,
                        replacement: PublicDetails(_scafold,
                            _histroyModel, _arrangeTeams, widget.gameType),
                      ),
                    ],
                  ),
              ),
        ),
      ),
    );
  }
}
