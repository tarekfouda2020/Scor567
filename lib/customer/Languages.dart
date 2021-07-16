import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages extends StatefulWidget {
  Function fun;

  Languages(this.fun);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _centerState();
  }
}

class _centerState extends State<Languages> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var _lang;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _setInitLang();
  }

  _setInitLang() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _lang = _prefs.get("lang");
      _loading = false;
    });
  }

  _setChangeLang(val) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");

    var body = {"user_id": "$_user", "type": "0", "lang": "$val"};
    var _data =
        await Http(_scafold).post("AppApi/ChangeClientProfile", body, context);
    if (_data["key"] == 1) {
      if (val == "ar") {
        context.setLocale(Locale("ar","EG"));

      } else {
        context.setLocale(Locale("en","US"));
      }
      setState(() {
        _lang = val;
      });
      _prefs.setString("lang", "$val");
      print("val $val");
    } else {
      LoadingDialog(_scafold).showNotification("${tr("someThingWrong")}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scafold,
        appBar: AppBar(
          title: MyText(
            title: "${tr("lang")}",
            size: 16,
            color: MyColors.white,
          ),
          backgroundColor: MyColors.primary,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: MyColors.white,
                ),
              )),
        ),
        body: _loading
            ? Container(
                child: Center(
                  child: LoadingDialog(_scafold).showLoadingView(),
                ),
              )
            : ListView(
                padding: EdgeInsets.symmetric(vertical: 20),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(.3),
                                width: 1.5))),
                    child: Row(
                      children: <Widget>[
                        MyText(
                          title: "${tr("langAr")}",
                          size: 16,
                          color: Colors.black45,
                        ),
                        Spacer(),
                        Radio(
                            value: "ar",
                            groupValue: _lang,
                            activeColor: MyColors.yellow,
                            onChanged: (val) => _setChangeLang(val))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(.3),
                                width: 1.5))),
                    child: Row(
                      children: <Widget>[
                        MyText(
                          title: "${tr("langEn")}",
                          size: 16,
                          color: Colors.black45,
                        ),
                        Spacer(),
                        Radio(
                            value: "en",
                            groupValue: _lang,
                            activeColor: MyColors.yellow,
                            onChanged: (val) => _setChangeLang(val))
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
