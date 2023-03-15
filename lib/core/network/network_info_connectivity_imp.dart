// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_clean_architecture_example/core/network/network_info.dart';

class NetWorkInfoConnectivityImp implements NetworkInfo {
  final Connectivity connectivity;
  NetWorkInfoConnectivityImp({
    required this.connectivity,
  });

  @override
  Future<bool> get isConected async {
    final result = await connectivity.checkConnectivity();
    return _checkInternetConnection(result);
  }

  static Future<bool> _checkInternetConnection(
      ConnectivityResult connectivityResult) async {
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException {
        return false;
      }
    }
    return false;
  }
}
