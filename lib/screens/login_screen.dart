import 'package:box_house/screens/forgot_pass_screen.dart';
import 'package:box_house/screens/home_screen.dart';
import 'package:box_house/screens/home_teacher_screen.dart';
import 'package:box_house/screens/signup_screen.dart';
import 'package:box_house/services/user_service.dart';
import 'package:box_house/util/responsive_screen.dart';
import 'package:box_house/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passController = TextEditingController();

  // final _paisController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  Screen sizeCustom;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

 void getUsername() async {
    UserService service = new UserService();
    String user = await service.getUsername();
    String pass = await service.getUserpass();
    setState(() {
      if (user != null && user.isNotEmpty) {
        _emailController.text = user;
        _passController.text= pass;
      } else {
      _emailController.text = "";
      _passController.text= "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    sizeCustom = Screen(MediaQuery.of(context).size);

    return PageView(
      children: <Widget>[
        Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            //    appBar: AppBar(

//          title: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Image.asset(
//                'assets/images/logo.png',
//                fit: BoxFit.contain,
//                height: 32,
//              ),
//              Container(
//                  padding: const EdgeInsets.all(8.0), child: Text('YourAppTitle'))
//            ],
//
//          ),

            //  title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
//          title: Text("Entrar"),
//          centerTitle: true,
//          actions: <Widget>[
//            FlatButton(
//              child: Text(
//                "Criar Conta",
//                style: TextStyle(
//                    fontSize: 15.0
//                ),
//              ),
//              textColor: Colors.white,
//              onPressed: (){
//                Navigator.of(context).push(
//                    MaterialPageRoute(builder: (context)=>SignUpScreen())
//                );
//              },
//            )
//          ],
            //     ),

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
//                          clipper: TopShapeClipper(),
//                          child: Container(
//                            color: colorCurve,
//                          )),
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
                            SizedBox(
                              child: Image.asset(
                                "assets/images/logo-box.png",
                                height: 160,
                                width: 160,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
//                                 _loginGradientText(),
//                                 Image.network('assets/images/icons/box-icon.jpg'),
                            SizedBox(height: sizeCustom.getWidthPx(0)),

                            SizedBox(height: sizeCustom.getWidthPx(8)),
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

                            TextFormField(
                              controller: _passController,
                              decoration: InputDecoration(
                                hintText: "Senha",
//                                     hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                                     border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(32.0)),
                                icon: Icon(Icons.lock_outline),
                              ),
                              obscureText: true,
                              validator: (text) {
                                if (text.isEmpty || text.length < 6)
                                  return "Senha inválida";
                              },
                            ),
                            SizedBox(height: sizeCustom.getWidthPx(20)),
//                                 SizedBox(
//                                   child: new Column(
//                                     children: <Widget>[
//                                       Align(
//                                         alignment: Alignment.center,
//                                         child: FlatButton(
//                                           onPressed: () {
//                                             if (_emailController.text.isEmpty) {
//                                               _scaffoldKey.currentState
//                                                   .showSnackBar(SnackBar(
//                                                 content: Text(
//                                                     "Insira seu email para redefinir e clique novamente"),
//                                                 backgroundColor: Colors.redAccent,
//
//                                                 duration: Duration(seconds: 4),
//                                               ));
//                                             } else {
//                                               model.recoverPass(_emailController.text);
//                                               _scaffoldKey.currentState
//                                                   .showSnackBar(SnackBar(
//                                                 content: Text("Email eviado verifique"),
//                                                 backgroundColor: Colors.blue,
//                                                 duration: Duration(seconds: 4),
//                                               ));
//                                             }
//                                           },
//                                           child: Text(
//                                             "Esqueci minha senha",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 color: Colors.grey[800],
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16)
//                                           ),
//                                           padding:
//                                           EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

                            SizedBox(
                              child: new Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPassScreen()));
                                      },
                                      child: Text("Esqueci minha senha",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 20.0,
                            ),

                            SizedBox(
                              child: new Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child:  Text(
                                        "Não possui conta faça seu cadastro!",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                140, 209, 27, 0.7),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpScreen()));
                                      },
                                      child: Text(
                                        "REGISTRE-SE ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 20.0,
                            ),



                            SizedBox(
                              height: 44.0,
                              child: RaisedButton(
                                //color: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),

                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                textColor: Colors.white,
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    model.signIn(
                                        email: _emailController.text,
                                        pass: _passController.text,
                                        onSuccess: _onSuccess(model.userData),
                                        onFail: _onFail);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
                    ]));
              },
            )),
      ],
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Usuário não liberado"),
          content: new Text(
              "Seu login ainda não foi liberado no nosso sistema, aguarde. Obrigado!"),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _onSuccess(userData) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => new HomeScreen()));
//     && userData["active"]
    if (userData["type"] == "student" && userData["active"] == "true") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else if (userData["type"] == "teacher" && userData["active"] == "true") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeTeacherPage()));
    } else if (userData["active"] == "false") {
      _showDialog();
    }

    print(userData);

//    Navigator.of(context)
//        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Por favor verifique seu login e tente novamente!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 4),
    ));
  }
}

GradientText _loginGradientText() {
  return GradientText('BOX HOUSE',
      gradient: LinearGradient(colors: [
        Color.fromRGBO(2, 2, 2, 1),
        Color.fromRGBO(2, 2, 2, 1),
//      Color.fromRGBO(140, 209, 27, 1),
//      Colors.blueAccent,
//      Colors.lightBlueAccent
      ]),
      style: TextStyle(
          fontFamily: 'Exo2', fontSize: 36, fontWeight: FontWeight.bold));
}
