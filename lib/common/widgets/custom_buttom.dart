// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:livenxt_front/constants/global_variable.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.purple,
          foregroundColor: Color.fromARGB(255, 70, 49, 74)),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}
