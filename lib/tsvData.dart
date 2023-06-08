import 'exchange.dart';

class TsvData implements DelimitedData {
  List<List<String>> _data = [];
  String _fileName = '';

  @override
  void load(String fileName) {
    try {
      _fileName = fileName;
      final file = File(_fileName);
      final lines = file.readAsLinesSync();
      _data = lines.map((line) => line.split(delimiter)).toList();
    } catch (error) {
      throw DataInvalidException('Error when trying to load data from TSV file: $error');
    }
  }

  @override
  void save(String fileName) {
    try {
      final file = File(fileName);
      final lines = _data.map((line) => line.join(delimiter)).toList();
      file.writeAsStringSync(lines.join('\n'));
    } catch (error) {
      throw DataInvalidException('Error when trying to save data in TSV file: $error');
    }
  }

  @override
  void clear() {
    _data.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => _data.map((line) => line.join(delimiter)).join('\n');

  @override
  set data(String data) {
    try {
      final lines = data.split('\n');
      if (lines.isNotEmpty) {
        final firstLine = lines[0];
        final fields = firstLine.split(delimiter);
        if (fields.isNotEmpty) {
          _data = lines.map((line) => line.split(delimiter)).toList();
          return;
        }
      }
      throw DataInvalidException('Invalid TSV data format');
    } catch (e) {
      throw DataInvalidException('Failed to set TSV data: $e');
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
  String get delimiter => '\t';
}
