import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/animation.dart';


class AddToMyShards extends StatefulWidget {
  @override
  _AddToMyShardsState createState() => _AddToMyShardsState();
}

class _AddToMyShardsState extends State<AddToMyShards> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = '';
  var shardName = '';
  List shard = [];
  Animation animation;
  Animation animateColor;
  AnimationController animationController;
  QRViewController controller;

  //TODO fix memory leak by dismounting from camera

  @override
    void initState() {
      super.initState();
      animationController = AnimationController(
        duration: Duration(milliseconds: 200), vsync: this
      );

      animateColor = ColorTween(begin: Colors.black, end: Colors.green).animate(animationController); 

      animation = Tween(begin: 14.0, end: 16.0).animate(animationController)
      ..addListener(() { // .. notation is like .then() in dart
        setState((){});
      });
    }

  @override
    void dispose() {
      animationController.dispose();
      super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) async 
  {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        animationController.forward();
        Future.delayed(const Duration(milliseconds: 400), () => animationController.reverse());
      });
    });

  }

  scanSuccess() {
    if (qrText != '') {
      return 'Scan Successful!';
    } else {
      return 'Please Scan a QR Code';
    }
  }

  handleChange(name) {
    setState(() => shardName = name);
  }

  nameShard() {
    if (qrText == '') {
      showSnackBar('Please Scan a Qr Code');
      Navigator.of(context).pop();
    } else if (shardName == '') {
      showSnackBar('You must give your shard a name');
    } else {
      shard = [shardName, qrText];
      returnMyShards();
    }
  }

  showSnackBar(error) {
  final snackBar = SnackBar(
    content: Text(error,
    style: TextStyle(fontFamily: 
     'Exo 2'),
    textAlign: TextAlign.center
    ),
    duration: Duration(seconds: 2),
    );
  _scaffoldKey.currentState.showSnackBar(snackBar);
}

  returnMyShards() {
    Navigator.pop(context);
    Navigator.pop(context, shard);
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
              padding: EdgeInsets.fromLTRB(20, 80, 20, 60),
                child: Text(scanSuccess(),
                style: TextStyle(
                  fontSize: animation.value,
                  color: animateColor.value
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
            Padding(
                padding: EdgeInsets.all(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              RaisedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Back'),
                ),
              RaisedButton(
                    onPressed: _nameModal,
                    child: Text('Save'),
                  )
              ],
            ),
            Padding(padding: EdgeInsets.all(20),)
          ],
        )
      )
    );
  }

Future<void> _nameModal() async {
    //TODO refactor into own widget
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Name Your Shard'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                onChanged: handleChange,
                maxLength: 30,
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
              nameShard();
            }),
        ],
      );
    },
  );
}


}


