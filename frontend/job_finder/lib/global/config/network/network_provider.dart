import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectionProvider extends ChangeNotifier {
  bool isConnected = true;

  void checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    isConnected = connectivityResult != ConnectivityResult.none;
    
    notifyListeners();
  }
}
