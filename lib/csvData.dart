import './exchange.dart';

class CsvData implements DelimitedData {
  List<List<String>> _data = [];
  String _delimiter = ',';

  @override
  void load(String fileName) {
    try {
      final file = File(fileName);
      final lines = file.readAsLinesSync();
      _data = lines.map((line) => line.split(_delimiter)).toList();
    } catch (error) {
      throw DataInvalidException('Error when trying to load data from CSV file: $error');
    }
  }

  @override
  void save(String fileName) {
    try {
      final file = File(fileName);
      final lines = _data.map((line) => line.join(_delimiter)).toList();
      file.writeAsStringSync(lines.join('\n'));
    } catch (error) {
      throw DataInvalidException('Error when trying to save data in CSV file: $error');
    }
  }

  @override
  void clear() {
    _data.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => _data.map((row) => row.join(_delimiter)).join('\n');

  @override
  set data(String data) {
    try {
      final lines = data.split('\n');
      _data = lines.map((line) => line.split(_delimiter)).toList();
    } catch (error) {
      throw DataInvalidException('Invalid CSV data format: $error');
    }
  }

  @override
  List<String> get fields {
    if (_data.isNotEmpty) {
      return _data.first;
    }
    return [];
  }

  @override
  String get delimiter => _delimiter;
}
