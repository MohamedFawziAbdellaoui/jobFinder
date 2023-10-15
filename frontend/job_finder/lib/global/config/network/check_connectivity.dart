import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

final _internetConnectionAlertDialogKey = GlobalKey<State>();

Future<void> checkInternetConnection() async {
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    // Check the internet connection.
    final connectivityResult = await Connectivity().checkConnectivity();

    // If the phone is disconnected, show a pop-up.
    if (connectivityResult == ConnectivityResult.none) {
      // Get the state of the AlertDialog widget.
      final state = _internetConnectionAlertDialogKey.currentState;

      // If the state is not null, show the pop-up.
      if (state != null) {
        showDialog(
          context: state.context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text('Please check your internet connection and try again.'),
            actions: [
              TextButton(
                onPressed: () async {
                  // Check the internet connection again.
                  final connectivityResult = await Connectivity().checkConnectivity();

                  // If the internet connection is restored, dismiss the pop-up.
                  if (connectivityResult != ConnectivityResult.none) {
                    Navigator.of(state.context).pop();
                  }
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }
    }
  });
}

void dismissInternetConnectionAlertDialog() {
  // Get the state of the AlertDialog widget.
  final state = _internetConnectionAlertDialogKey.currentState;

  // If the state is not null, dismiss the pop-up.
  if (state != null) {
    Navigator.of(state.context).pop();
  }
}
