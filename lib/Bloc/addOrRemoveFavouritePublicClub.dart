import 'package:flutter/foundation.dart';

class AddOrRemoveFavouritePublicClub  with ChangeNotifier{
  var favourites = [];
  var favForTeam=[];

  void setFav(value) {
    favourites = value;
    notifyListeners();
  }
  void removeFav(index) {
    favourites.removeAt(index);
    notifyListeners();
  }
  void addFav(value) {
    favourites.add(value);
    notifyListeners();
  }
}