import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livenxt_front/features/auth/services/auth_service.dart';
import 'package:livenxt_front/features/vendor/screens/post_screen.dart';
import 'package:livenxt_front/features/vendor/screens/vendor_account.dart';

import '../../../constants/global_variable.dart';
import '../../account/screens/account_screen.dart';
import '../../home/screens/home_screens.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreen();
}

class _VendorScreen extends State<VendorScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const HomeScreen(),
    const PostScreen(),
    Center(
      child: Text('Analytics Page'),
    ),
    VendorAccount()
  ];

  void UpdatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
              Color.fromARGB(255, 82, 5, 96),
              Colors.black,
            ]))),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Row(
                    children: [
                      Text(
                        'LiveN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        'X',
                        style: TextStyle(
                            color: Color.fromARGB(205, 234, 202, 17),
                            fontWeight: FontWeight.w900,
                            fontSize: 30),
                      ),
                      Text(
                        't',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ],
                  ),
                ),
                const Text(
                  'Merchant',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                )
              ],
            ),
          ),
        ),
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
                  child: const Badge(child: Icon(Icons.analytics_outlined)),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                      color: _page == 3
                          ? GlobalVariable.selectedNavBarColor
                          : GlobalVariable.backgroundColor,
                      width: bottomBarBorderWidth,
                    )),
                  ),
                  child: const Badge(child: Icon(Icons.all_inbox_outlined)),
                ),
                label: ''),
          ],
        ));
  }
}
