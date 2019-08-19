import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './qrcamera.dart';


class MyShards extends StatefulWidget {
  @override
  _MyShardsState createState() => _MyShardsState();
}

class _MyShardsState extends State<MyShards> {
  var myShards = [];

  @override
  void initState() {
    super.initState();
    getShards();
  }

  saveShards(shard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('shards') != null) {
      var shards = prefs.getStringList('shards');
      shards.add(shard);
      prefs.setStringList('shards', shards);
    } else {
      var shards = <String>[shard];
      prefs.setStringList('shards', shards);
    }
    getShards();
  }

  getShards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('shards') != null) {
    setState(() => myShards = prefs.getStringList('shards'));
    } else {
      setState(() => myShards = ['You have no shards']);
    }
  }

  destroyShards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('shards');
    getShards();
  }

  openCamera() async {
    final result = await
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QrCamera()));
    saveShards(result);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(40.0),
                itemCount: myShards.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Center(child: Text(myShards[index])),
                    );
                  }       
                )
            ),
            FlatButton(
              onPressed: () {openCamera();
              },
              child: Text('Add Shard')
            ),
            FlatButton(
              onPressed: () {destroyShards();
              },
              child: Text('Erase All Shards')
            ),
          ]
      ),
    );
  }
}

 