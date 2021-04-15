// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:hostel_app/pdfgen/PdfPreviewScreen.dart';
//
//
// class MyHomePage extends StatelessWidget {
//   final pdf = pw.Document();
//   final String approve = "This PDF is automated Generated", username = "Jack";
//
//   writeOnPdf() {
//     pdf.addPage(pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       margin: pw.EdgeInsets.all(20),
//       build: (pw.Context context) {
//         return <pw.Widget>[
//           pw.Header(
//               level: 0,
//               child: pw.Text("MUJ OutPass",
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                       fontSize: 35, fontWeight: pw.FontWeight.bold))),
//
//           pw.Header(
//               level: 1,
//               child: pw.Text("Applicant Detail",
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                       fontSize: 35, fontWeight: pw.FontWeight.bold))),
//
//           // pw.Paragraph(
//           //     text: "Test Test Test"
//           // ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Student Name: ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text(username,
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Registration Number:: ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("20202020",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Block: ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("B4",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Room Number: ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("88",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Reason: ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("Pandemic Situation",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Mode of Transportation: ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("Train",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Start Date: ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("15/3/20",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "End Date: ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("15/8/20",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Student Contact Number ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("9898989898",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//
//           pw.Header(
//               level: 0,
//               child: pw.Text("Parent Detail",
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                       fontSize: 35, fontWeight: pw.FontWeight.bold))),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Parent Name ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("Tom",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Parent Contact Number ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("9999999999",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Header(
//               level: 0,
//               child: pw.Text("Mentor Detail",
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                       fontSize: 35, fontWeight: pw.FontWeight.bold))),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Mentor Name ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("Jerry",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Text(
//                 "Mentor Contact Number ",
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text("8888888888",
//                   style: pw.TextStyle(
//                       fontSize: 22, fontWeight: pw.FontWeight.normal)),
//             ],
//           ),
//
//           pw.SizedBox(height: 30),
//           pw.Row(
//             children: [
//               pw.Text(
//                 approve,
//                 style:
//                     pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//               ),
//             ],
//           ),
//         ];
//       },
//     ));
//   }
//
// //  Future savePdf() async{
// //    Directory documentDirectory = await getApplicationDocumentsDirectory();
// //
// //    String documentPath = documentDirectory.path;
// //
// //    File file = File("$documentPath/$username+OutPass.pdf");
// //
// //    file.writeAsBytesSync(pdf.save());
// //  }
//   Future savePDF() async {
//     final Directory documentDirectory =
//         await getApplicationDocumentsDirectory();
//
//     final String documentPath = documentDirectory.path;
//
//     final File file = File("$documentPath/$username+OutPass.pdf");
//
//     print('Save as file ${file.path} ...');
//     await file.writeAsBytes(pdf.save());
//     OpenFile.open(file.path);
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("MUJ OUTPASS"),
//       ),
//
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "Generate OutPass",
//               style: TextStyle(fontSize: 34),
//             )
//           ],
//         ),
//       ),
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           writeOnPdf();
//           await savePDF();
//
//           Directory documentDirectory =
//               await getApplicationDocumentsDirectory();
//
//           String documentPath = documentDirectory.path;
//
//           String fullPath = "$documentPath/example.pdf";
//
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => PdfPreviewScreen(
//                         path: fullPath,
//                       )));
//         },
//         child: Icon(Icons.save),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
