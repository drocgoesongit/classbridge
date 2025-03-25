import 'package:classbridge/constants/color_const.dart';
import 'package:classbridge/views/home_screen.dart';
import 'package:classbridge/views/profile_screen.dart';
import 'package:classbridge/views/reminder_screen.dart';
import 'package:classbridge/views/students_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const [
    HomeScreen(),
    StudentsScreen(),
    ReminderScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Sizer(
        builder: (p0, p1, p2) {
          return Scaffold(
            
            key: homeScaffoldKey,
            backgroundColor: primaryBlueCustomColor,
            body: _widgetOptions[_selectedIndex],
            bottomNavigationBar: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Cart Summary Row - Only show when cart has items
                           BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined,
                            color: _selectedIndex == 0
                                ? primaryBlueCustomColor
                                : Colors.black),
                        activeIcon: Icon(Icons.home_rounded,
                            color: primaryBlueCustomColor),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.group_outlined,
                            color: _selectedIndex == 1
                                ? primaryBlueCustomColor
                                : Colors.black),
                        activeIcon: Icon(Icons.group_rounded,
                            color: primaryBlueCustomColor),
                        label: 'Students',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.campaign_outlined,
                            color: _selectedIndex == 2
                                ? primaryBlueCustomColor
                                : Colors.black),
                        activeIcon: Icon(Icons.campaign_rounded,
                            color: primaryBlueCustomColor),
                        label: 'Notices',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline,
                            color: _selectedIndex == 3
                                ? primaryBlueCustomColor
                                : Colors.black),
                        activeIcon: Icon(Icons.person_rounded,
                            color: primaryBlueCustomColor),
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: primaryBlueCustomColor,
                    unselectedItemColor: Colors.grey,
                    onTap: _onItemTapped,
                    showUnselectedLabels: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
