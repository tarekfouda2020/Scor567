import 'package:flutter/foundation.dart';
class FavLeague extends ChangeNotifier{
  var fav=[];
  void setFav(val){
    fav=val;
    notifyListeners();
  }
  void addFav(index,val){
    fav[index]["Favourite"]=val;
    notifyListeners();
  }
  void removeFav(val){
    fav.removeAt(val);
    notifyListeners();
  }
  void addFavCup(count,index,val){
    fav[count]["DoorName"][index]
    ["Favourite"]=val;
    notifyListeners();
  }
  void addFavCupTennis(count,index,val,i){
    fav[count]["matches"][index]
    ["submatches"][i]["Favourite"]=val;
    notifyListeners();
  }

}