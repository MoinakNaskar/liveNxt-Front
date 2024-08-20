import 'package:flutter/material.dart';
import 'package:livenxt_front/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 205, 126, 219), Colors.black])),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Finding near -${user.address}',
              style: const TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 2),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
