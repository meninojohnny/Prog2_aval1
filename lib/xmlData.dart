import 'imports.dart';

class XmlData implements Data {
  XmlDocument _data = XmlDocument();

  @override
  void load(String fileName) {
    try {
      final file = File(fileName);
      final xmlString = file.readAsStringSync();
      _data = XmlDocument.parse(xmlString);
    } catch (error) {
      throw DataInvalidException('Error when trying to load data from XML file: $error');
    }
  }

  @override
  void save(String fileName) {
    try {
      final file = File(fileName);
      final xmlString = _data.toXmlString(pretty: true);
      file.writeAsStringSync(xmlString);
    } catch (error) {
      throw DataInvalidException('Error when trying to save data in XML file: $error');
    }
  }

  @override
  void clear() {
    _data = XmlDocument();
  }

  @override
  bool get hasData => _data.children.isNotEmpty;

  @override
  String get data => _data.toXmlString();

  @override
  set data(String data) {
    try {
      _data = XmlDocument.parse(data);
    } catch (error) {
      throw DataInvalidException('Invalid XML data format: $error');
    }
  }

  @override
  List<String> get fields {
    final root = _data.rootElement;
    final childElements = root.children;
    if (childElements.isNotEmpty) {
      final firstElement = childElements.whereType<XmlElement>().first;
      return firstElement.attributes.map((a) => a.name.qualified).toList();
    }
    return [];
  }
}
