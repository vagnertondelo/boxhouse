import 'package:box_house/screens/agenda_screen.dart';
import 'package:box_house/screens/settings_screen.dart';
import 'package:box_house/widgets/bottom_navigationBar.dart';
import 'package:flutter/material.dart';


import '../main.dart';
import 'dashboard_screen.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentTab = 0;
  PageController pageController;

  _changeCurrentTab(int tab) {
    //Changing tabs from BottomNavigationBar
    setState(() {
      currentTab = tab;
      pageController.jumpToPage(0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: bodyView(currentTab),
          bottomNavigationBar: BottomNavBar(changeCurrentTab: _changeCurrentTab)),
    );
  }

  bodyView(currentTab) {
    List<Widget> tabView = [];
    //Current Tabs in Home Screen...
    switch (currentTab) {
      case 0:
        //Dashboard Page
        tabView = [DashboardScreen()];//SearchPage()
        break;
      case 1:
        //Schedule Page
        tabView = [AgendaScreen()];
        break;
      case 2:
        //Setting Page
        tabView = [SettingScreen()];
        break;
//      case 3:
//        //Setting Page
//        tabView = [];
//        break;
    }
    return PageView(controller: pageController, children: tabView);
  }
}
