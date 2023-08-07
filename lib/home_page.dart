import 'package:flutter/material.dart';
import 'package:treasure/tabs/disqualified_tab.dart';
import 'package:treasure/tabs/home_tab.dart';
import 'package:treasure/tabs/profile_tab.dart';
import 'package:treasure/team_list_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  final screens = [
    HomeTab(),
    DisqualifyTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(),
        child: NavigationBar(
          backgroundColor: Colors.grey[350],
          height: 65,
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(
                selectedIcon: Icon(Icons.people_alt_rounded),
                icon: Icon(Icons.people_alt_outlined), label: 'Disqualified'),
            NavigationDestination(
                selectedIcon: Icon(Icons.account_circle),
                icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
          ],
        ),
      ),
      body: screens[index],
    );
  }
}