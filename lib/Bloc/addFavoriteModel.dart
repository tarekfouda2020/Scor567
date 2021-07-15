import 'package:flutter/foundation.dart';

class AddFavouriteModel with ChangeNotifier {
  var favourites = [];
  var matches = [];
  var playedMatches = [];
  var notPlayedMatches = [];

  void setPlayedMatches(value) {
    playedMatches = value;
    notifyListeners();
  }

  void setMatches(value) {
    matches = value;
    notifyListeners();
  }

  void removeMatch(index) {
    matches.removeAt(index);
    notifyListeners();
  }

  void removeMatches(index, i) {
    matches[index]["AppHomeViewModelMatch"].removeAt(i);
    notifyListeners();
  }

  void setNotPlayedMatches(value) {
    notPlayedMatches = value;
    notifyListeners();
  }

  void removePlayedMatches(index) {
    playedMatches.removeAt(index);
    notifyListeners();
  }

  void removeNotPlayedMatches(index) {
    notPlayedMatches.removeAt(index);
    notifyListeners();
  }

  void setFav(value) {
    favourites = value;
    notifyListeners();
  }

  void removeFav(index, q) {
    favourites[index]["list"].removeAt(q);
    notifyListeners();
  }

  void changeFav(index, q) {
    if (favourites[index]["list"][q]["fav"] == false ||
        favourites[index]["list"][q]["fav"] == "false") {
      favourites[index]["list"][q]["fav"] = "true";
    } else {
      favourites[index]["list"][q]["fav"] = "false";
    }

    notifyListeners();
  }

  void cleanFav() {
    favourites.clear();
    notifyListeners();
  }
}
