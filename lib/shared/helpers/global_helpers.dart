import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../modules/404/pages/page_404.dart';
import '../routes/app_routes.dart';

class GlobalHelper {
  static final logger =
      Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false));

  static navigateToPageRemove(BuildContext context, String routeName) {
    final route = AppRoutes.routes[routeName];
    final page = (route != null) ? route.call(context) : const PageNotFound();
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        fullscreenDialog: true,
        reverseTransitionDuration: const Duration(milliseconds: 100),
        transitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: page,
        ),
      ),
      (route) => false,
    );
  }

  static Route navigationFadeIn(BuildContext context, Widget page) {
    return PageRouteBuilder(
      fullscreenDialog: true,
      reverseTransitionDuration: const Duration(milliseconds: 100),
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    );
  }

  static GlobalKey genKey() {
    GlobalKey key = GlobalKey();
    return key;
  }

  static String device = (Platform.isAndroid) ? "android" : "ios";

  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static String formatDate({required String dateStr}) {
    DateTime date = DateFormat('dd/MM/yyyy HH:mm').parse(dateStr);
    String formatDate =
        DateFormat('EEEE, dd \'de\' MMMM \'de\' yyyy HH:mm', "es").format(date);
    return formatDate[0].toUpperCase() + formatDate.substring(1).toLowerCase();
  }
}
