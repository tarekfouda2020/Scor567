import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:score/customer/tabs/exploreTabs/Competations.dart';
import 'package:score/publaic/constants/MyColors.dart';

import 'exploreTabs/Teams.dart';

// ignore: must_be_immutable
class Explore extends StatefulWidget {
  GlobalKey<ScaffoldState> _scafold;


  Explore(this._scafold, );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _classState();
  }
}

class _classState extends State<Explore> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Column(
            children: <Widget>[
              AppBar(title: Image(
                image: AssetImage("images/scorelogo.png"),
                fit: BoxFit.contain,
                width: 100,
                height: 50,
              ),centerTitle: true,backgroundColor: MyColors.primary,),
              Container(
                height: 60,
                child: Card(
                  margin: EdgeInsets.all(0),
                  child: TabBar(
                    labelColor: MyColors.primary,
                    indicatorColor: MyColors.yellow,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: MyColors.grey,
                    labelPadding: EdgeInsets.symmetric(vertical: 0),
                    labelStyle: TextStyle(fontSize: 14, fontFamily: "cairo"),
                    tabs: [
                      Tab(
                        text: "${tr("Champions")}",
                      ),
                      Tab(
                        text: "${tr("teams")}",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Competations(widget._scafold, ),
                  Teams(widget._scafold, )
                ],
              ),
      ),
    );
  }
}
