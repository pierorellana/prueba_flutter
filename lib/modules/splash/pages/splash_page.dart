import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../env/theme/app_theme.dart';
import '../../../shared/helpers/global_helpers.dart';
import '../../../shared/routes/app_routes.dart';
import '../../404/pages/page_404.dart';
import '../../security/login/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    debugPrint('splash');
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
            context,
            GlobalHelper.navigationFadeIn(context, const LoginPage()),
            (route) => false));
    super.initState();
  }

  goTo(String routeName) {
    final route = AppRoutes.routes[routeName];
    final page = (route != null) ? route.call(context) : const PageNotFound();
    Navigator.push(
      context,
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          var fadeTween = Tween(begin: 0.0, end: 1.0);
          var fadeAnimation = animation.drive(fadeTween);
          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        alignment: FractionalOffset.center,
        decoration: const BoxDecoration(color: AppTheme.transparent),
        child:  Stack(
          alignment: Alignment.center,
          children: [
            BounceInUp(
              child: Hero(
                  tag: 'logo',
                  child: Text("Bienvenido!",
                      style: TextStyle(color: AppTheme.secondaryColor, fontWeight: FontWeight.bold, fontSize: 35))),
            ),
          ],
        ),
      ),
    );
  }
}
