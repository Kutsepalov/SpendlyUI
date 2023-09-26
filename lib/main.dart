// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:spendly_ui/view/pages/auth/authentication_page.dart';
import 'package:spendly_ui/view/pages/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isAuthorized = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spendly',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: AuthenticationPage(),
    );
  }
}
