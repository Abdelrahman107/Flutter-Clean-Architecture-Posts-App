import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class networkInfoImpl implements NetworkInfo {
  // instance of the class
  final connectionChecker = InternetConnectionChecker();
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
