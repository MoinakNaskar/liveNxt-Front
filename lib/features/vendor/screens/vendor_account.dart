import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../auth/services/auth_service.dart';

class VendorAccount extends StatelessWidget {
  VendorAccount({super.key});

  AuthService _authService = AuthService();
  logOut(BuildContext context) {
    _authService.LogOutUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            logOut(context);
          },
          child: Text('logout'),
        ),
      ),
    );
  }
}
