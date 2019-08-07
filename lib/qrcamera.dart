import 'package:flutter/material.dart';

class QrCamera extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Camera'),
        backgroundColor: Color(0xFF244A26),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Hello"),
         ]
        )
      )
    );
  }
}