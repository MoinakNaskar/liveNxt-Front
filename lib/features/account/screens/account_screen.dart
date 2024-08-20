import 'package:flutter/material.dart';
import 'package:livenxt_front/constants/global_variable.dart';
import 'package:livenxt_front/features/account/widgets/below_app_bar.dart';
import 'package:livenxt_front/features/account/widgets/orders.dart';
import 'package:livenxt_front/features/account/widgets/top_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Color.fromARGB(157, 255, 255, 255),
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Color.fromARGB(157, 255, 255, 255),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const BelowAppBar(),
          const SizedBox(
            height: 10,
          ),
          TopButtons(),
          const SizedBox(
            height: 10,
          ),
          const Orders()
        ],
      ),
    );
  }
}
