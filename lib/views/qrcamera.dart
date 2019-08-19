import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCamera extends StatefulWidget {
  @override
  _QrCameraState createState() => _QrCameraState();
}

class _QrCameraState extends State<QrCamera> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = '';
  QRViewController controller;


  void _onQRViewCreated(QRViewController controller) async 
  {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  scanSuccess() {
    if (qrText != '') {
      return 'Scan Successful!';
    } else {
      return 'Please Scan a QR Code';
    }
  }

  void returnMyShards() {
    Navigator.pop(context, qrText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(80),
                child: Text(scanSuccess()),
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated
              ),
            ),
            Padding(
              padding: EdgeInsets.all(80),
                child: FlatButton(
                  onPressed: returnMyShards,
                  child: Text('Done'),
                )
            ),
          ],
        )
      )
    );
  }
}


