import 'exchange.dart';

class JsonData implements Data {
  List<Map<String, dynamic>> _data = [];

  @override
  void load(String fileName) {
    try {
      final file = File(fileName);
      final jsonString = file.readAsStringSync();
      final dataList = json.decode(jsonString) as List<dynamic>;

      _data = dataList.cast<Map<String, dynamic>>();
    } catch (error) {
      throw DataInvalidException('Error when trying to load data from JSON file: $error');
    }
  }

  @override
  void save(String fileName) {
    try {
      final file = File(fileName);
      final jsonString = json.encode(_data);
      file.writeAsStringSync(jsonString);
    } catch (error) {
      throw DataInvalidException('Error when trying to save data in JSON file: $error');
    }
  }

  @override
  void clear() {
    _data.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => json.encode(_data);

  @override
  set data(String data) {
    try {
      final dataList = json.decode(data) as List<dynamic>;
      _data = dataList.cast<Map<String, dynamic>>();
    } catch (error) {
      throw DataInvalidException('Invalid JSON data format: $error');
    }
  }

  @override
  List<String> get fields {
    if (_data.isNotEmpty) {
      return _data[0].keys.toList();
    }
    return [];
  }
}
