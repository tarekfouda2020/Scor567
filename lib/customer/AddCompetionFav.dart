import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/customer/AddTeamFav.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:score/publaic/constants/transmition.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AddCompetionFav extends StatefulWidget{
  var teams=[];
  var name;
  var page;
//  لو 1 يبقي من البطوات عاد لو 2 يبقي من النادي
  AddCompetionFav(this.teams,this.name,this.page);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClassState();
  }

}

class ClassState extends State<AddCompetionFav>{

  GlobalKey<ScaffoldState>_scafold=new GlobalKey<ScaffoldState>();

  var _items=[];
  _getTeams(){
    for(int i=0;i<widget.teams.length;i++){
      _items.add({
        "name":"${widget.teams[i]["name"]}",
        "id":"${widget.teams[i]["id"]}",
        "selected":widget.teams[i]["favourite"],

      });
    }
  }
  _getTeamsForChampions(){
    for(int i=0;i<widget.teams.length;i++){
      _items.add({
        "name":"${widget.teams[i]["name"]}",
        "id":"${widget.teams[i]["id"]}",
        "selected":widget.teams[i]["favourite"],

      });
    }
  }
  _setSelectedItem(val,index){
    _items[index]["selected"]=val;
    setState(() {

    });
  }
  @override
  void initState() {
    widget.page==1?_getTeams():_getTeamsForChampions();
    super.initState();
  }
  Future _sendFav(val, index,id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {"user_id": "$_user", "champion_id": "$id", "lang": "$_lang"};
    var _data = await Http(_scafold)
        .post("AppApi/AddChampionToFavouritOrRemove", body, context);
    if (_data["key"] == 1) {
setState(() {
  widget.teams[index]["favourite"]=!widget.teams[index]["favourite"];
});
      _setSelectedItem(val, index);
    } else {

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
          title: MyText(title: widget.name,size: 16,color: MyColors.white,),
          leading: InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios,size: 20,color: MyColors.white,),
          ),
        ),
        body:widget.page==1?
        ListView.builder(
            itemCount: _items.length,
            itemBuilder: (BuildContext con,int index){
              return Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: MyColors.white,
                    border: Border(
                        bottom: BorderSide(color: MyColors.grey.withOpacity(.3),width: 1)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MyText(title: "${_items[index]["name"]}",size: 14,color: Colors.black54,),
                    Checkbox(
                      value: _items[index]["selected"],
                      onChanged: (val)=>_sendFav(val, index,_items[index]["id"]),
                      activeColor: MyColors.yellow,
                      checkColor: MyColors.white,
                    )
                  ],
                ),
              );
            }
        ):
        ListView.builder(
            itemCount: _items.length,
            itemBuilder: (BuildContext con,int index){
              return Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: MyColors.white,
                    border: Border(
                        bottom: BorderSide(color: MyColors.grey.withOpacity(.3),width: 1)
                    )
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, SlideRightRoute(
                        page: AddTeamFav(
                            widget.teams[index]["teams"],_items[index]["name"],_items[index]["id"])
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyText(title: "${_items[index]["name"]}",size: 14,color: Colors.black54,),

                    ],
                  ),
                ),
              );
            }
        ),

//        bottomNavigationBar: InkWell(
//          onTap: (){},
//          child: Container(
//            height: 55,
//            decoration: BoxDecoration(
//              color: MyColors.primary,
//              borderRadius: BorderRadius.only(
//                topRight: Radius.circular(15),
//                topLeft: Radius.circular(15)
//              )
//            ),
//            alignment: Alignment.center,
//            child: MyText(title: "تأكيد",size: 16,color: MyColors.white,),
//          ),
//        ),
      ),
    );
  }

}