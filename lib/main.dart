import 'package:box_house/services/agenda_service.dart';
import 'package:box_house/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:box_house/services/user_service.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserService>(
      model: UserService(),
      child: ScopedModelDescendant<UserService>(
          builder: (context,child,model){
            return ScopedModel<AgendaModel>(
              model: AgendaModel(model),
              child: MaterialApp(
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                   Locale('pt')
                ],
                title: 'Box House',
                theme: ThemeData(

                  primaryColor: Color.fromRGBO(2, 2, 2, 1),


//                  swatchcolor: Colors.black,
//                  primarySwatch: Colors.blue,
                ),
                debugShowCheckedModeBanner: false,
                home: Splash(),
              ),
            );
          }
      ),

    );
  }
}


