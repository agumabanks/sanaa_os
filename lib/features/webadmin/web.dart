import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_os/features/webadmin/webcontroller.dart';
// import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LendsUp Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Welcome to LendsUp',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Display data and UI components here
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
