import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/Http.dart';
import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AddTeamFav extends StatefulWidget{
  var teams=[];
  var name;
  var championId;
  AddTeamFav(this.teams,this.name,this.championId);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClassState();
  }

}

class ClassState extends State<AddTeamFav>{

  GlobalKey<ScaffoldState>_scafold=new GlobalKey<ScaffoldState>();


  var _items=[];
  _getTeams(){
    for(int i=0;i<widget.teams.length;i++){
      _items.add({
        "name":"${widget.teams[i]["name"]}",
        "id":"${widget.teams[i]["id"]}",
        "selected":widget.teams[i]["favourite"]

      });
    }

  }
  _setSelectedItem(val,index){
    _items[index]["selected"]=val;
    setState(() {

    });
  }
  Future _sendFav(val, index,id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _user = _prefs.get("user");
    var _lang = _prefs.get("lang");
    var body = {"user_id": "$_user", "team_id": "$id", "lang": "$_lang"};
    var _data = await Http(_scafold)
        .post("AppApi/AddTeamToFavouritOrRemove", body, context);
    if (_data["key"] == 1) {
      widget.teams[index]["favourite"]=!widget.teams[index]["favourite"];
      _setSelectedItem(val, index);
    } else {

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


    return Container(
      child: Scaffold(
        key: _scafold,
        appBar: AppBar(
          backgroundColor: MyColors.primary,
          centerTitle: true,
          title: MyText(title: widget.name,size: 14,color: MyColors.white,),
          leading: InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios,size: 20,color: MyColors.white,),
          ),
        ),
        body: ListView.builder(
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
        ),


      ),
    );
  }

}