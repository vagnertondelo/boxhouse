import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'agenda_screen.dart';
import 'login_screen.dart';




class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

//    return Scaffold(
//      body: Container(
//
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/gif/gifsplash.flr"),
//            fit: BoxFit.cover,
//          ),
//        ),
//        child: null /* add child content here */,
//      ),
//    );


    return Container(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            "assets/images/fitnes.jpg",
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
    ])
    );
  }
}
