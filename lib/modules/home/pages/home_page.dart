import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prueba_flutter/env/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/widget/cards/card_widget.dart';
import '../../../shared/widget/filled_button.dart';
import '../../../shared/widget/layout.dart';
import 'register_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerSearch = TextEditingController();
  List<Map<String, String>> userList = [];

  void navigateToRegisterPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
    if (result != null) {
      setState(() {
        Map<String, dynamic> newUser = jsonDecode(result);
        userList.add(newUser.cast<String, String>());
      });
    }
  }

  void deleteUserAndPrefs(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userList.removeAt(index);
      prefs.setString('user_list', jsonEncode(userList));
    });
  }

  void getUserDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userListString = prefs.getString('user_list');
    if (userListString != null && userListString.isNotEmpty) {
      setState(() {
        userList = List<Map<String, String>>.from(jsonDecode(userListString).map((item) => Map<String, String>.from(item)));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDataFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return HomeLayoutWidget(
      nameInterceptor: "home",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Selecciona una de estas opciones",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                FilledButtonWidget(
                  color: AppTheme.secondaryColor,
                  textButtonColor: AppTheme.white,
                  text: 'Agregar Usuario',
                  onPressed: navigateToRegisterPage,
                ),
                FilledButtonWidget(
                  color: AppTheme.secondaryColor,
                  textButtonColor: AppTheme.white,
                  text: 'Asignar Permisos',
                  onPressed: () {},
                ),
                FilledButtonWidget(
                  color: AppTheme.secondaryColor,
                  textButtonColor: AppTheme.white,
                  text: 'Revocar Permisos',
                  onPressed: () {},
                ),
                FilledButtonWidget(
                  color: AppTheme.secondaryColor,
                  textButtonColor: AppTheme.white,
                  text: 'Ver Registros de Acceso',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            userList.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: userList.map((user) {
                        return CardWidget(
                          userName: user['user_name']!,
                          userLastName: user['user_last_name']!,
                          userEmail: user['user_email']!,
                          onDelete: () => deleteUserAndPrefs(userList.indexOf(user)),
                        );
                      }).toList(),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
