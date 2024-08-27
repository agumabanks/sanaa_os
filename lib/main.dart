


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_os/features/clients/screens/clientCards.dart';
// import 'client_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Client Cards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClientListScreen(),
    );
  }
}



