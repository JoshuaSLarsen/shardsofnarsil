import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class ReforgeKey extends StatefulWidget {
  @override
  _ReforgeKeyState createState() => _ReforgeKeyState();
}

class _ReforgeKeyState extends State<ReforgeKey> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = '';
  var qrArray = [];
  QRViewController controller;
  
  void chicken() {
    print('chcken');
  }

  void _onQRViewCreated(QRViewController controller) async 
  {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
      if (!qrArray.contains(scanData)){
        qrArray.add(scanData);
        print(qrArray);      
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(40),
                child: Text(qrText),
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated
              ),
            ),
            Expanded(
              child: Column(children: <Widget>[
                Text("this is the result of scan: $qrText"),
                FlatButton(
                  onPressed: null,
                  child: Text('BUTTON')
            ),
              ],)
            )
           
         ]
        )
      )
    );
  }
}