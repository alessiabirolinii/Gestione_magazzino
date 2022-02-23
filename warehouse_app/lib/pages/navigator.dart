import 'package:flutter/material.dart';
import 'package:warehouse_app/pages/add.dart';
import 'package:warehouse_app/pages/home.dart';
import 'package:warehouse_app/pages/info.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  final List<Widget> pages = [
    const HomePage(),
    const AddPage(),
    const InfoPage(),
  ];

  final List<BottomNavigationBarItem> icons = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add_box_outlined),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.info),
      label: "",
    ),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: index,
        items: icons,
        onTap: (value) => setState(() => index = value),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: index,
          children: pages,
        ),
      ),
    );
  }
}
