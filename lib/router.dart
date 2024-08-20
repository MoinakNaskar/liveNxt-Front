import 'package:flutter/material.dart';
import 'package:livenxt_front/common/widgets/bottom_bar.dart';
import 'package:livenxt_front/features/auth/screens/auth_screen.dart';
import 'package:livenxt_front/features/vendor/listing_screens/listing_1.dart';
import 'features/home/screens/home_screens.dart';

Route<dynamic> genarateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case (AuthScreen.routeName):
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case (HomeScreen.routeName):
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case (BottomBar.routeName):
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case (Listing.routeName):
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Listing(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
            body: Center(
          child: Text('Screen does not exist'),
        )),
      );
  }
}
