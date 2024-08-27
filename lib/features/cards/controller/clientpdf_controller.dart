// client_controller.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sanaa_os/features/clients/data/client_model.dart';

Future<void> downloadClientCard(ClientCards client) async {
  final pdf = pw.Document();
  const width = 31.774 * PdfPageFormat.cm;
  const height = 19.98 * PdfPageFormat.cm;
  const PdfPageFormat card = PdfPageFormat(width, height, marginAll: 0.0);

  final poppins = await PdfGoogleFonts.poppinsMedium();
  final poppinsBold = await PdfGoogleFonts.poppinsBold();

  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: card,
        theme: pw.ThemeData.withFont(
          base: poppins,
          bold: poppinsBold,
        ),
      ),
      build: (context) => pw.Center(
        child: pw.Text(client.clientData.name),
      ),
    ),
  );

  final directory = await getDownloadsDirectory();
  final file = File('${directory?.path}/client_card_${client.clientData.clientid}.pdf');
  await file.writeAsBytes(await pdf.save());
  Get.snackbar('Success', 'PDF saved to ${file.path}');
}
