import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/app/main_app.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}
