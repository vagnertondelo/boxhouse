import 'package:box_house/services/user_service.dart';
import 'package:box_house/screens/login_screen.dart';
import 'package:box_house/util/colors.dart';
import 'package:box_house/util/responsive_screen.dart';
import 'package:box_house/widgets/bottom_curve_painter.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
//enum SingingCharacter { teacher, student }
class _SignUpScreenState extends State<SignUpScreen> {


 String _type = "student";



  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  Screen sizeCustom;
 var maskTextInputFormatter = MaskTextInputFormatter(mask: "(##) #-####-####", filter: { "#": RegExp(r'[0-9]') });
  @override
  Widget build(BuildContext context) {
    sizeCustom = Screen(MediaQuery.of(context).size);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
//        backgroundColor: Color.fromRGBO(140, 209, 27, 1),
        automaticallyImplyLeading: true,
        title: Text('Registrar'),
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
            return Center(
              child: CircularProgressIndicator(),
            );
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
//                ClipPath(
//                    clipper: BottomShapeClipper(),
//                    child: Container(
//                      color: colorCurve,
//                    )),
                SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: sizeCustom.getWidthPx(25),
                            vertical: sizeCustom.getWidthPx(20)),
                        child: Column(
                          children: <Widget>[
//                            SizedBox(
//                              width: 138,
//                              height: 138,
//                              child: Image.asset("assets/images/logo.png"),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.all(15.0),
//                            ),
                            SizedBox(
                              height: 60.0,
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: "Nome",
                                icon: Icon(Icons.accessibility),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                                border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              validator: (text) {
                                if (text.isEmpty) return "Nome inválido";
                              },
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "E-mail",
                                icon: Icon(Icons.email),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                                border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (text) {
                                if (text.isEmpty || !text.contains("@"))
                                  return "Email inválido";
                              },
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              controller: _passController,
                              decoration: InputDecoration(
                                hintText: "Senha",
                                icon: Icon(Icons.lock_outline),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                                border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              obscureText: true,
                              validator: (text) {
                                if (text.isEmpty || text.length < 6)
                                  return "Senha inválida";
                              },
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              controller: _phoneController,
                              inputFormatters: [maskTextInputFormatter],
                              decoration: InputDecoration(
                                hintText: "Telefone ",
                                icon: Icon(Icons.phone),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                                border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (text) {
                                if (text.isEmpty)
                                  return "Telefone inválido";
                              },
                            ),
                            SizedBox(
                              height: 16.0,
                            ),

                                ListTile(
                                  title: const Text('Professor'),
                                  leading: Radio(
                                    activeColor: Colors.black,
                                    value: "teacher",
                                    groupValue: _type,
                                    onChanged: (value) {
                                      setState(() {
                                        _type = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Aluno'),
                                  leading: Radio(
                                    activeColor: Colors.black,
                                    value: "student",
                                    groupValue: _type,
                                    onChanged: (value) {
                                      setState(() {
                                        _type = value;
                                      });
                                    },
                                  ),
                                ),

                            SizedBox(
                              height: 16.0,
                            ),
                            SizedBox(
                              height: 44.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  "Criar Conta",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                textColor: Colors.white,
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Map<String, dynamic> userData = {
                                      "name": _nameController.text,
                                      "email": _emailController.text,
                                      "phone": _phoneController.text,
                                      "type": _type,
                                      "active": "true",
                                    };

                                    model.signUp(
                                        userData: userData,
                                        pass: _passController.text,
                                        onSuccess: _onSuccess,
                                        onFail: _onFail);
                                  }
                                },
                              ),
                            ),
//                SizedBox(height:16.0,),
//                SizedBox(
//
//                  child: new Column(
//                    children: <Widget>[
//
//                      Align(
//                        alignment: Alignment.centerLeft,
//                        child: FlatButton(
//                          onPressed: (){
//                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
//                          },
//                          child: Text("< Back",
//                            textAlign: TextAlign.center,),
//                          padding: EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
//                        ),
//                      ),
//                    ],
//
//                  ),
//
//                ),
                          ],
                        )))
              ])

//            ListView(
//              padding: EdgeInsets.all(16.0),
//              children: <Widget>[
//
//
//
//
//                SizedBox(
//
//                  width: 138,
//                  height: 138,
//                  child: Image.asset("assets/images/logo.png"),
//                ),
//                Padding(padding: const EdgeInsets.all(15.0),),
//                TextFormField(
//                  controller: _nameController,
//                  decoration: InputDecoration(
//                      hintText: "Name",
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//                  ),
//
//                  validator: (text){
//                    if(text.isEmpty) return "Invalid Name ";
//                  },
//                ),
//                SizedBox(height:16.0,),
//                TextFormField(
//                  controller: _emailController,
//                  decoration: InputDecoration(
//                    hintText: "E-mail",
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//                  ),
//                  keyboardType: TextInputType.emailAddress,
//                  validator: (text){
//                    if(text.isEmpty || !text.contains("@")) return "Email inválido";
//                  },
//                ),
//                SizedBox(height:16.0,),
//                TextFormField(
//                  controller: _passController,
//                  decoration: InputDecoration(
//                      hintText: "Password",
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//                  ),
//                  obscureText: true,
//                  validator: (text){
//                    if(text.isEmpty || text.length < 6) return "Invalid or empty password";
//                  },
//                ),
//                SizedBox(height:16.0,),
//                TextFormField(
//                  controller: _phoneController,
//                  decoration: InputDecoration(
//                      hintText: "Country ",
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//                  ),
//
//                  validator: (text){
//                    if(text.isEmpty) return "Invalid or empty country";
//                  },
//                ),
//                SizedBox(height:16.0,),
//                SizedBox(
//                  height: 44.0,
//                  child:  RaisedButton(
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(24),
//
//                    ),
//                    child: Text("Create Account",
//                      style: TextStyle(
//                        fontSize:18.0,
//                      ),
//                    ),
//                    textColor: Colors.white,
//                    color: Theme.of(context).primaryColor,
//                    onPressed: (){
//                      if(_formKey.currentState.validate()){
//
//                        Map< String, dynamic> userData = {
//                          "name": _nameController.text,
//                          "email": _emailController.text,
//                          "pais": _phoneController.text,
//
//                        };
//
//                        model.signUp(
//                            userData: userData,
//                            pass: _passController.text,
//                            onSuccess: _onSuccess,
//                            onFail: _onFail);
//                      }
//                    },
//                  ),
//                ),
////                SizedBox(height:16.0,),
////                SizedBox(
////
////                  child: new Column(
////                    children: <Widget>[
////
////                      Align(
////                        alignment: Alignment.centerLeft,
////                        child: FlatButton(
////                          onPressed: (){
////                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
////                          },
////                          child: Text("< Back",
////                            textAlign: TextAlign.center,),
////                          padding: EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
////                        ),
////                      ),
////                    ],
////
////                  ),
////
////                ),
//              ],
//            ),
              );
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Criado com sucesso"),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 4),
    ));
    Future.delayed(Duration(seconds: 4)).then((_) {
//      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 4),
    ));
  }
}

//----------------------------------





//
//
//Container _checkButtonWidget() {
//  return Container(
//      child: new Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          new Radio(
//            value: 1,
//            groupValue: _radioValue3,
//            onChanged: _handleRadioValueChange3,
//          ),
//          new Text(
//            'Professor',
//            style: new TextStyle(fontSize: 16.0),
//          ),
//          new Radio(
//            value: 2,
//            groupValue: _radioValue3,
//            onChanged: _handleRadioValueChange3,
//          ),
//          new Text(
//            'Aluno',
//            style: new TextStyle(
//              fontSize: 16.0,
//            ),
//          ),
//        ],
//      )
//  );
//}
