import 'package:box_house/models/agenda.dart';
import 'package:box_house/services/agenda_service.dart';
import 'package:box_house/services/user_service.dart';
import 'package:box_house/screens/dashboard_screen.dart';
import 'package:box_house/util/colors.dart';
import 'package:box_house/util/responsive_screen.dart';
import 'package:box_house/widgets/bottom_curve_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:scoped_model/scoped_model.dart';

import 'home_screen.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
//  static AgendaModel of(BuildContext context) => ScopedModel.of<AgendaModel>(context);
  final _formKey = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Screen sizeCustom;
  String _value = '';
  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _foneController = TextEditingController();
  String _time='';
  DateTime selectedDate;
  String initHour ='';
  Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
//    this._dataController.text = DateTime.now().day.toString()+ "/" +DateTime.now().month.toString()+"/"+DateTime.now().year.toString();

    // TODO: implement initState
    super.initState();

//    _searchDateHours(this._dataController.text);
  }


  Future _searchDateHours(date, model) async{


   await model.listHoursToDate(date);

  }

  Future _selectDate(model) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2100),
//      firstDate: new DateTime(new DateTime.now().year),
//      lastDate: new DateTime(new DateTime.now().year + 1),

    );
    if (picked != null)
      setState(() => _value = picked.day.toString() +
          "/" +
          picked.month.toString() +
          "/" +
          picked.year.toString());
    _dataController.text = _value;
    _searchDateHours(_dataController.text, model);
  }




  void _dropDownItemSelected(novoItem){
    setState(() {
      if(novoItem == ""){
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Horario reservado, por favor selecione outro"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 5),
        ));
      }else{
        this._horaController.text = novoItem;
      }


    });
  }

  Future _selectTime() async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );

    if (time != null)
      setState(() => _time = time.hour.toString()+":"+time.minute.toString());
      _horaController.text = _time;
  }

  var maskTextInputFormatter = MaskTextInputFormatter(mask: "(##) #-####-####", filter: { "#": RegExp(r'[0-9]') });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Agendar",
            style:
                TextStyle(fontFamily: "Exo2", color: textPrimaryLightColor)),
        backgroundColor: Colors.black,
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          if (_formKey.currentState.validate()) {
//            Map<String, dynamic> agendaData = {
//              "date": _dataController.text,
//              "hours": _horaController.text,
//              "phone": _foneController.text,
//              "address": _enderecoController.text,
//
//            };
//              agendaModel.save(
//                  agendaData: agendaData,
//                  onSuccess: _onSuccess,
//                  onFail: _onFail);
//          }
//        },
//        child: Icon(Icons.save),
//        backgroundColor: Colors.green,
//      ),
      body: ScopedModelDescendant<AgendaModel>(
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

                ClipPath(
                    clipper: BottomShapeClipper(),
                    child: Container(
                      color: colorCurve,
                    )),

                SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 25.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 76.0,
                            ),
//                            DateField(
//                              selectedDate: selectedDate,
//                              onDateSelected: (DateTime date) {
//                                setState(() {
//                                  selectedDate = date;
//                                });
//                              },
//                              lastDate: DateTime(2030),
//                            ),
//
//
//
//
//                            DateTimeFormField(
//                              initialValue: new DateTime.now(),
//                              label: "Date Time",
//
//                              validator: (DateTime dateTime) {
//                                if (dateTime == null) {
//                                  return "Date Time Required";
//                                }
//                                return null;
//                              },
//                              onSaved: (DateTime dateTime) => _dateTime = dateTime,
//                            ),

                            TextFormField(
                              controller: _dataController,
                              onTap: (){
                                FocusScope.of(context).requestFocus(new FocusNode());
                                _selectDate(model);

                              } ,
                              decoration: InputDecoration(
                                hintText: "Data",
                                icon: Icon(Icons.calendar_today),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                                border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
//                              onSaved: (DateTime dateTime) => _dateTime = dateTime,
                              validator: (_value) {
                                if (_value.isEmpty) return "Data inválido";
                              },
                            ),
                            SizedBox(
                              height: 26.0,
                            ),

//                            Row(
//                              children: <Widget>[
//
//                              ],
//
//                            ),

//                            TextFormField(
//                              onTap: () {
////                                FocusScope.of(context).requestFocus(new FocusNode());
////                                if (model.hoursList == null || model.hoursList.length == 0 ) {
////                                  _selectTime();
////                                }else{
////                                  _dropDownButton(model.hoursList);
////                                }
//
//
//                              },
//                              controller: _horaController,
//                              decoration: InputDecoration(
//                                hintText: "Hora",
//                                icon: Icon(Icons.access_time),
////                                contentPadding:
////                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
////                                border: OutlineInputBorder(
////                                    borderRadius: BorderRadius.circular(32.0)),
//                              ),
//                              keyboardType: TextInputType.datetime,
//                              validator: (text) {
//                                if (text.isEmpty) return "Hora inválido";
//                              },
//                            ),

                            DropdownButton(
                              hint: Text("Selecione um horario"),
                                items : model.dateHoursList.map((hour) {
                                    if(hour.available == "true"){
                                      return DropdownMenuItem(
                                        value: hour.hour,
                                        child: Text(hour.hour),
                                      );
                                    }else{
                                      return DropdownMenuItem(
                                        child: Text(hour.hour + " reservado",
                                          style: TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        value: "",
                                      );
                                    }

                                }).toList(),
                                onChanged: ( novoItemSelecionado) {
                                  _dropDownItemSelected(novoItemSelecionado);
                                  setState(() {
                                    this._horaController.text =  novoItemSelecionado;
                                  });
                                },
                              value: _horaController.text.isNotEmpty ? this._horaController.text : null,
                            ),


                            SizedBox(
                              height: 26.0,
                            ),
                            TextFormField(
                              controller: _foneController,
                              inputFormatters: [maskTextInputFormatter],
                              decoration: InputDecoration(
                                hintText: "Telefone",
                                icon: Icon(Icons.phone),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                                border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (text) {
                                if (text.isEmpty) return "Telefone inválido";
                              },
                            ),
                            SizedBox(
                              height: 26.0,
                            ),
                            TextFormField(
                              controller: _enderecoController,
                              decoration: InputDecoration(
                                hintText: "Digite seu endereço ou  clique \nem 'Pegar minha localização'.",
                                icon: Icon(Icons.gps_fixed),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                                border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              validator: (text) {
                                if (text.isEmpty) return "Endereço inválido";
                              },
                            ),


                            FlatButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              child: Text("Pegar minha localização"),
                              onPressed: () {
                                _getCurrentLocation();
                              },
                            ),



                            SizedBox(
                              height: 46.0,
                            ),
                            SizedBox(
                              height: 44.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  "Agendar",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                textColor: Colors.white,
                                color: Colors.black,
                                onPressed: () {
                                  if (_formKey.currentState.validate()){
                                    Map<String, dynamic> agendaData = {
                                      "date": _dataController.text,
                                      "hours": _horaController.text,
                                      "phone": _foneController.text,
                                      "address": _enderecoController.text,
                                      "status": "open",

                                    };
                                    model.save(
                                        agendaData: agendaData,
                                        onSuccess: _onSuccess,
                                        onFail: _onFail);
                                  }
                                },
                              ),
                            ),




                          ],
                        )))
              ]));
        },
      ),

    );
  }
  _getCurrentLocation() {
    setState(() {
      this._enderecoController.text = "Aguarde ...";
    });
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
//        _currentAddress =
       this._enderecoController.text = "${place.subLocality }, ${place.thoroughfare} - ${place.subThoroughfare} , ${place.subAdministrativeArea}";
      });
    } catch (e) {
      print(e);
    }
  }
  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Agendamento Realizado"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 6),
    ));
//    Future.delayed(Duration(seconds: 4)).then((_) {
//      Navigator.of(context).pop();
//      Navigator.of(context).pushReplacement(
//          MaterialPageRoute(builder: (context) => ));
//    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 4),
    ));
  }
}
