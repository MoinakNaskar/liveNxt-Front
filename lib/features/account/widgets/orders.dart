import 'package:flutter/material.dart';
import 'package:livenxt_front/constants/global_variable.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Clicked',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: Text(
                'See All',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: GlobalVariable.selectedNavBarColor),
              ),
            )
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(itemBuilder: (context, index) {}),
        )
      ],
    );
  }
}
