import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;


  Profile(this._scafold, );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<Profile> {
  bool _notify;
  bool _notifyStart;

//  bool _notifyFinish;
  bool _notifyMatch;
  bool _loading = true;
//  RateMyApp _rateMyApp = RateMyApp(
//      preferencesPrefix: 'rateMyApp_',
//      minDays: 1,
//      minLaunches: 7,
//      remindDays: 7,
//      remindLaunches: 5,
//      googlePlayIdentifier: "aait.sa.scoreapp.score",
//      appStoreIdentifier: "aait.sa.scoreapp.score");

  Future _getNotifies() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {"user_id": "$_user", "lang": "$_lang"};
    var _data = await Http(widget._scafold, )
        .get("AppApi/getClientProfile", body, context);
    if (_data["key"] == 1) {
      setState(() {
        _notify = _data["client"]["AllNotification"];
        _notifyStart = _data["client"]["StartMatch"];
//        _notifyFinish=_data["client"]["EndMatch"];
        _notifyMatch = _data["client"]["RememberMatch"];
        _loading = false;
      });
    } else {
      LoadingDialog(widget._scafold, )
          .showNotification("${_data["ms"]}");
    }
  }

  Future _changeNotifies(type) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "user_id": "$_user",
      "lang": "$_lang",
      "type": "${type.toString()}"
    };
    var _data = await Http(widget._scafold, )
        .post("AppApi/ChangeClientProfile", body, context);
    if (_data["key"] == 1) {
      LoadingDialog(widget._scafold, )
          .showNotification("${_data["msg"]}");
    } else {
      LoadingDialog(widget._scafold, )
          .showNotification("${_data["msg"]}");
    }
  }

  @override
  void initState() {
    _getNotifies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        centerTitle: true,
        title: MyText(
          title: "${tr("setting")}",
          size: 16,
          color: MyColors.white,
        ),
      ),
      body: _loading
          ? Container(
              child: Center(
                child: LoadingDialog(widget._scafold, )
                    .showLoadingView(),
              ),
            )
          : ListView(
              children: <Widget>[
                Container(
                  color: Color(0xffe1e1e1),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      MyText(
                        title: "${tr("publicSetting")}",
                        size: 16,
                        color: MyColors.primary,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: MyColors.grey.withOpacity(.3), width: 1))),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notifications_none,
                        size: 20,
                        color: MyColors.yellow,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      MyText(
                        title: "${tr("notification")}",
                        size: 14,
                        color: Colors.grey,
                      ),
                      Spacer(),
                      Switch(
                          value: _notify,
                          activeColor: MyColors.yellow,
                          activeTrackColor: MyColors.yellow.withOpacity(.6),
                          inactiveThumbColor: MyColors.grey,
                          inactiveTrackColor: MyColors.grey.withOpacity(.5),
                          onChanged: (val) {
                            setState(() {
                              _notify = val;
                            });
                            _changeNotifies(1);
                          })
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed("/languages"),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.language,
                          size: 20,
                          color: MyColors.yellow,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        MyText(
                          title: "${tr("lang")}",
                          size: 14,
                          color: Colors.grey,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: MyColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Color(0xffe1e1e1),
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      MyText(
                        title: "${tr("favNotification")}",
                        size: 16,
                        color: MyColors.primary,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: MyColors.grey.withOpacity(.3), width: 1))),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.alarm,
                        size: 20,
                        color: MyColors.yellow,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      MyText(
                        title: "${tr("matchReminder")}",
                        size: 14,
                        color: Colors.grey,
                      ),
                      Spacer(),
                      Switch(
                          value: _notifyMatch,
                          activeColor: MyColors.yellow,
                          activeTrackColor: MyColors.yellow.withOpacity(.6),
                          inactiveThumbColor: MyColors.grey,
                          inactiveTrackColor: MyColors.grey.withOpacity(.5),
                          onChanged: (val) {
                            setState(() {
                              _notifyMatch = val;
                            });
                            _changeNotifies(2);
                          })
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: MyColors.grey.withOpacity(.3), width: 1))),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.alarm,
                        size: 20,
                        color: MyColors.yellow,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      MyText(
                        title: "${tr("matchBeginning")}",
                        size: 14,
                        color: Colors.grey,
                      ),
                      Spacer(),
                      Switch(
                          value: _notifyStart,
                          activeColor: MyColors.yellow,
                          activeTrackColor: MyColors.yellow.withOpacity(.6),
                          inactiveThumbColor: MyColors.grey,
                          inactiveTrackColor: MyColors.grey.withOpacity(.5),
                          onChanged: (val) {
                            setState(() {
                              _notifyStart = val;
                            });
                            _changeNotifies(3);
                          })
                    ],
                  ),
                ),
//          Container(
//            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//            child: Row(
//              children: <Widget>[
//                Icon(
//                  Icons.alarm,
//                  size: 20,
//                  color: MyColors.yellow,
//                ),
//                SizedBox(
//                  width: 5,
//                ),
//                MyText(
//                  title: "${tr("matchEnding")}",
//                  size: 14,
//                  color: Colors.grey,
//                ),
//                Spacer(),
//                Switch(
//                    value: _notifyFinish,
//                    activeColor: MyColors.yellow,
//                    activeTrackColor: MyColors.yellow.withOpacity(.6),
//                    inactiveThumbColor: MyColors.grey,
//                    inactiveTrackColor: MyColors.grey.withOpacity(.5),
//                    onChanged: (val) {
//                      setState(() {
//                        _notifyFinish = val;
//                      });
//                      _changeNotifies(4);
//                    })
//              ],
//            ),
//          ),
                Container(
                  color: Color(0xffe1e1e1),
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      MyText(
                        title: "${tr("instructions")}",
                        size: 16,
                        color: MyColors.primary,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed("/contactUs"),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person_pin,
                          size: 20,
                          color: MyColors.yellow,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        MyText(
                          title: "${tr("contactUs")}",
                          size: 14,
                          color: Colors.grey,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: MyColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
//                InkWell(
//                  onTap: () {
//                    _rateMyApp.init().then((_) {
//                      _rateMyApp.showStarRateDialog(
//                        context,
//                        title: '${tr("enjoyedApp")}',
//                        message: '${tr("pleaseRateApp")}',
//                        actionsBuilder: (_, stars) {
//                          return [
//                            FlatButton(
//                              child: MyText(
//                                title: "${tr("rate")}",
//                                size: 15,
//                              ),
//                              onPressed: () async {
////                                print('Thanks for the ' +
////                                    (stars == null
////                                        ? '0'
////                                        : stars.round().toString()) +
////                                    ' star(s) !');
//                                await _rateMyApp.callEvent(
//                                    RateMyAppEventType.rateButtonPressed);
//                               await _rateMyApp.save();
//                                if (stars != null &&
//                                    (stars == 4 || stars == 5)) {
//                                  Navigator.pop(context);
//                                  LaunchReview.launch(
//                                      androidAppId: "aait.sa.scoreapp.score",
//                                      iOSAppId: "aait.sa.scoreapp.score");
//                                } else {
//                                  Navigator.pop(context);
//                                  Navigator.pushNamed(context, "/contactUs");
//                                }
//
//
//                              },
//                            ),
//                          ];
//                        },
//                        dialogStyle: DialogStyle(
//                          titleAlign: TextAlign.center,
//                          messageAlign: TextAlign.center,
//                          messagePadding: EdgeInsets.only(bottom: 20.0),
//                        ),
//                        starRatingOptions: StarRatingOptions(),
//                        onDismissed: () => _rateMyApp
//                            .callEvent(RateMyAppEventType.laterButtonPressed),
//                      );
//                    });
//                  },
//                  child: Container(
//                    margin: EdgeInsets.symmetric(horizontal: 10),
//                    padding: EdgeInsets.symmetric(vertical: 15),
//                    decoration: BoxDecoration(
//                        border: Border(
//                            bottom: BorderSide(
//                                color: MyColors.grey.withOpacity(.3),
//                                width: 1))),
//                    child: Row(
//                      children: <Widget>[
//                        Icon(
//                          Icons.rate_review,
//                          size: 20,
//                          color: MyColors.yellow,
//                        ),
//                        SizedBox(
//                          width: 5,
//                        ),
//                        MyText(
//                          title: "${tr("rateApp")}",
//                          size: 14,
//                          color: Colors.grey,
//                        ),
//                        Spacer(),
//                        Icon(
//                          Icons.arrow_forward_ios,
//                          size: 20,
//                          color: MyColors.primary,
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed("/terms"),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.assignment,
                          size: 20,
                          color: MyColors.yellow,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        MyText(
                          title: "${tr("terms")}",
                          size: 14,
                          color: Colors.grey,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: MyColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed("/aboutApp"),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.grey.withOpacity(.3),
                                width: 1))),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.new_releases,
                          size: 20,
                          color: MyColors.yellow,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        MyText(
                          title: "${tr("aboutApp")}",
                          size: 14,
                          color: Colors.grey,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: MyColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
