import 'package:flutter/material.dart';
import 'package:livenxt_front/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 82, 5, 96),
          Colors.black,
        ]),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  text: 'Hello!  ',
                  style: const TextStyle(fontSize: 22, color: Colors.grey),
                  children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ])),
        ],
      ),
    );
  }
}
