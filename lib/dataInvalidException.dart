class DataInvalidException implements Exception {
  final String msg;

  DataInvalidException(this.msg);

  @override
  String toString() => 'DataInvalidException: $msg';
}
