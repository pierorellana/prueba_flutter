import 'package:flutter/material.dart';

import '../../env/theme/app_theme.dart';
import '../widget/alerts_template.dart';

class FunctionalProvider extends ChangeNotifier {
  List<Widget> alerts = [];
  List<Widget> alertLoading = [];

  bool _isAdmin = false;
  bool _isUser = false;
  bool _isLoggedIn = false;

  bool get isAdmin => _isAdmin;
  bool get isUser => _isUser;
  bool get isLoggedIn => _isLoggedIn;

  void login(String username, String password) {
    if (username == 'admin' && password == 'admin') {
      _isAdmin = true;
      _isLoggedIn = true;
    }
    if (username == 'user' && password == 'user') {
      _isUser = true;
      _isLoggedIn = true;
    }
    notifyListeners();
  }

  showAlert(
      {required GlobalKey key,
      required Widget content,
      bool closeAlert = false,
      bool animation = true,
      double padding = 20}) {
    final newAlert = Container(
        key: key,
        color: AppTheme.transparent,
        child: AlertTemplate(
            content: content,
            keyToClose: key,
            dismissAlert: closeAlert,
            animation: animation,
            padding: padding));
    alerts.add(newAlert);

    notifyListeners();
  }

  showAlertLoading(
      {required GlobalKey key,
      required Widget content,
      bool closeAlert = false,
      bool animation = true}) {
    final newAlert = Container(
        key: key,
        color: Colors.transparent,
        child: AlertTemplate(
            content: content,
            keyToClose: key,
            dismissAlert: closeAlert,
            animation: animation));
    alertLoading.add(newAlert);
    alerts.add(newAlert);

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => notifyListeners());
  }

  addPage({required GlobalKey key, required Widget content}) {
    alerts.add(content);
    notifyListeners();
  }

  dismissAlert({required GlobalKey key}) {
    alerts.removeWhere((alert) => key == alert.key);
    notifyListeners();
  }

  clearAllAlert() {
    alerts = [];
    notifyListeners();
  }

  dismissAlertLoading({required GlobalKey key}) {
    alertLoading.removeWhere((alert) => key == alert.key);
    alerts.removeWhere((alert) => key == alert.key);
    notifyListeners();
  }
}
