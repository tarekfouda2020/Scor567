import 'package:score/publaic/constants/MyColors.dart';
import 'package:score/publaic/constants/MyText.dart';
import 'package:flutter/material.dart';


class DownBottomSheet {

  List data=[];
  Function(String,String) onTab;
  BuildContext context;
  DownBottomSheet({this.data,this.onTab,this.context});

  show(){
    return  showModalBottomSheet(
        context: context,
        backgroundColor: MyColors.primary,
        builder: (BuildContext bc){
          return Container(
            height: 200,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext con,int position){
                return InkWell(
                  onTap: ()=>onTab(data[position]["name"],data[position]["id"].toString()),
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: MyColors.yellow.withOpacity(.5),width: 1)
                        )
                    ),
                    child: MyText(
                      title: data[position]["name"],
                      color: MyColors.grey,
                      size: 20,
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }

}