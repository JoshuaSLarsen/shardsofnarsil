import 'package:flutter/material.dart';
import 'package:dart_ssss/dart_ssss.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './qrgenerator.dart';
import '../util/shard.dart';

class ShardBuilder extends StatefulWidget {
  ShardBuilder();
  @override
  ShardBuilderState createState() => ShardBuilderState();
}

class ShardBuilderState extends State<ShardBuilder> {
  
  Map<int, List<int>>shares = {};
  SecretScheme ss;
  Map<int, List<int>>someshares = {};
  final _formKey = GlobalKey<FormState>();
  String codeInput = '';
  int shardTotal = 5;
  int threshold = 3;
  var numberIndex = List<int>.generate(250, (int index) => index); // [ 0, 1, ... 249, 250]
  var qrText = '';
  var shardName = '';


void createShards(input)  {
  setState((){
    codeInput = input; ss  = SecretScheme(shardTotal, threshold);
  });
} 

iterateMapEntry(key, value) {
  shares[key] = value;
  ('$key:$value').toString();//string interpolation in action
}

void generateQRCode(key, value) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QrGenerator(shard: new Shard(key, value))));
  // print(value);
}

void secret() {
    List<int> secretcode = utf8.encode(codeInput);
    List<int> secretInByteValues = secretcode;
    setState((){shares = ss.createShares(secretInByteValues);});
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
}

handleChange(name) {
    setState(() => shardName = name);
  }

nameShard(key, value) {
  var shard = [shardName, (key + ":" + value)];
  Navigator.pop(context);
  saveShards(shard);
}

  Widget build(BuildContext context) {
      // print(armies);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5)),
            Text('Enter Number of Shards',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontFamily: 'Exo 2',
              fontSize: 15,
              fontWeight: FontWeight.w800
              ),
            ),
            Form(
              key: _formKey,
              child: Column(children: <Widget>[
                TextField(
                keyboardType: TextInputType.number,
                maxLength:3,
                onChanged: (input) {
                setState((){
                  shardTotal = int.parse(input);
                });
                },
                decoration: new InputDecoration(contentPadding: EdgeInsets.all(20)),
            ),
             Text('Enter a Threshold',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontFamily: 'Exo 2',
              fontSize: 15,
              fontWeight: FontWeight.w800
              ),
            ),
                TextField(
                keyboardType: TextInputType.number,
                maxLength:3,
                onChanged: (input) {
                setState((){
                  threshold = int.parse(input);
                });
                },
                decoration: new InputDecoration(contentPadding: EdgeInsets.all(20)),
            ),
             Text('Enter Your Code',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontFamily: 'Exo 2',
              fontSize: 15,
              fontWeight: FontWeight.w800
              ),
            ),
                TextField(
                onChanged: createShards,
                decoration: new InputDecoration(contentPadding: EdgeInsets.all(20))
              ),
              ],)
            ),
            RaisedButton(
              onPressed: (){
                secret();
                },
              child: Text('Create Shards')
            ),
            Expanded(child: new ListView.builder(
                  itemCount: shares.length,
                  itemBuilder: (BuildContext context, int index){
                    int key = shares.keys.elementAt(index);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Shard($key)')
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(90, 10, 10, 0),
                        ),
                        FlatButton(
                          onPressed: () {
                            generateQRCode(key.toString(), shares[key].toString());
                          },
                          child: Icon(
                            Icons.photo_camera,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )
                        ),
                        FlatButton(
                          onPressed: () {
                            _nameModal(key.toString(), shares[key].toString());
                          },
                          
                          child: Icon(
                            Icons.add_circle,
                            color: Theme.of(context).primaryColor,
                            size: 30,  
                          )
                        ),
                      ],
                    );
                  }
                ),
              ),
          ],
        ), 
      ),
    );
  }
 Future<void> _nameModal(key, value) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add to My Shards'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                onChanged: handleChange
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Done'),
            onPressed: () {
              nameShard(key, value);
            }),
        ],
      );
    },
  );
}


}



