
import 'package:flutter/foundation.dart';

class DaysModel with ChangeNotifier {
  bool _showPrev = true;
  bool _showNext = true;
  var daysList=[];

  bool get showPrev => _showPrev;
  bool get showNext => _showNext;

  void changePrev(value) {
    _showPrev=value;
    notifyListeners();
  }
  void changenext(value) {
    _showNext=value;
    notifyListeners();
  }
  void setDays(val){
    daysList=val;
  }

}