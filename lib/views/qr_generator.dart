import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../util/shard.dart';

class QrGenerator extends StatelessWidget {
  final Shard shard;

  QrGenerator({Key key, @required this.shard}) : super(key: key);
//TODO change appbar size to match
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: shard.key + ': ' + shard.value,
              size: 300.0,
              version: 21
            ),
         ]
        )
      )
    );
  }
}