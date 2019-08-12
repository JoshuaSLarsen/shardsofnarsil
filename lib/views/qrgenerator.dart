import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../util/shard.dart';

class QrGenerator extends StatelessWidget {
  final Shard code;

  QrGenerator({Key key, @required this.code}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        backgroundColor: Color(0xFF244A26),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(code.shard),
            QrImage(
              data: code.shard,
              size: 200.0,
            ),
      
         ]
        )
      )
    );

  }
}