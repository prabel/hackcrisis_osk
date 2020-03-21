import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:osk_flutter/domain/location/get_current_location_use_case.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/view/main/applications/applications_dashboard.dart';
import 'package:osk_flutter/view/main/information/information_dashboard.dart';
import 'package:osk_flutter/view/main/profile/profile_dashboard.dart';

class MainPageDestination {
  final int index;
  final String title;
  final IconData icon;
  final Widget body;

  MainPageDestination(this.index, this.title, this.body, this.icon);
}

List<MainPageDestination> mainPageDestinations = [
  MainPageDestination(0, "Aplikacje", ApplicationsDashboard(), Icons.lightbulb_outline),
  MainPageDestination(1, "Aktualności", InformationDashboard(), Icons.info_outline),
  MainPageDestination(2, "Zdrowie", ProfileDashboard(), Icons.person_pin),
];

class MainNavigationPage extends StatefulWidget {
  static MaterialPageRoute pageRoute() => MaterialPageRoute(builder: (BuildContext context) => MainNavigationPage());

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  final Location location = Location();

  int _currentIndex = 2;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  @override
  void initState() {
    super.initState();
    _handleLocationInitilization();

    GetCurrentLocationUseCase().execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainPageDestinations[_currentIndex].body,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryBlue,
      unselectedItemColor: AppColors.lightGrey,
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

  Future<void> _handleLocationInitilization() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }
  }
}
