// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:flutter/services.dart' show rootBundle;
// // import 'package:pdf_google_fonts/pdf_google_fonts.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('PDF Preview Example'),
//         ),
//         body: PdfPreview(
//           maxPageWidth: 700,
//           allowSharing: false,
//           canChangePageFormat: false,
//           build: (format) => generateCertificate(format),
//         ),
//       ),
//     );
//   }
// }

// Future<Uint8List> generateCertificate(PdfPageFormat pageFormat) async {
//   final pdf = pw.Document();
//   const width = 31.774 * PdfPageFormat.cm;
//   const height = 19.98 * PdfPageFormat.cm;
//   const PdfPageFormat card = PdfPageFormat(width, height, marginAll: 0.0);

//   const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
//   const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
//   const PdfColor baseColor = PdfColor.fromInt(0xFF190A8A);

//   final poppins = await PdfGoogleFonts.poppinsRegular();
//   final poppinsBold = await PdfGoogleFonts.poppinsBold();
//   final libreBaskervilleItalic = await PdfGoogleFonts.libreBaskervilleItalic();

//   const surname = 'AGUMA';
//   const othername = 'BANKS DJDH';

//   final netImage = await networkImage('https://lendsup.sanaa.co/storage/app/public/business/front.png');
//   final backImage = await networkImage('https://lendsup.sanaa.co/storage/app/public/business/back.png');
//   final netImage2 = await networkImage('https://www.pixels.ng/wp-content/uploads/2022/02/DSC_2846.jpg');

//   pdf.addPage(
//     pw.Page(
//       pageTheme: pw.PageTheme(
//         pageFormat: card,
//         theme: pw.ThemeData.withFont(
//           base: poppins,
//           italic: libreBaskervilleItalic,
//           bold: poppinsBold,
//         ),
//         buildBackground: (context) => pw.FullPage(
//           ignoreMargins: true,
//           child: pw.Container(
//             width: width,
//             height: height,
//             color: lightGreen,
//             child: pw.Image(netImage),
//           ),
//         ),
//       ),
//       build: (context) => pw.Container(
//         width: width,
//         height: height,
//         child: pw.Stack(
//           alignment: pw.Alignment.center,
//           fit: pw.StackFit.expand,
//           children: <pw.Widget>[
//             pw.Positioned(
//               top: 57,
//               left: 18,
//               child: pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.start,
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Column(
//                     mainAxisAlignment: pw.MainAxisAlignment.start,
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                         'Nom de famille:',
//                         style: const pw.TextStyle(
//                           color: baseColor,
//                           fontSize: 12,
//                         ),
//                       ),
//                       pw.Text(
//                         'Autre nom:',
//                         style: const pw.TextStyle(
//                           color: baseColor,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                   pw.Container(
//                     padding: const pw.EdgeInsets.only(top: 1, left: 5),
//                     child: pw.Column(
//                       mainAxisAlignment: pw.MainAxisAlignment.start,
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Text(
//                           surname,
//                           style: pw.TextStyle(
//                             color: baseColor,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                         pw.Text(
//                           othername,
//                           style: pw.TextStyle(
//                             color: baseColor,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             pw.Positioned(
//               top: 140,
//               left: 185,
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Container(
//                     padding: const pw.EdgeInsets.only(top: 1, bottom: 5),
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Text(
//                           'Position:',
//                           style: const pw.TextStyle(
//                             color: baseColor,
//                             fontSize: 12,
//                           ),
//                         ),
//                         pw.Text(
//                           'NANDAWULA',
//                           style: pw.TextStyle(
//                             color: baseColor,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   pw.Container(
//                     padding: const pw.EdgeInsets.only(top: 6, bottom: 0),
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Text(
//                           'Matricule:',
//                           style: const pw.TextStyle(
//                             color: baseColor,
//                             fontSize: 12,
//                           ),
//                         ),
//                         pw.Text(
//                           '00/001/SCPT',
//                           style: pw.TextStyle(
//                             color: baseColor,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             pw.Positioned(
//               bottom: 19.7,
//               left: 20.8,
//               child: pw.Container(
//                 width: 147.3,
//                 height: 190,
//                 decoration: const pw.BoxDecoration(color: green),
//                 child: pw.Image(netImage2, fit: pw.BoxFit.cover, width: 147.3, height: 183),
//               ),
//             ),
//             pw.Positioned(
//               bottom: 20,
//               right: 28,
//               child: pw.ClipOval(
//                 child: pw.Container(
//                   width: 60,
//                   height: 40,
//                   child: pw.Opacity(
//                     opacity: 0.4,
//                     child: pw.Image(netImage2),
//                   ),
//                 ),
//               ),
//             ),
//             pw.Positioned(
//               top: 20,
//               right: 20,
//               child: pw.Text(
//                 '123456789',
//                 style: pw.TextStyle(
//                   fontWeight: pw.FontWeight.bold,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );

//   // Back
//   pdf.addPage(
//     pw.Page(
//       pageTheme: pw.PageTheme(
//         pageFormat: card,
//         theme: pw.ThemeData.withFont(
//           base: poppins,
//           italic: libreBaskervilleItalic,
//           bold: poppinsBold,
//         ),
//         buildBackground: (context) => pw.FullPage(
//           ignoreMargins: true,
//           child: pw.Container(
//             width: width,
//             height: height,
//             color: lightGreen,
//             child: pw.Image(backImage),
//           ),
//         ),
//       ),
//       build: (context) => pw.Container(
//         width: width,
//         height: height,
//         child: pw.Stack(
//           alignment: pw.Alignment.center,
//           fit: pw.StackFit.expand,
//           children: <pw.Widget>[
//             pw.Positioned(
//               top: 132,
//               left: 323,
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Container(
//                     padding: const pw.EdgeInsets.only(top: 6, bottom: 0),
//                     child: pw.Text(
//                       'GOME',
//                       style: pw.TextStyle(
//                         color: baseColor,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 10,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             pw.Positioned(
//               bottom: 90,
//               right: 38,
//               child: pw.ClipOval(
//                 child: pw.Container(
//                   width: 60,
//                   height: 40,
//                   child: pw.Opacity(
//                     opacity: 0.4,
//                     child: pw.Image(netImage2),
//                   ),
//                 ),
//               ),
//             ),
//             pw.Positioned(
//               bottom: 17,
//               left: 2,
//               child: pw.Container(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                 child: pw.Column(
//                   mainAxisAlignment: pw.MainAxisAlignment.start,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       '48d5b7f856311ee815c8c859014fd23>>>>>>',
//                       style: const pw.TextStyle(
//                         fontSize: 15,
//                         letterSpacing: 3,
//                       ),
//                     ),
//                     pw.Text(
//                       '1234567189>>>>>>>>>>>>>>>>>>>>' + 'SCPT>>>>',
//                       style: const pw.TextStyle(
//                         fontSize: 15,
//                         letterSpacing: 3,
//                       ),
//                     ),
//                     pw.Text(
//                       surname + '>>>>>' + othername + '>>>>>>>>>>>>>>>' + '5',
//                       style: const pw.TextStyle(
//                         fontSize: 15,
//                         letterSpacing: 3,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );

//   return pdf.save();
// }
