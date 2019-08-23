import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/shard.dart';
import 'qr_generator.dart';


class ShardRow extends StatefulWidget {
  final String name;
  final String myShards;
  final Function() getShards;

  //TODO fix shard row column sizes
  ShardRow(this.name, this.myShards, this.getShards);

  @override
  _ShardRowState createState() => _ShardRowState(this.name, this.myShards, this.getShards);
}

class _ShardRowState extends State<ShardRow> {
  final String name;
  final String myShards;
  final Function() getShards;

  _ShardRowState(this.name, this.myShards, this.getShards);


void nameShard() async {
    SharedPreferences names = await SharedPreferences.getInstance();
    if (names.getStringList('names') != null) {
      var shardNames = names.getStringList('names');
      shardNames.add('turkey');
      names.setStringList('names', shardNames);
    } else {
      var shardNames = <String>['chicken'];
      names.setStringList('names', shardNames);
    }
  }

void generateQRCode(key, value) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QrGenerator(shard: new Shard(key, value))));
}

getKey() {
  return myShards.split(": ")[0];
}

getValue() {
  return myShards.split(": ")[1];
}

  destroyShards(name, shard) async {
    SharedPreferences shardName = await SharedPreferences.getInstance();
    var names = shardName.getStringList('names');
    if (names.contains(name)) {
      names.remove(name);
      shardName.setStringList('names', names);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var shards = shardName.getStringList('shards');
    if (shards.contains(shard)) {
      shards.remove(shard);
      prefs.setStringList('shards', shards);
    }
    widget.getShards();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          gradient: LinearGradient(
            colors: [Colors.grey[400], Colors.blueGrey[500]],
            ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Expanded(
              flex: 2,
              child: CircleAvatar(
                child: Text(name[0].toUpperCase()),
                backgroundColor: Theme.of(context).primaryColor,
                ),
            ),
            Expanded(
              flex: 6,
              child: Text(name)
            ),
            Expanded(
              flex: 2,
              child: FlatButton(
                onPressed: () {
                  generateQRCode(getKey(), getValue());
                },
                child: Icon(
                  Icons.photo_camera,
                  color: Theme.of(context).accentColor,
                  size: 30, 
                 )
              ),
            ),
            Expanded(
              flex: 2,
              child: FlatButton(
                onPressed: () => destroyShards(name, myShards),
                padding: EdgeInsets.all(2.0),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).accentColor,
                  size: 30,
                )
              ),
            ),
          ]
        )
      )
    );
  }
}

 