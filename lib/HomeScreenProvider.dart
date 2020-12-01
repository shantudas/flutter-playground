import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends ChangeNotifier {
  String _message = "";
  bool _isMessageSet = false;

  setMessage(String value) {
    if(value.isNotEmpty){
      _message = value;
      _isMessageSet = true;
    }else{
      _isMessageSet = false;
    }

    //Call this whenever there is some change in any field of change notifier.
    notifyListeners();
  }

  String get getMessage => _message;

  bool get isMessageSet => _isMessageSet;
}
