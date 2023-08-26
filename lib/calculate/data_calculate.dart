import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';

class GetNameChemical with ChangeNotifier {
  String _name = "Хлор";
  String get getName => _name;
  void changeName(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetVerticalStability with ChangeNotifier {
  String _name = "Інверсія";
  String get getVerticalStability => _name;
  void changeVerticalStability(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetPhisicalStat with ChangeNotifier {
  String _name = "Рідкий";
  String get getPhisicalStat => _name;
  void changePhisicalStat(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetProbability with ChangeNotifier {
  String _name = "Довгострокове";
  String get getProbability => _name;
  void changeProbability(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetEmountNHR with ChangeNotifier {
  double _name = 1000;
  double get getEmountNHR => _name;
  void changeEmountNHR(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetWindSpeed with ChangeNotifier {
  double _name = 1;
  double get getWindSpeed => _name;
  void changeWindSpeed(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetTemperature with ChangeNotifier {
  double _name = 20;
  double get getTemperature => _name;
  void changeTemperature(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetCoefficient with ChangeNotifier {
  double _name = 0.5;
  double get getCoefficient => _name;
  void changeCoefficient(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetPalletHeight with ChangeNotifier {
  double _name = 0;
  double get getPalletHeight => _name;
  void changePalletHeight(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetWindDirection with ChangeNotifier {
  double _name = 0;
  double get getWindDirection => _name;
  void changeWindDirection(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetAnglF1 with ChangeNotifier {
  int _name = 0;
  int get getAnglF1 => _name;
  void changeAnglF1(int newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetAnglF2 with ChangeNotifier {
  double _name = 0;
  double get getAnglF2 => _name;
  void changeAnglF2(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetRadiusAccident with ChangeNotifier {
  double _name = 0;
  double get getRadiusAccident => _name;
  void changeRadiusAccident(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetPrimaryDepth with ChangeNotifier {
  double _name = 0;
  double get getPrimaryDepth => _name;
  void changePrimaryDepth(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetSecondaryDepth with ChangeNotifier {
  double _name = 0;
  double get getSecondaryDepth => _name;
  void changeSecondaryDepth(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetGlobalDepth with ChangeNotifier {
  double _name = 0;
  double get getGlobalDepth => _name;
  void changeGlobalDepth(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetTimeSinceAccident with ChangeNotifier {
  double _name = 240;
  double get getTimeSinceAccident => _name;
  void changeTimeSinceAccident(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetDistanceToTheObject with ChangeNotifier {
  double _name = 1;
  double get getDistanceToTheObject => _name;
  void changeDistanceToTheObject(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetPopulationDensity with ChangeNotifier {
  double _name = 1000;
  double get getPopulationDensity => _name;
  void changePopulationDensity(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetAffectedArea with ChangeNotifier {
  double _name = 1;
  double get getAffectedArea => _name;
  void changeAffectedArea(double newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetProtectionFactor with ChangeNotifier {
  double _protName = 0.72;
  double get getProtectionFactor => _protName;
  void changeProtectionFactor(double newName) {
    _protName = newName;
    notifyListeners();
  }
}

class GetEvaporationTime with ChangeNotifier {
  double _protName = 0;
  double get getEvaporationTime => _protName;
  void changeEvaporationTime(double newName) {
    _protName = newName;
    notifyListeners();
  }
}

class GetAreaFirst with ChangeNotifier {
  double _protName = 0;
  double get getAreaFirst => _protName;
  void changeAreaFirst(double newName) {
    _protName = newName;
    notifyListeners();
  }
}

class GetAreaSecond with ChangeNotifier {
  double _protName = 0;
  double get getAreaSecond => _protName;
  void changeAreaSecond(double newName) {
    _protName = newName;
    notifyListeners();
  }
}

class GetAreaPZHZ with ChangeNotifier {
  double _protName = 0;
  double get getAreaPZHZ => _protName;
  void changeAreaPZHZ(double newName) {
    _protName = newName;
    notifyListeners();
  }
}

class GetTappedPoints with ChangeNotifier {
  LatLng _protName = LatLng(49.7, 31.7);
  LatLng get getTappedPoints => _protName;
  void changeTappedPoints(LatLng newName) {
    _protName = newName;
    notifyListeners();
  }
}

class GetZoom with ChangeNotifier {
  double _name = 5.0;
  double get getZoom => _name;
  void changeZoom(double newName) {
    _name = newName;
    notifyListeners();
  }
}

// ********************** Додаємо дані до розрахунку комплексного показника

class GetSeason with ChangeNotifier {
  String _name = "Літо";
  String get getSeason => _name;
  void changeSeason(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetRelief with ChangeNotifier {
  String _name = "Рівнинний";
  String get getRelief => _name;
  void changeRelief(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetTypeOfVegetation with ChangeNotifier {
  String _name = "Лісиста";
  String get getTypeOfVegetationf => _name;
  void changeTypeOfVegetation(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class GetTypeOfForest with ChangeNotifier {
  String _name = "Хвойні";
  String get getTypeOfForest => _name;
  void changeTypeOfForest(String newName) {
    _name = newName;
    notifyListeners();
  }
}


// ********************** Додаємо дані до розрахунку комплексного показника
