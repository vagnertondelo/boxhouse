import 'package:box_house/models/agenda.dart';
import 'package:flutter/material.dart';

class CardTile extends StatelessWidget{
  final AgendaData agendaData;

  CardTile(this.agendaData);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0
      ),
      child:  _buidContent(),

    );
  }


  Widget _buidContent(){
    Container(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text(
              "Data: ${this.agendaData.date}",
              style: TextStyle(
                color: Colors.black,
                  fontWeight: FontWeight.w300
              ),
            ),
            Text(
              "Hora: ${this.agendaData.hours}",
              style: TextStyle(
                  fontWeight: FontWeight.w300
              ),
            ),

          ],
        ),
      ),
    );
  }

}
