import 'package:box_house/services/user_service.dart';
import 'package:box_house/util/colors.dart';
import 'package:box_house/util/responsive_screen.dart';
import 'package:box_house/widgets/bottom_curve_painter.dart';
import 'package:box_house/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class ForgotPassScreen extends StatefulWidget {
  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _emailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Screen sizeCustom;

  @override
  Widget build(BuildContext context) {

    sizeCustom = Screen(MediaQuery.of(context).size);

    return PageView(
      children: <Widget>[
        Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text('Esqueci Minha Senha'),
              elevation: 2.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }),
              // title: Text("Register"),
              centerTitle: true,
              actions: <Widget>[],
            ),
            body: ScopedModelDescendant<UserService>(
              builder: (context, child, model) {
                if (model.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return Form(
                    key: _formKey,
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                      Positioned.fill(
                        child: Image.asset(
                          "assets/images/login-app.png",
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
//                      ClipPath(
//                          clipper: BottomShapeClipper(),
//                          child: Container(
//                            color: colorCurve,
//                          )),
                      SingleChildScrollView(
                          child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: sizeCustom.getWidthPx(25),
                            vertical: sizeCustom.getWidthPx(50)),
                        child: Column(
                          children: <Widget>[
//                            _forgotGradientText(),
                            SizedBox(height: sizeCustom.getWidthPx(40)),
                            _passwordIconWidget(),
                            SizedBox(height: sizeCustom.getWidthPx(30)),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "E-mail",
//                                     hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),

//                                     contentPadding:
//                                     EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                                     border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(32.0)),
                                icon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (text) {
                                if (text.isEmpty || !text.contains("@"))
                                  return "Email inválido";
                              },
                            ),

                            SizedBox(height: sizeCustom.getWidthPx(50)),

                            SizedBox(
                              child: new Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      onPressed: () {
                                        if (_emailController.text.isEmpty) {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Insira seu email para redefinir e clique novamente"),
                                            backgroundColor: Colors.redAccent,
                                            duration: Duration(seconds: 4),
                                          ));
                                        } else {
                                          model.recoverPass(
                                              _emailController.text);
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text("Email enviado verifique"),
                                            backgroundColor: Colors.blue,
                                            duration: Duration(seconds: 4),
                                          ));
                                        }
                                      },
                                      child: Text("Redefinir Senha",
                                          textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      textColor: Colors.white,
                                      color: Theme.of(context).primaryColor,

                                    ),
                                  ),
                                ],
                              ),
                            ),

//                                 SizedBox(
//                                   height: 44.0,
//                                   child: RaisedButton(
//                                     //color: Colors.lightBlueAccent,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(24),
//                                     ),
//
//                                     child: Text(
//                                       "Login",
//                                       style: TextStyle(
//                                         fontSize: 18.0,
//                                       ),
//                                     ),
//                                     textColor: Colors.white,
//                                     color: Theme.of(context).primaryColor,
//                                     onPressed: () {
//                                       if (_formKey.currentState.validate()) {}
//                                       model.signIn(
//                                           email: _emailController.text,
//                                           pass: _passController.text,
//                                           onSuccess: _onSuccess,
//                                           onFail: _onFail);
//                                     },
//                                   ),
//                                 ),
                          ],
                        ),
                      ))
                    ]));
              },
            )),
      ],
    );
  }
}

GradientText _forgotGradientText() {
  return GradientText('Esqueci senha',
      gradient: LinearGradient(colors: [
        Color.fromRGBO(0, 0, 0, 1.0),
        Color.fromRGBO(128, 220, 0, 0.7),
      ]),
      style: TextStyle(
          fontFamily: 'Exo2', fontSize: 36, fontWeight: FontWeight.bold));
}
CircleAvatar  _passwordIconWidget(){

  return CircleAvatar(
    radius: 85.0,
    child: Image.asset("assets/images/icons/imgforgot.png"),
    backgroundColor: textPrimaryColor,
  );
}
