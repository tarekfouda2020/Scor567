import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<AboutApp> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  bool _loading = true;
  var _content;
  Future _getHome() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "lang": "$_lang",
    };
    var _data = await Http(_scafold).get("AppApi/About", body, context);
    if (_data["key"] == 1) {
      setState(() {
        _loading = false;
        _content = _data["data"];
      });
    } else {
      LoadingDialog(_scafold).showNotification("${_data["msg"]}");
    }
  }

  @override
  void initState() {
    _getHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: Scaffold(
        key: _scafold,
        appBar: AppBar(
          backgroundColor: MyColors.primary,
          centerTitle: true,
          title: MyText(
            title: "${tr("aboutApp")}",
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
            ? Center(
                child: LoadingDialog(_scafold).showLoadingView(),
              )
            : ListView(
                padding: EdgeInsets.symmetric(vertical: 20),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width - 80,
                          decoration: BoxDecoration(
                              color: MyColors.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage("images/scorelogo.png"),
                            fit: BoxFit.contain,
                            width: 200,
                            height: 80,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
//                    child: Html(
//                      data: "هذالنص يمكن استبدالة بنص اخر هذالنص يمكن استبدالة بنص اخر هذالنص يمكن استبدالة بنص اخر هذالنص يمكن استبدالة بنص اخر هذالنص يمكن استبدالة بنص اخر هذالنص يمكن استبدالة بنص اخر هذالنص يمكن استبدالة بنص اخر هذالنص يمكن استبدالة بنص اخر",
//                      defaultTextStyle: TextStyle(
//                        color: Colors.grey,
//                        fontSize: 14,
//                        locale: Locale("ar"),
//                        fontFamily: "cairo",
//                      ),
//                      useRichText: false,
//                    ),
                          child: MyText(
                            title: "${_content["about"].toString()}",
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
