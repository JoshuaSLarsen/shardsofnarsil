import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './addtomyshards.dart';
import './shardrow.dart';


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
    print(shard);

    //Set Shard
    if (prefs.getStringList('shards') != null) {
      var shards = prefs.getStringList('shards');
      shards.add(shard[1]);
      prefs.setStringList('shards', shards);
    } else {
      var shards = <String>[shard[1]];
      prefs.setStringList('shards', shards);
    }

    //Set Shard Names
    SharedPreferences shardName = await SharedPreferences.getInstance();

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
      setState(() => myShards = ['You have No Shards']);
    }
  }

  refresh()  {
    getShards();
  }

  openCamera() async {
    final result = await
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddToMyShards()));
    saveShards(result);
  }

  buildRow() {
    if (names.length < 1) {
      return 
      ListView.builder(      
          padding: const EdgeInsets.fromLTRB(120.0, 40, 20, 10),
          itemCount: myShards.length,
          itemBuilder: (BuildContext context, int index) =>Text(myShards[0])
            );
    } else {
      return 
        ListView.builder(
          padding: const EdgeInsets.all(20.0),
          itemCount: myShards.length,
          itemBuilder: (BuildContext context, int index) =>ShardRow(this.names[index], this.myShards[index], this.refresh)
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

