import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class ScanQr extends StatefulWidget {
  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  String result = "No Link Detected";
  bool hasdata = false;
  var data;

  ///function for storing the qrcode result into a variable
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        hasdata = true;
      });
    } on PlatformException catch (errx) {
      if (errx.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera access Denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $errx";
        });
      }
    } on FormatException {
      setState(() {
        result = "Pressed the back button before scanning";
      });
    } catch (errx) {
      setState(() {
        result = "Unknown Error $errx";
      });
    }
  }

  ///widget build for the app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        backgroundColor: Colors.red,
      ),
      //body: Center(
      /*child: Text(
          result,
          style: new TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),*/
      //),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Column(
          //
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                "Opening Link:- \n$result",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(Icons.web),
              onPressed: hasdata
                  ? () async {
                      if (await canLaunch(result)) {
                        print(result);
                        await launch(result);
                      } else {
                        throw 'Could not launch';
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _scanQR,
        label: Text("SCAN"),
        icon: Icon(Icons.camera_alt),
        //foregroundColor: Colors.red,
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
