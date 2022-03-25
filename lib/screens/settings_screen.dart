import 'package:box_house/services/user_service.dart';
import 'package:box_house/screens/login_screen.dart';
import 'package:box_house/util/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isLocalNotification = false;
  bool isPushNotification = true;
  bool isPrivateAccount = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Configurações",
              style:
                  TextStyle(fontFamily: "Exo2", color: textPrimaryLightColor)),
          backgroundColor: Colors.black,
        ),
        body:
            ScopedModelDescendant<UserService>(builder: (context, child, model) {
          return Container(
              child: Stack(fit: StackFit.expand, children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                "assets/images/cross-2.jpg",
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            SingleChildScrollView(
//            margin: EdgeInsets.all(10.0),
                child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.black,
                color: Colors.white,
                onPressed: () {
                  model.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: new Text("Sair"),
              ),
            )),
          ]));
        }));
  }
}
