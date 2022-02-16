import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:google_fonts/google_fonts.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPage createState() {
    return _SplashScreenPage();
  }
}

class _SplashScreenPage extends State<SplashScreenPage> {


  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigationPage);
  }

  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed('/MenuRoute');
  }

  @override
  void initState() {
    super.initState();
    // _startUpdateService();
    startTime();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        child: Container(
          width: 135,
          height: 170,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Container(height: 20),
              Text("GITHUB",
                  style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600)),
              Container(height: 20),
              Container(
                height: 5,
                width: 80,
                child: LinearProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue[600]),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}


