import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:score/customer/tabs/Explore.dart';
import 'package:score/customer/tabs/Favourite.dart';
import 'package:score/customer/tabs/Main.dart';
import 'package:score/customer/tabs/Profile.dart';
import 'package:score/publaic/constants/GlobalState.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/ads_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  var forFav;
  Function fun;
  Home({this.forFav, this.fun});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _appDescrition();
  }
}

class _appDescrition extends State<Home> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();
  InterstitialAd _ad;
  bool _isAdLoaded = false;
  int index = 0;
  var lang_data;
  @override
  void initState() {
    super.initState();
    _setIntialIndex();
     InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
         adLoadCallback: InterstitialAdLoadCallback(
           onAdLoaded: (InterstitialAd value) {
             // Keep a reference to the ad so you can show it later.
             _ad = value;
             _ad.show();
           },
           onAdFailedToLoad: (LoadAdError error) {
             print('InterstitialAd failed to load: $error');
           },
         ),
    );

  }

  checkUsers() async {
    //GlobalNotification.instance.setupNotification(navKey: widget.navigatorKey,func: (){});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var str_user = prefs.get("lang");
    Future.delayed(Duration(seconds: 2), () {
      if (str_user != null) {
        var user = json.decode(str_user);
        GlobalState.instance.set("lang", "${user["lang"]}");
        if (user["lang"] == "en") {
          lang_data.changeLocale(Locale("en"));
        } else {
          lang_data.changeLocale(Locale("ar"));
        }
      } else {
        lang_data.changeLocale(Locale("ar"));
      }
      setState(() {});
    });
  }

  _setIntialIndex() async {
    var selected = GlobalState.instance.get("index");
    if (selected != null) {
      index = selected;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lang = prefs.get("lang");

    if (lang == "en") {
      context.setLocale(Locale("en", "US"));
    } else {
      context.setLocale(Locale("ar", "EG"));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return DefaultTabController(
        initialIndex: widget.forFav != null ? 1 : index,
        length: 4,
        child: Container(
          child: Scaffold(
            key: _scafold,
            backgroundColor: Colors.white,
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Main(_scafold),
                Favourite(_scafold),
                Explore(_scafold),
                Profile(_scafold),
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: MyColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: TabBar(
                labelColor: Colors.yellow,
                labelStyle: TextStyle(fontSize: 12, fontFamily: "cairo"),
                indicatorColor: Colors.yellow,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.white,
                labelPadding: EdgeInsets.symmetric(vertical: 0),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.table_chart,
                      size: 25,
                    ),
                    text: "${tr("publicTable")}",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.star_border,
                      size: 25,
                    ),
                    text: "${tr("favorite")}",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.search,
                      size: 25,
                    ),
                    text: "${tr("discover")}",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.settings,
                      size: 25,
                    ),
                    text: "${tr("setting")}",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
