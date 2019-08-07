import 'package:flutter/material.dart';
import 'package:dart_ssss/dart_ssss.dart';
import 'dart:convert';

class KeyBuilder extends StatefulWidget {
  KeyBuilder();
  @override
  KeyBuilderState createState() => KeyBuilderState();
}

class KeyBuilderState extends State<KeyBuilder> {
  Map<int, List<int>>shares = {};
  SecretScheme ss = new SecretScheme(5, 3);
  Map<int, List<int>>someshares = {};
  

void secret() {
    List<int> secretcode = utf8.encode("8fhgelfhz3843hgh343");
    List<int> secretInByteValues = secretcode;
        
    setState((){shares = ss.createShares(secretInByteValues);});
    List<int> recombinedSecretInBytes = ss.combineShares(shares);

    void iterateMapEntry(key, value) {
      shares[key] = value;
      print('$key:$value');//string interpolation in action
    }

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
      appBar: AppBar(
        backgroundColor: Color(0xFF244A26),
        title: Text(
          'Shards of Narsil',
            style: TextStyle(
              fontStyle: FontStyle.italic, 
              color: Colors.black.withOpacity(1.0),
              fontFamily: 'Papyrus',
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                reforge();
                },
              child: Text('Reforge Andúril')
            ),
          ],
        ), 
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: secret,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF244A26),
      ),
    );
  }
}