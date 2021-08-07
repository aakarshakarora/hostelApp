import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/view/futurePage/upcoming.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            'Scan QR Code : स्कैन करें',
                            style: darkTinyText,
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Divider(
                            color: darkBlue,
                            thickness: 0.7,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MaterialButton(
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                                animationDuration: Duration(seconds: 2),
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.4,
                                color: darkerBlue,
                                onPressed: () async {
                                  await controller?.toggleFlash();
                                  setState(() {});
                                },
                                child: FutureBuilder(
                                  future: controller?.getFlashStatus(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData)
                                      return Text(
                                        'Flash: ${snapshot.data ? 'ON' : 'OFF'}',
                                        style: lightTinyText.copyWith(color: white),
                                      );
                                    else
                                      return Container();
                                  },
                                )),
                          ),
                          // Container(
                          //   margin: EdgeInsets.all(8),
                          //   child: ElevatedButton(
                          //       onPressed: () async {
                          //         await controller?.flipCamera();
                          //         setState(() {});
                          //       },
                          //       child: FutureBuilder(
                          //         future: controller?.getCameraInfo(),
                          //         builder: (context, snapshot) {
                          //           if (snapshot.data != null) {
                          //             return Text(
                          //                 'Camera facing ${describeEnum(snapshot.data)}');
                          //           } else {
                          //             return Text('loading');
                          //           }
                          //         },
                          //       )),
                          // )
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: <Widget>[
                      //     Container(
                      //       margin: EdgeInsets.all(8),
                      //       child: ElevatedButton(
                      //         onPressed: () async {
                      //           await controller?.pauseCamera();
                      //         },
                      //         child: Text('pause', style: TextStyle(fontSize: 20)),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: EdgeInsets.all(8),
                      //       child: ElevatedButton(
                      //         onPressed: () async {
                      //           await controller?.resumeCamera();
                      //         },
                      //         child: Text('resume', style: TextStyle(fontSize: 20)),
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController controller) =>
          _onQRViewCreated(controller, context),
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller, context) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      print("QR HAS DATA :${(scanData.code)}");
      setState(() {
        result = scanData;
      });
      controller.dispose();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Upcoming(result.code, describeEnum(result.format))),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
    result = null;
  }
}
