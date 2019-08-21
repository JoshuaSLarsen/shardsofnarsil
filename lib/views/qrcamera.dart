import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCamera extends StatefulWidget {
  @override
  _QrCameraState createState() => _QrCameraState();
}

class _QrCameraState extends State<QrCamera> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = '';
  var shardName = '';

  List shard = [];


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

  handleChange(name) {
    setState(() => shardName = name);
  }

  nameShard() {
    shard = [shardName, qrText];
    returnMyShards();
  }

  Future<void> _nameModal() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Name Your Shard'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                onChanged: handleChange
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Done'),
            onPressed: () {
              nameShard();
            }),
        ],
      );
    },
  );
}

  returnMyShards() {
    Navigator.pop(context);
    Navigator.pop(context, shard);
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
              padding: EdgeInsets.all(10),
                child: FlatButton(
                  onPressed: _nameModal,
                  child: Text('Save'),
                )
            ),
          ],
        )
      )
    );
  }
}


