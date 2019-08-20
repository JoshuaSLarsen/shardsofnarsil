import 'package:flutter/material.dart';
import '../views/shardbuilder.dart';
import '../views/myshards.dart';
import '../views/reforgekey.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final _pageOptions = [
    ShardBuilder(),
    MyShards(),
    ReforgeKey()
  ];
 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shards of Narsil',
            style: TextStyle(
              fontStyle: FontStyle.italic, 
              color: Colors.white.withOpacity(1.0),
              fontFamily: 'Exo 2',
              fontSize: 30,
            ),
        ),
        backgroundColor: Colors.green[900],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            title: Text('Shard Builder'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            title: Text('My Shards'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vpn_key),
            title: Text('Reforge Key'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
      ),
      body: _pageOptions[_selectedIndex],
    );

  }
}