import 'package:flutter/material.dart';
import 'package:livenxt_front/constants/global_variable.dart';
import 'package:livenxt_front/features/account/screens/account_screen.dart';
import 'package:livenxt_front/features/home/screens/home_screens.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(
      child: Text('Cart Page'),
    )
  ];

  void UpdatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariable.selectedNavBarColor,
        unselectedItemColor: GlobalVariable.unselectedNavBarColor,
        backgroundColor: GlobalVariable.backgroundColor,
        iconSize: 28,
        onTap: UpdatePage,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                      color: _page == 0
                          ? GlobalVariable.selectedNavBarColor
                          : GlobalVariable.backgroundColor,
                      width: bottomBarBorderWidth,
                    )),
                  ),
                  child: Icon(Icons.home)),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: _page == 1
                        ? GlobalVariable.selectedNavBarColor
                        : GlobalVariable.backgroundColor,
                    width: bottomBarBorderWidth,
                  )),
                ),
                child: Icon(Icons.person_outline_outlined),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: _page == 2
                        ? GlobalVariable.selectedNavBarColor
                        : GlobalVariable.backgroundColor,
                    width: bottomBarBorderWidth,
                  )),
                ),
                child:
                    const Badge(child: Icon(Icons.real_estate_agent_outlined)),
              ),
              label: ''),
        ],
      ),
    );
  }
}
