import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dart_ssss/dart_ssss.dart';
import 'dart:convert';

class ReforgeKey extends StatefulWidget {
  @override
  _ReforgeKeyState createState() => _ReforgeKeyState();
}

class _ReforgeKeyState extends State<ReforgeKey> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = '';
  var secret = '';
  QRViewController controller;
  SecretScheme ss  = SecretScheme(5, 4);
  Map<int, List<int>>shares = {};
  Animation animation;
  AnimationController animationController;


//TODO add copy to clip board to secret

  @override
  void initState() {
    super.initState();
    didUpdateWidget(ReforgeKey());
    animationController = AnimationController(
      duration: Duration(milliseconds: 200), vsync: this
    );

    animation = Tween(begin: 12.0, end: 14.0).animate(animationController)
    ..addListener(() { // .. notation is like .then() in dart
      setState((){});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData; 
        
      });

      var key = qrText.split(":")[0];
      var value = json.decode(qrText.split(":")[1]).cast<int>();
      if (!shares.containsKey(key)){
        animationController.forward();
        Future.delayed(const Duration(milliseconds: 400), () => animationController.reverse());
        shares.addAll({int.parse(key): value});
      }
    });
  }

  scanSuccessful() {
    didUpdateWidget(ReforgeKey());
    if (qrText == 'The Flame of the West has been Forged')  {
      return secret;
    } else if (qrText != '') {
        if (shares.length > 1) {
          return 'Scan Successful!\n ${shares.length} Shards have been collected.';
          //TODO change text to centered
        } else {
          return 'Scan Successful!\n ${shares.length} Shard has been collected.';
        }
    } else {
      return 'Please Scan a Qr Code'; 
    }
  }

  void reforge() {
    // if (secret == '') {
    //   showSnackBar('Test');
    // }
    try {
    List<int> recombinedSecretInBytes = ss.combineShares(shares);
    final reforgedsecret = utf8.decode(recombinedSecretInBytes);
    setState((){
      qrText = 'The Flame of the West has been Forged';
      secret = reforgedsecret;
      animationController.forward();
      Future.delayed(const Duration(milliseconds: 400), () => animationController.reverse());
    });
    print('The Flame of the West has been forged'); // Keep this as an Easter Egg
    } catch(e) {
      if (shares.length < 1) {
        showSnackBar("You haven't scanned any shards");
      }
       showSnackBar('You do not have the required shards to reforge this key');
    }
  }

  showSnackBar(error) {
  final snackBar = SnackBar(
    content: Text(error),
    duration: Duration(seconds: 2),
    );
  _scaffoldKey.currentState.showSnackBar(snackBar);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(40),
                child: Container(
                  height: 35,
                  child: Text(scanSuccessful(),
                    style: TextStyle(
                      fontSize: animation.value,

                    ),
                  ),
                ),
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated
              ),
            ),
            Padding(padding: EdgeInsets.all(15),
            ),
            Expanded(
              child: Column(children: <Widget>[
                RaisedButton(
                  onPressed: reforge,
                  child: Text('Reforge Key',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            )
          )
         ]
        )
      )
    );
  }
}