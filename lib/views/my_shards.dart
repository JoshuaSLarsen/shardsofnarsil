import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './add_to_my_shards.dart';
import './shard_row.dart';

class MyShards extends StatefulWidget {
  @override
  MyShardsState createState() => MyShardsState();
}

class MyShardsState extends State<MyShards> {
  List<String> myShards = [];
  List<String> names = [];

  @override
  void initState() {
    super.initState();
    getShards();
  }

  saveShards(shard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Set Shard
    if (prefs.getStringList('shards') != null) {
      var shards = prefs.getStringList('shards');
      shards.add(shard[1]);
      prefs.setStringList('shards', shards);
    } else {
      var shards = <String>[shard[1]];
      prefs.setStringList('shards', shards);
    }
    SharedPreferences shardName = await SharedPreferences.getInstance();
    //Set Shard Names
    if (shardName.getStringList('names') != null) {
      var name = shardName.getStringList('names');
      name.add(shard[0]);
      shardName.setStringList('names', name);
    } else {
      var name = <String>[shard[0]];
      shardName.setStringList('names', name);
    }
    getShards();
  }

  getShards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences shardName = await SharedPreferences.getInstance();
    if (prefs.getStringList('shards') != null) {
    setState(() => myShards = prefs.getStringList('shards'));
    setState(() => names = shardName.getStringList('names'));
    } else {
      setState(() => myShards = ["You Don't Have Any Shards"]);
    }
  }

  openCamera() async {
    final result = await
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddToMyShards()));
    if (result != null) {
      saveShards(result);
    }
  }

  buildRow() {
    if (names.length < 1) {
      return 
      ListView.builder(   
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          itemCount: myShards.length,
          itemBuilder: (BuildContext context, int index) =>
            Text(myShards[0],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14))
            );
    } else {
      return 
        ListView.builder(
          key: Key(names.toString()),   
          padding: const EdgeInsets.all(20.0),
          itemCount: myShards.length,
          itemBuilder: (BuildContext context, int index) =>ShardRow(this.names[index], this.myShards[index], this.getShards)
          );
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: buildRow()
            ),
            Padding(
              padding: EdgeInsets.all(10),),
            RaisedButton(
              onPressed: () {openCamera();
              },
              child: Text('Add Shard')
            ),
            Padding(
              padding: EdgeInsets.all(10),),
          ]
      ),
    );
  }
}

