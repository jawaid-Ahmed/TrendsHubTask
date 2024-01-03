import 'package:get_storage/get_storage.dart';
import 'package:trends_hub/services/data_parser.dart';

class DataStoreService {
  static GetStorage box = GetStorage();

  listenKey(String key, Function onTap) async {
    box.listenKey(key, (value) async {
      //await box.write(key, value);
      onTap.call(value);
    });
  }

  setInt(String key, int value) {
    box.write(key, value);
  }

  remove(String key) {
    box.remove(key);
  }

  int getInt(String key) {
    var v = box.read(key);
    return int.parse(v.toString());
  }

  setBool(String key, bool value) {
    box.write(key, value);
  }

  bool getBool(String key) {
    var v = box.read(key);
    if (v != null && v is bool) {
      return v == true ? true : false;
    }
    return false;
  }

  setDouble(String key, double value) {
    box.write(key, value);
  }

  double getDouble(String key) {
    var v = box.read(key);
    return double.parse(v);
  }

  setString(String key, String value) {
    box.write(key, value);
  }

  String getString(String key) {
    var v = box.read(key);
    return v.toString();
  }

  Map<String, dynamic> getMap(String key) {
    var v = box.read(key);
    return dataParser.getMap(v ?? {});
  }

  setMap(String key, Map<String, dynamic> value) {
    box.write(key, value);
  }
}

DataStoreService dataStore = DataStoreService();
