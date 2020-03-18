import 'package:flutter/material.dart';
import 'package:osk_flutter/view/main/profile/profile_dashboard.dart';

class MainPageDestination {
  final int index;
  final String title;
  final IconData icon;
  final Widget body;

  MainPageDestination(this.index, this.title, this.body, this.icon);
}

List<MainPageDestination> mainPageDestinations = [
  MainPageDestination(0, "Porady", Container(), Icons.star),
  MainPageDestination(1, "Informacje", Container(color: Colors.blue), Icons.info_outline),
  MainPageDestination(2, "Twoja sytuacja", ProfileDashboard(), Icons.person_pin),
];

class MainNavigationPage extends StatefulWidget {
  static MaterialPageRoute pageRoute = MaterialPageRoute(builder: (BuildContext context) => MainNavigationPage());

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: mainPageDestinations[_currentIndex].body),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Theme.of(context).accentColor,
      unselectedItemColor: Theme.of(context).primaryColorLight,
      currentIndex: _currentIndex,
      items: mainPageDestinations
          .map((item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                title: Text(item.title),
              ))
          .toList(),
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
