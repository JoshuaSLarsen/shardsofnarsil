import 'package:flutter/material.dart';
import './keybuilder.dart';
import './qrgenerator.dart';

class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shards of Narsil'),
        backgroundColor: Color(0xFF244A26),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[    
            Text("hello"),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => KeyBuilder())
                );
                },
              child: Text(
                'KeyBuilder',
                style: TextStyle(fontSize: 20)
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QrGenerator())
                );
                },
              child: Text(
                'QR Builder',
                style: TextStyle(fontSize: 20)
              ),
            ),
         ]
        )
      ),
    );

  }
}