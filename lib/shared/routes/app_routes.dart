import 'package:flutter/material.dart';
import 'package:prueba_flutter/modules/home/pages/home_page.dart';

import '../../modules/404/pages/page_404.dart';
import '../../modules/home/pages/user_page.dart';
import '../../modules/security/login/pages/login_page.dart';
import '../../modules/splash/pages/splash_page.dart';

class AppRoutes{
  static const initialRoute = '/splash';

  static Map<String, Widget Function(BuildContext)> routes ={
    '/splash' : (_) => const SplashPage(),
    '/login' : (_) =>  const LoginPage(),
    '/admin' : (_) => const HomePage(),
    '/user' : (_) => const UserPage()
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const PageNotFound(),
    );
  }
}
