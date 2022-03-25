
import 'package:cloud_firestore/cloud_firestore.dart';

class HourModel{

  String id;
  String available;
  String hour;
  String date;



  HourModel();

  HourModel.fromDoDocument(DocumentSnapshot document){
    id = document.documentID;
    available = document.data["available"];
    hour = document.data["hour"];
    date = document.data["date"];


  }


}


