import 'package:flutter/material.dart';
import 'package:livenxt_front/features/account/widgets/account_button.dart';
import 'package:livenxt_front/features/auth/services/auth_service.dart';

// ignore: must_be_immutable
class TopButtons extends StatelessWidget {
  TopButtons({super.key});

  AuthService _authService = AuthService();

  logout(BuildContext context) async {
    await _authService.LogOutUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {})
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
                text: 'log Out',
                onTap: () {
                  logout(context);
                }),
            AccountButton(text: 'your WishList', onTap: () {})
          ],
        )
      ],
    );
  }
}
