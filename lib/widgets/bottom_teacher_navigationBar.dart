import 'package:box_house/util/colors.dart';
import 'package:box_house/util/responsive_screen.dart';
import 'package:flutter/material.dart';

class BottomTeacherNavBar extends StatefulWidget {
  final ValueChanged<int> changeCurrentTab;

  BottomTeacherNavBar({Key key, this.changeCurrentTab}) : super(key: key);

  @override
  _BottomTeacherNavBarState createState() => _BottomTeacherNavBarState();
}

class _BottomTeacherNavBarState extends State<BottomTeacherNavBar>
    with SingleTickerProviderStateMixin {
  int tab = 0;

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      iconSize: size.getWidthPx(24),
      currentIndex: tab,
      unselectedItemColor: Colors.black45,
      selectedItemColor: colorCurve,
      elevation: 150.0,
      selectedFontSize: 15.0,
      showUnselectedLabels: true,
      onTap: (int index) {
        setState(() {
          if (index != 4) {
            tab = index;
            widget.changeCurrentTab(index);
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.grey.shade50,
          icon: Icon(Icons.home),
          title: Text('Horários', style: TextStyle(fontFamily: 'Exo2')),
        ),

//        BottomNavigationBarItem(
//          backgroundColor: Colors.grey.shade50,
//          icon: Icon(Icons.calendar_today),
//          title: Text('Agendar', style: TextStyle(fontFamily: 'Exo2')),
//        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.grey.shade50,
          icon: Icon(Icons.settings),
          title: Text('Confiruações', style: TextStyle(fontFamily: 'Exo2')),
        ),
//        BottomNavigationBarItem(
//          backgroundColor: Colors.grey.shade50,
//          icon: Icon(Icons.settings),
//          title: Text('Setting', style: TextStyle(fontFamily: 'Exo2')),
//        ),
      ],
    );
  }
}
