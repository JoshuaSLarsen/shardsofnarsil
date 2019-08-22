import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AddToMyShards extends StatefulWidget {
  @override
  _AddToMyShardsState createState() => _AddToMyShardsState();
}

class _AddToMyShardsState extends State<AddToMyShards> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = '';
  var shardName = '';
  List shard = [];


  QRViewController controller;


  void _onQRViewCreated(QRViewController controller) async 
  {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
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
    //TODO prevent creating a shard without qrText, add a snackbar
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
    content: Text(error),
    duration: Duration(seconds: 3),
    );
  _scaffoldKey.currentState.showSnackBar(snackBar);
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
              nameShard();
            }),
        ],
      );
    },
  );
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
                child: Text(scanSuccess()),
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: _nameModal,
                  child: Text('Save'),
                )
            ),
            Padding(padding: EdgeInsets.all(20),)
          ],
        )
      )
    );
  }
}


