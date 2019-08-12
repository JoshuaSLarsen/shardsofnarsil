import 'package:flutter/material.dart';
import './keybuilder.dart';
import './qrcamera.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shards of Narsil'),
        backgroundColor: Color(0xFF244A26),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vpn_key),
            title: Text('Key Builder'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            title: Text('My Shards'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
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
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QrCamera())
                );
                },
              child: Text(
                'QR Camera',
                style: TextStyle(fontSize: 20)
              ),
            ),
         ]
        )
      ),
    );

  }
}