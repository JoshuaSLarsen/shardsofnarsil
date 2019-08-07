import 'package:flutter/material.dart';
import 'package:dart_ssss/dart_ssss.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  Home();
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Map<int, List<int>>shares = {};
  SecretScheme ss = new SecretScheme(5, 3);
  Map<int, List<int>>someshares = {73: [26, 20, 87, 20, 25, 133, 37, 57, 171, 86, 241, 164, 31, 60, 191, 169, 141, 62, 13], 161: [221, 212, 158, 94, 212, 22, 248, 7, 81, 177, 197, 191, 23, 58, 81, 130, 180, 124, 237], 99: [106, 10, 241, 195, 179, 213, 247, 143, 25, 179, 72, 196, 46, 50, 73, 152, 172, 65, 96], 229: [88, 137, 185, 80, 224, 232, 212, 73, 183, 253, 178, 206, 111, 94, 132, 93, 125, 37, 71]};
  

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