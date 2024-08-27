import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<Uint8List> generateCertificate(
    String clientName, 
    String clientPan, 
    String cvv,
    String split,
    String qrCodeSvg, 
  ) async {
    final pdf = pw.Document();
    const width = 31.774 * PdfPageFormat.cm;
    const height = 19.98 * PdfPageFormat.cm;
    const PdfPageFormat card = PdfPageFormat(width, height, marginAll: 0.0);

    final poppins = await PdfGoogleFonts.poppinsMedium();
    final poppinsBold = await PdfGoogleFonts.poppinsBold();
    final libreBaskervilleItalic = await PdfGoogleFonts.libreBaskervilleItalic();

    final ByteData frontImageData = await rootBundle.load('assets/cards/front.png');
    final frontImage = pw.MemoryImage(frontImageData.buffer.asUint8List());

    final ByteData backImageData = await rootBundle.load('assets/cards/back.png');
    final backImage2 = pw.MemoryImage(backImageData.buffer.asUint8List());

    // Convert SVG to PNG Uint8List
    final Uint8List qrCodePng = await _generateQrCodePng(qrCodeSvg);
    final pw.MemoryImage qrImage = pw.MemoryImage(qrCodePng);

    final rubikFontData = await rootBundle.load('assets/fonts/Rubik-Light.ttf');
    final rubikFont = pw.Font.ttf(rubikFontData.buffer.asByteData());

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: card,
          theme: pw.ThemeData.withFont(
            base: poppins,
            italic: libreBaskervilleItalic,
            bold: poppinsBold,
          ),
          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Image(frontImage),
          ),
        ),
        build: (context) => pw.Stack(
          alignment: pw.Alignment.center,
          fit: pw.StackFit.expand,
          children: <pw.Widget>[
            pw.Positioned(
              bottom: 50,
              left: 50,
              child: pw.Text(
                clientName,
                style: pw.TextStyle(
                  font: rubikFont,
                  color: PdfColors.white,
                  fontSize: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Back page logic
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: card,
          theme: pw.ThemeData.withFont(
            base: poppins,
            italic: libreBaskervilleItalic,
            bold: poppinsBold,
          ),
          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Image(backImage2),
          ),
        ),
        build: (context) => pw.Stack(
          alignment: pw.Alignment.center,
          fit: pw.StackFit.expand,
          children: <pw.Widget>[
            pw.Positioned(
              top: 210,
              left: 280,
              child: pw.Text(
                'CVV $cvv', // Replace with actual CVV if needed
                style: pw.TextStyle(
                  font: rubikFont,
                  color: PdfColors.black,
                  fontSize: 17,
                  letterSpacing: 4,
                ),
              ),
            ),
            pw.Positioned(
              bottom: 180,
              left: 36,
              child: pw.Text(
                 _formatPan(clientPan),
                style: pw.TextStyle(
                  font: rubikFont,
                  color: PdfColors.white,
                  fontSize: 28,
                  letterSpacing: 4,
                ),
              ),
            ),
            pw.Positioned(
              bottom: 100,
              left: 36,
              child: pw.Text(
                'VALID THR \n$split', // Replace with actual expiry date if needed
                style: pw.TextStyle(
                  font: rubikFont,
                  color: PdfColors.white,
                  fontSize: 17,
                  letterSpacing: 4,
                ),
              ),
            ),

              pw.Positioned(
                bottom: 150,
                right: 40,
                child: pw.Container(
                  padding: pw.EdgeInsets.all(5),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.white,
                    borderRadius: pw.BorderRadius.circular(7),
                  ),
                  height: 220, // Set the display height to match the container
                  width: 220,  // Set the display width to match the container
                  child: pw.Center(
                    child: pw.Image(
                    qrImage,
                    fit: pw.BoxFit.fill,  // Ensure the image fills the container
                    width: 200,           // Force the image to scale to this width
                    height: 200,          // Set the height to control final display size
                  ),
                  )
                ),
              ),

          
          ],
        ),
      ),
    );

    return pdf.save();
  }

  static Future<void> saveAndSharePdf(Uint8List pdfData, String clientName) async {
    final directory = await getDownloadsDirectory();
    final file = File('${directory?.path}/$clientName.pdf');
    await file.writeAsBytes(pdfData);
    print('PDF saved to: ${file.path}');
  }

  
 // Helper function to format the PAN
  static String _formatPan(String pan) {
    return pan.replaceAllMapped(
      RegExp(r'.{4}'),
      (match) => '${match.group(0)} ',
    ).trim(); 
  }

static Future<Uint8List> _generateQrCodePng2(String qrCodeSvg) async {
    final DrawableRoot svgRoot = await svg.fromSvgString(qrCodeSvg, qrCodeSvg);
    final Picture picture = svgRoot.toPicture();

    // Create the image at a high resolution (e.g., 300x300)
    final ui.Image image = await picture.toImage(600, 600);
    final ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    return bytes!.buffer.asUint8List();
}


static Future<Uint8List> _generateQrCodePng(String qrCodeSvg) async {
  final DrawableRoot svgRoot = await svg.fromSvgString(qrCodeSvg, qrCodeSvg);

  // Get the original size of the SVG
  final Size svgSize = svgRoot.viewport.viewBoxRect.size;

  // Calculate a scale factor to generate a high-resolution image
  // while maintaining the aspect ratio
  const desiredResolution = 300; // Adjust as needed
  final scaleFactor = desiredResolution / max(svgSize.width, svgSize.height);

  // Create the image at the calculated high resolution
  final ui.Image image = await svgRoot.toPicture(
    size: svgSize * scaleFactor,
  ).toImage(
    (svgSize.width * scaleFactor).toInt(),
    (svgSize.height * scaleFactor).toInt(),
  );

  final ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);

  return bytes!.buffer.asUint8List();
}

}
