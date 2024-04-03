import 'package:enigma/screens/home_screen/home_screen.dart';
import 'package:enigma/screens/landing_screen/landing_screen.dart';

import 'common_libraries.dart';
class Routes {
  static const String landing = '/';
  static const String home = '/home';


  static final unknownRoute = GetPage(
    name: '/unknown',
    page: () => const Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    ),
  );

  static final List<GetPage> routes = [
    GetPage(name: landing, page: () => const LandingScreen()),
    GetPage(name: home, page: () => const HomeScreen()),

    unknownRoute,
  ];
}