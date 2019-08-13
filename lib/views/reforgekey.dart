import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dart_ssss/dart_ssss.dart';
import 'dart:convert';


class ReforgeKey extends StatefulWidget {
  @override
  _ReforgeKeyState createState() => _ReforgeKeyState();
}

class _ReforgeKeyState extends State<ReforgeKey> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = '';
  var secret = '';
  QRViewController controller;
  SecretScheme ss  = SecretScheme(5, 3);
  Map<int, List<int>>shares = {};

  void _onQRViewCreated(QRViewController controller) async 
  {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
      var key = qrText.split(":")[0];
      var value = json.decode(qrText.split(":")[1]).cast<int>();

      if (!shares.containsKey(key)){
        shares.addAll({int.parse(key): value});
        print(shares);      
      }
    });
  }

  scanSuccessful() {
    didUpdateWidget(ReforgeKey());
    if (qrText != '') {
    return 'Scan Successful!\n ${shares.length} Shards have been collected.';
    }
    else {
      return 'Please Scan a Qr Code';
    }
  }

  void reforge() {
    List<int> recombinedSecretInBytes = ss.combineShares(shares);
    final reforgedsecret = utf8.decode(recombinedSecretInBytes);
    setState((){
      secret = reforgedsecret;
    });
    print('The Flame of the West has been forged');
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
                child: Text(scanSuccessful()),
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
                child: Text(secret),
            ),
            Expanded(
              child: Column(children: <Widget>[
                FlatButton(
                  onPressed: reforge,
                  color: Colors.green[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text('Reforge Shards',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Papyrus',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    ),
                  ),
                ),
              ],
            )
          )
         ]
        )
      )
    );
  }
}