abstract class Data {
  void load(String fileName);
  void save(String fileName);
  void clear();
  bool get hasData;
  String get data;
  set data(String data);
  List<String> get fields;
}
