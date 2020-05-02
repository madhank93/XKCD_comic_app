import 'package:flutter/material.dart';
import 'package:fluttermvpillustrativeapp/data/dependency_injection.dart';

void main() {
  Injector.configure(Flavor.PROD);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }

}