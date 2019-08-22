import 'package:flutter/material.dart';
import '../views/shard_builder.dart';
import '../views/my_shards.dart';
import '../views/reforge_key.dart';


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
              color: Theme.of(context).accentColor,
              fontSize: 30
            ),
        ),
        backgroundColor: Theme.of(context).primaryColor),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
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
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _onItemTapped,
      ),
      body: _pageOptions[_selectedIndex],
    );

  }
}