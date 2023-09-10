part of 'http.dart';

class HttpFailure {
  final int? statuscode;
  final Object? exception;

  HttpFailure({this.statuscode, this.exception});
}

class NetworkException {}
