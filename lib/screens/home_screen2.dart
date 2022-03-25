import 'package:flutter/material.dart';
import 'package:box_house/tabs/home_tab.dart';
import 'package:box_house/widgets/custom_drawer.dart';

class HomeScreen2 extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      //bloqueia roalagem de paginas lateral
      //physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab() ,
          drawer: CustomDrawer(_pageController),
        ),
          Scaffold(
              appBar: AppBar(
              title: Text("P2"),
              centerTitle: true,
              ),
              drawer: CustomDrawer(_pageController),
              body: Container(),

          ),
      ],

    );
  }
}
