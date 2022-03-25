import 'package:box_house/services/agenda_service.dart';
import 'package:box_house/tiles/card_tile.dart';
import 'package:box_house/util/colors.dart';
import 'package:box_house/widgets/bottom_curve_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    double c_width = MediaQuery.of(context).size.width*0.8;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meus Horários",
            style: TextStyle(fontFamily: "Exo2", color: textPrimaryLightColor)),
        backgroundColor: Color.fromRGBO(2, 2, 2, 1),
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
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/cross-2.jpg",
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
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
                          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white
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
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/cross-2.jpg",
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
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
                              Container(
                                width: c_width,
                                child:
                                    Text(
                                      "Endereço: ${agendamento.address}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300
                                      ),
                                    ),
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
                    }else{
                      return Container();
                    }
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


