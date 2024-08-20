import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livenxt_front/constants/global_variable.dart';
import 'package:livenxt_front/features/auth/screens/auth_screen.dart';

import 'package:livenxt_front/features/auth/services/auth_service.dart';
import 'package:livenxt_front/features/home/screens/home_screens.dart';
import 'package:livenxt_front/features/vendor/bloc/vendor_bloc.dart';
import 'package:livenxt_front/features/vendor/listing_screens/listing_1.dart';
import 'package:livenxt_front/features/vendor/screens/vendor_screens.dart';
import 'package:livenxt_front/providers/user_provider.dart';
import 'package:livenxt_front/router.dart';
import 'package:provider/provider.dart';

import 'common/widgets/bottom_bar.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => UserProvider()))
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorBloc(),
      child: MaterialApp(
          title: 'LiveNxt',
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariable.backgroundColor,
            colorScheme: const ColorScheme.light(primary: Colors.purple),
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
          ),
          onGenerateRoute: ((settings) => genarateRoute(settings)),
          home: Provider.of<UserProvider>(context).user.accessToken!.isNotEmpty
              ? Provider.of<UserProvider>(context).user.type == 'vendor'
                  ? const VendorScreen()
                  : const BottomBar()
              : const AuthScreen()),
    );
  }
}
