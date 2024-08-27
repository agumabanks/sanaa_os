import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../data/pdf_service.dart';

class PdfController extends GetxController {
  var isLoading = false.obs;

  Future<void> downloadPdf() async {
    isLoading.value = true;
    try {
      // final pdfData = await PdfService.generateCertificate();
      // await PdfService.saveAndSharePdf(pdfData);
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<Directory> getDownloadsDirectory() async {
    final home = Platform.environment['USERPROFILE'] ?? '';
    final downloadsPath = '$home\\Downloads';
    return Directory(downloadsPath);
  }
}
