import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerator extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Builder'),
        backgroundColor: Color(0xFF244A26),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("www.google.com"),
            QrImage(
              data: "www.google.com",
              size: 200.0,
            ),
      
         ]
        )
      )
    );

  }
}