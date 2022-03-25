import 'package:box_house/services/agenda_service.dart';
import 'package:box_house/tiles/card_tile.dart';
import 'package:box_house/util/colors.dart';
import 'package:box_house/widgets/bottom_curve_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DashboardTeacherScreen extends StatefulWidget {
  @override
  _DashboardTeacherScreenState createState() => _DashboardTeacherScreenState();
}

class _DashboardTeacherScreenState extends State<DashboardTeacherScreen> {
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
        title: Text("Meus Horários",
            style: TextStyle(fontFamily: "Exo2", color: textPrimaryLightColor)),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: ScopedModelDescendant<AgendaModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.agendamentos == null || model.agendamentos.length == 0 ) {
            return Container(
//              key: _formKey,
                child: Stack(fit: StackFit.expand, children: <Widget>[
//                Positioned.fill(
//                  child: Image.asset(
//                    "assets/images/fundo-opaco.jpg",
//                    fit: BoxFit.cover,
//                    alignment: Alignment.center,
//                  ),
//                ),
                ClipPath(
                clipper: BottomShapeClipper(),
                child: Container(
                  color: colorCurve,
                )),
                SingleChildScrollView(
                    child: Container(
                    margin:
                    EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 25.0),
                    child: Column(
                    children: <Widget>[
                      Center(
                        child: Text("Você não possui agendamentos!",
                        style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),


                    ],
                )))
                    ])
              );
                }
          else{
          return Container(
//              key: _formKey,
          child: Stack(fit: StackFit.expand, children: <Widget>[
//                Positioned.fill(
//                  child: Image.asset(
//                    "assets/images/fundo-opaco.jpg",
//                    fit: BoxFit.cover,
//                    alignment: Alignment.center,
//                  ),
//                ),
            ClipPath(
              clipper: BottomShapeClipper(),
              child: Container(
              color: colorCurve,
            )),
            SingleChildScrollView(
              child: Container(
              margin:
                EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: model.agendamentos.map((agendamento){
                    if(agendamento.status == "open"){
                      return Card(
                        elevation: 10.0,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Data: ${agendamento.date}",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                  SizedBox(
                                    width: 56.0,
                                  ),
                                  Text(
                                    "Hora: ${agendamento.hours}",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Endereço: ${agendamento.address}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: (){
                                      model.cancel(agendamento);
                                    },
                                    child: Text("Cancelar"),
                                    textColor: Colors.grey[500],
                                  )


                                ],
                              )

                            ],
                          ),
                        ),
                      );
                    }else{}
                  }).toList(),

//                  children: model.agendamentos.map((agendamento){
//                  return CardTile(agendamento);
//                }).toList(),

                )
              )
          )
          ])
          );
          }

        },
      ),
    );
  }
}


