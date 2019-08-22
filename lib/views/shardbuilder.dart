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
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<int, List<int>>shares = {};
  SecretScheme ss;
  Map<int, List<int>>someshares = {};
  final _formKey = GlobalKey<FormState>();
  String codeInput = '';
  int shardTotal = 0;
  int threshold = 0;
  var qrText = '';
  var shardName = '';

void generateQRCode(key, value) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QrGenerator(shard: new Shard(key, value))));
}

void secret() {
  if (codeInput.length < 1) {
    showSnackBar('Please enter a Code');
  }

  if (shardTotal < 2) {
    showSnackBar('The Number of Shards must be more than 1');
  }

  if (shardTotal > 255) {
    showSnackBar('The Number of Shards must be less than 256');
  }

  if (threshold > shardTotal) {
    showSnackBar('The Threshold cannot be greater than the Number of Shards');
  }

  if (threshold < 2) {
    showSnackBar('The minimum Threshold is 2');
  }

  setState((){
    ss  = SecretScheme(shardTotal, threshold);
    });
  List<int> secretcode = utf8.encode(codeInput);
  List<int> secretInByteValues = secretcode;
  setState((){shares = ss.createShares(secretInByteValues);});
}

showSnackBar(error) {
  final snackBar = SnackBar(
    content: Text(error),
    duration: Duration(seconds: 2),
    );
  _scaffoldKey.currentState.showSnackBar(snackBar);
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
  var shard = [shardName, (key + ": " + value)];
  Navigator.pop(context);
  saveShards(shard);
}

  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10)),
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
                onChanged: (shardinput) {
                setState((){
                  shardTotal = int.parse(shardinput);
                  });
                },
                decoration: new InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 8, 0, 0))
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
                autocorrect: false,
                onChanged: (thresholdinput) {
                setState((){
                  threshold = int.parse(thresholdinput);
                });
              },
                decoration: new InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 8, 0, 0))
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
                onChanged: (handlecodeinput) {
                setState((){
                  codeInput = handlecodeinput;
                  });
                },
                decoration: new InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 8, 0, 0))
              ),
              ],)
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Container(
                            child: 
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                                child: Text('Shard($key)')
                                ),
                              ),
                            ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: FlatButton(
                              onPressed: () {
                                generateQRCode(key.toString(), shares[key].toString());
                              },
                            child: Icon(
                              Icons.photo_camera,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(right: 2),
                            child: FlatButton(
                              onPressed: () {
                                _nameModal(key.toString(), shares[key].toString());
                              },
                              child: Icon(
                                Icons.add_circle,
                                color: Theme.of(context).primaryColor,
                                size: 30,  
                              )
                            ),
                          ),
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
   //TODO refactor to its own widget
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
          RaisedButton(
            child: Text('Done'),
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              nameShard(key, value);
            }),
        ],
      );
    },
  );
}


}



