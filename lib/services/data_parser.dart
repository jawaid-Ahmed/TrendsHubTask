class DataParser {
  int getInt(dynamic number) {
    if (number != null && number != "") {
      if (number is String) {
        return int.tryParse(number) ?? 0;
      } else if (number is bool) {
        return number ? 1 : 0;
      }

      return number;
    }

    return 0;
  }

  double getDouble(dynamic number) {
    return (number == null || number == "") ? 0.0 : double.parse('$number');
  }

  bool getBool(dynamic d) {
    if (d is String) {
      return (d == 'true' || d == '1') ? true : false;
    } else if (d is int) {
      return d == 1 ? true : false;
    } else if (d is bool) {
      return d;
    }
    return false;
  }

  String getString(dynamic string) {
    return (string != null) ? "$string" : "";
  }

  String getCapitalizeFirst(String string) {
    if (string.isNotEmpty) {
      return "${string[0].toUpperCase()}${string.substring(1)}";
    }
    return string;
  }

  Map<String, dynamic> getMap(Map<dynamic, dynamic> _data) {
    return (_data is Map<String, dynamic>) ? _data : {};
  }
}

DataParser dataParser = DataParser();
