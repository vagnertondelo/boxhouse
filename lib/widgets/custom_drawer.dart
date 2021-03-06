import 'package:flutter/material.dart';
import 'package:box_house/services/user_service.dart';
import 'package:box_house/screens/login_screen.dart';
import 'package:box_house/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);


  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Color.fromARGB(255, 253, 181, 168)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );


    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Guide\nPilot", style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                    child: ScopedModelDescendant<UserService>(
                      builder: (context, child, model){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Olá, ${!model.isLoggedIn()? "": model.userData["name"]}",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            GestureDetector(
                              child: Text("Sair",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              onTap: (){

                                  model.signOut();
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));


                              },

                            )
                          ],
                        );
                      } ,
                    )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Home",pageController,0),
              DrawerTile(Icons.list, "P2",pageController,1),
              DrawerTile(Icons.location_city, "P3",pageController,2),
              DrawerTile(Icons.playlist_add_check, "P4",pageController,3),
            ],
          )
        ],
      ),

    );
  }
}
