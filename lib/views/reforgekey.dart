import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class ReforgeKey extends StatelessWidget {
  
  void chicken() {
    print('chcken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: chicken,
              child: Text('hello')
            ),
         ]
        )
      )
    );
  }
}