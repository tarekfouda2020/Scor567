import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/LabelTextField.dart';
import 'package:score/publaic/constants/LoadingDialog.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }

}

class _classState extends State<ContactUs>{

  GlobalKey<ScaffoldState>_scafold=new GlobalKey<ScaffoldState>();


  TextEditingController _name=new TextEditingController();
  TextEditingController _mail=new TextEditingController();
  TextEditingController _msg=new TextEditingController();
  bool _loading = true;
  var _content ;
  Future _sendMessage() async {
    if(_name.text.trim().isEmpty||_mail.text.trim().isEmpty||_msg.text.trim().isEmpty){
      LoadingDialog(_scafold).showNotification("${tr("fillFields")}");
      return;
    }
    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {
      "name": "${_name.text}",
      "email": "${_mail.text}",
      "msg": "${_msg.text}",
      "lang": "$_lang",
    };
    var _data = await Http(_scafold)
        .post("AppApi/Contact", body, context);
    if (_data["key"] == 1) {
      _name.clear();
      _mail.clear();
      _msg.clear();
      LoadingDialog(_scafold)
          .showNotification("${_data["msg"]}");
    } else {
      LoadingDialog(_scafold)
          .showNotification("${_data["msg"]}");
    }
  }
  Future _getHome() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _lang = _prefs.get("lang");
//    var _user = _prefs.get("user");
    var body = {
      "lang": "$_lang",
    };
    var _data = await Http(_scafold)
        .get("AppApi/About", body, context);
    if (_data["key"] == 1) {
      setState(() {
        _loading = false;
        _content=_data["data"];
      });
    } else {
      LoadingDialog(_scafold)
          .showNotification("${_data["msg"]}");
    }
  }


  @override
  void initState() {
    _getHome();
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


    return Container(
      child: Scaffold(
        key: _scafold,
        appBar: AppBar(
          backgroundColor: MyColors.primary,
          centerTitle: true,
          title: MyText(title: "${tr("contactUs")}",size: 16,color: MyColors.white,),
          leading: InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios,size: 20,color: MyColors.white,),
          ),
        ),
        body:_loading
            ? Container(
          child: Center(
            child: LoadingDialog(_scafold).showLoadingView(),
          ),
        )
            :  ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  MyText(title: "${tr("sendMessage")}",size: 16,color: Colors.black54,),
                  MyText(title: _content["TopDetailsInContactus"],size: 13,color: Colors.black54,),

                  LabelTextField(
                    size: 12,
                    margin: EdgeInsets.only(top: 20),
                    controller: _name,
                    label: "${tr("name")}",
                    isPassword: false,
                    type: TextInputType.text,
                  ),
                  LabelTextField(
                    size: 12,
                    margin: EdgeInsets.only(top: 10),
                    controller: _mail,
                    label: "${tr("email")}",
                    isPassword: false,
                    type: TextInputType.emailAddress,
                  ),
                  LabelTextField(
                    size: 12,
                    margin: EdgeInsets.only(top: 10),
                    controller: _msg,
                    label: "${tr("message")}",
                    isPassword: false,
                    type: TextInputType.text,
                  ),

                  InkWell(
                    onTap: ()=>_sendMessage(),
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 50,right: 10,left: 10,bottom: 20),
                      decoration: BoxDecoration(
                        color: MyColors.primary,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      alignment: Alignment.center,
                      child: MyText(title: "${tr("send")}",size: 16,color: MyColors.white,),
                    ),
                  ),

                  MyText(title: "${tr("orBySocialMedia")}",size: 16,color: Colors.black54,),
                  MyText(title: _content["DownDetailsInContactus"],size: 13,color: Colors.black54,),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            _launchURL(_content["twitter"]);
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("images/twitter.png"),fit: BoxFit.fill),
                              shape: BoxShape.circle
                            ),
                          ),
                        )
                      ],
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