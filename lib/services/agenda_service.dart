import 'package:box_house/models/agenda.dart';
import 'package:box_house/models/hours.dart';
import 'package:box_house/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class AgendaModel extends Model {
  UserService user;
  AgendaData _agendaData;


  AgendaModel(this.user){

    _loadAgendamentos();
  }

//  Map<String, dynamic> agendaData = Map();

  List<AgendaData> agendamentos =[];

  List<HourModel> hoursList =[];

  List<HourModel> dateHoursList =[];

  bool isLoading = false;


  save( {@required Map<String, dynamic> agendaData,  @required VoidCallback onSuccess, @required VoidCallback onFail}) async{
    isLoading = true;
    notifyListeners();
   await _saveAgenda(agendaData);
    isLoading = false;
    notifyListeners();
    onSuccess();
  }

  cancel(AgendaData agendaData) async{
    isLoading = true;
    notifyListeners();
    await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("agenda").document(agendaData.id).
    updateData({"status":"canceled"});
    isLoading = false;
    _loadAgendamentos();
  }

  void _loadAgendamentos() async{
    QuerySnapshot querySnapshot = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("agenda")
    .getDocuments();
    agendamentos = querySnapshot.documents.map((doc) => AgendaData.fromDoDocument(doc)).toList();
    agendamentos.sort((a,b) => a.date.compareTo(b.date));
    print(agendamentos);
    notifyListeners();
  }

  void _loadHours() async{
    QuerySnapshot querySnapshot = await Firestore.instance.collection("hours").getDocuments();
    hoursList = [];
    hoursList = querySnapshot.documents.map((doc) => HourModel.fromDoDocument(doc)).toList();
    hoursList.sort((a,b) => a.hour.compareTo(b.hour));
    print(hoursList);
//    notifyListeners();
  }



  void _listDateHoursForDate(date){
    dateHoursList = [];
    for(final i in hoursList){
      print('$i');
      if (i.date == date){
        dateHoursList.add(i);
      }
    }

  }


  void listHoursToDate(date) async{
    isLoading = true;
    notifyListeners();
   await _loadHours();

   _listDateHoursForDate(date);

    isLoading = false;
    notifyListeners();
  }

 addList(agenda){
    AgendaData agendaData = AgendaData();
       agendaData.date  = agenda["date"];
       agendaData.phone  = agenda["phone"];
       agendaData.hours  = agenda["hours"];
       agendaData.address  = agenda["address"];
       agendaData.status  = agenda["status"];
      agendamentos.add(agendaData);
      agendamentos.sort((a,b) => b.date.compareTo(a.date));
      notifyListeners();
 }

  Future<Null> _saveAgenda(Map<String, dynamic> agendaData ) async {
//    this.agendaData = agendaData;
  addList(agendaData);
    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("agenda")
        .add(agendaData).catchError((e){
          print("ERRRRROOOOO"+e);
          agendaData = e;
    });
  }



}
