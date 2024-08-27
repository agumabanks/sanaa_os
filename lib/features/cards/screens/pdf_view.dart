import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_os/features/cards/controller/cardController.dart';
// import '../controllers/pdf_controller.dart';

class PdfView extends StatelessWidget {
  final PdfController controller = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Download Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.downloadPdf,
                child: controller.isLoading.value
                    ? CircularProgressIndicator()
                    : const Text('Download PDF'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
