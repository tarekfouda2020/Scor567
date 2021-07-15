import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:score/Bloc/DaysModel.dart';
import 'package:score/customer/AllCompetations.dart';
import 'package:score/customer/LiveMatches.dart';
import 'package:score/customer/tabs/mainTabs/FirstDays.dart';
import 'package:score/customer/tabs/mainTabs/LastDays.dart';
import 'package:score/customer/tabs/mainTabs/NextDay.dart';
import 'package:score/customer/tabs/mainTabs/PreviousDay.dart';
import 'package:score/customer/tabs/mainTabs/Today.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../publaic/constants/MyColors.dart';

// ignore: must_be_immutable
class Main extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;

  Main(
    this._scafold,
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<Main> {
  var _prevName = "";
  var _prevNum = "";
  var _nextName = "";
  var _nextNum = "";
  var prevMonth = '';
  var nextMonth = '';
  var _prevYear = '';
  var _nextYear = '';
  _setDate() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _lang = _prefs.get("lang");
    var today = DateTime.now();
    _prevNum = DateFormat('dd', "en").format(today.subtract(Duration(days: 1)));
    _prevYear =
        DateFormat('yyyy', "en").format(today.subtract(Duration(days: 1)));
    _prevName = DateFormat('EEEE', _lang == null ? "ar" : "$_lang")
        .format(today.subtract(Duration(days: 1)));
    _nextName = DateFormat('EEEE', _lang == null ? "ar" : "$_lang")
        .format(today.add(Duration(days: 1)));
    _nextNum = DateFormat('dd', "en").format(today.add(Duration(days: 1)));
    _nextYear = DateFormat('yyyy', "en").format(today.add(Duration(days: 1)));
    setState(() {
      prevMonth =
          DateFormat('MM', "en").format(today.subtract(Duration(days: 1)));
      nextMonth = DateFormat('MM', "en").format(today.add(Duration(days: 1)));
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _setDate();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final model = Provider.of<DaysModel>(context);
//    final landScape=MediaQuery.of(context).orientation==Orientation.portrait;
    return DefaultTabController(
      length: 5,
      initialIndex: 2,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: Column(
            children: <Widget>[
              Container(
                height: kToolbarHeight + 25,
                color: MyColors.primary,
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/search"),
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Icon(
                              Icons.search,
                              size: 25,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(context,
                              SlideRightRoute(page: AllCompetations())),
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Icon(
                              FontAwesomeIcons.trophy,
                              size: 20,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image(
                      image: AssetImage("images/scorelogo.png"),
                      fit: BoxFit.contain,
                      width: 100,
                      height: 50,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                SlideRightRoute(page: LiveMatches(false)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Icon(
                              FontAwesomeIcons.clock,
                              size: 20,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => exit(0),
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0, left: 10.0),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/logOut.png"),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // AppBar(
              //   title: Image(
              //     image: AssetImage("images/scorelogo.png"),
              //     fit: BoxFit.contain,
              //     width: 100,
              //     height: 50,
              //   ),
              //   leading: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
              //       InkWell(
              //         onTap: () => Navigator.of(context).pushNamed("/search"),
              //         child: Container(
              //           child: Icon(
              //             Icons.search,
              //             size: 25,
              //             color: MyColors.white,
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: () => Navigator.push(
              //             context, SlideRightRoute(page: AllCompetations())),
              //         child: Container(
              //           child: Icon(
              //             FontAwesomeIcons.trophy,
              //             size: 20,
              //             color: MyColors.white,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              //   backgroundColor: MyColors.primary,
              //   centerTitle: true,
              //   actions: <Widget>[
              //     InkWell(
              //       onTap: () {
              //         Navigator.push(
              //             context, SlideRightRoute(page: LiveMatches(false)));
              //       },
              //       child: Container(
              //         margin: EdgeInsets.only(right: 10.0, left: 10.0),
              //         child: Icon(
              //           FontAwesomeIcons.clock,
              //           size: 20,
              //           color: MyColors.white,
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () => exit(0),
              //       child: Container(
              //         margin: EdgeInsets.only(right: 10.0, left: 10.0),
              //         width: 20,
              //         height: 20,
              //         decoration: BoxDecoration(
              //             image: DecorationImage(
              //                 image: AssetImage("images/logOut.png"),
              //                 fit: BoxFit.contain)),
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                color: MyColors.yellow,
                child: TabBar(
                  onTap: (position) {
                    model.changePrev(true);
                    model.changePrev(true);
                    model.changenext(true);
                    model.changenext(true);
                  },
                  labelColor: Colors.grey,
                  indicatorColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: MyColors.primary,
                  indicator: BoxDecoration(
                    color: MyColors.white,
                  ),
                  labelPadding: EdgeInsets.symmetric(vertical: 0),
                  tabs: [
                    Tab(
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/list-right.png"),
                                fit: BoxFit.contain)),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            MyText(
                              title: "$_prevName",
                              size: 12,
                              color: Colors.black,
                            ),
                            MyText(
                              title: "$_prevNum",
                              size: 12,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: MyText(
                          title: "${tr("today")}",
                          size: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            MyText(
                              title: "$_nextName",
                              size: 12,
                              color: Colors.black,
                            ),
                            MyText(
                              title: "$_nextNum",
                              size: 12,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/list-left.png"),
                                fit: BoxFit.contain)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            LastDays(
              widget._scafold,
            ),
            PreviousDay(widget._scafold, _prevNum, prevMonth, _prevYear),
            Today(
              widget._scafold,
            ),
            NextDay(widget._scafold, _nextNum, nextMonth, _nextYear),
            FirstDays(
              widget._scafold,
            ),
          ],
        ),
      ),
    );
  }
}
