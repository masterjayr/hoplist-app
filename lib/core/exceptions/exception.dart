class GeneralException implements Exception {
  final dynamic message;

  GeneralException({this.message}) : super();
}

class NetworkException implements Exception {
  final dynamic message;

  NetworkException({this.message});
}
