import 'package:flutter/material.dart';
import 'package:dart_ssss/dart_ssss.dart';
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

void createShards(input)  {
  setState((){
    codeInput = input; ss  = SecretScheme(shardTotal, threshold);
  });
  print('stuff');
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
    List<int> recombinedSecretInBytes = ss.combineShares(shares);

  

    print('secretcode');
    print(secretcode);
    print('');

    print("Secret");
    print(secretInByteValues);
    print("");

    print("ss");
    print(ss);
    print("");

    print("Each Share");
    shares.forEach(iterateMapEntry);
    print("");

    print("Shares in an array");
    print(shares);
    print("");

}

void reforge() {
  List<int> recombinedSecretInBytes = ss.combineShares(someshares);
  final reforgedsecret = utf8.decode(recombinedSecretInBytes);
  print('The Flame of the West has been forged');
  print(recombinedSecretInBytes);
  print(reforgedsecret);
}

  Widget build(BuildContext context) {
      // print(armies);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Enter Number of Shards',
            style: TextStyle(
              fontStyle: FontStyle.italic, 
              color: Colors.black.withOpacity(1.0),
              fontFamily: 'Papyrus',
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
              fontStyle: FontStyle.italic, 
              color: Colors.black.withOpacity(1.0),
              fontFamily: 'Papyrus',
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
              fontStyle: FontStyle.italic, 
              color: Colors.black.withOpacity(1.0),
              fontFamily: 'Papyrus',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 1, 10),
                        child: Text('${key} : ',
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(0),
                        child: Text('${shares[key]}')
                        ),
                        FlatButton(
                          onPressed: () {
                            generateQRCode(key.toString(), shares[key].toString());
                          },
                          child: Icon(
                            Icons.photo_camera,
                            color: Colors.green[600],
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
}

