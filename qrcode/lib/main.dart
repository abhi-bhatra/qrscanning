import 'package:flutter/material.dart';
import 'package:qrcode/scanqr.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "scanqr": (context) => ScanQr(),
      },
      debugShowCheckedModeBanner: false,
      home: Container(
        alignment: Alignment.center,
        child: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: ScanQr(),
          backgroundColor: Colors.black,
          loaderColor: Colors.red,
          loadingText: Text('O P E N I N G'),
        ),
      ),
    );
  }
}
