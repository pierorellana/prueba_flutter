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
  String? userName;
  String? userLastName;
  String? userEmail;

  void navigateToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void getUserDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
      userLastName = prefs.getString('user_last_name');
      userEmail = prefs.getString('user_email');
    });
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
                  text: 'Eliminar Usuario',
                  onPressed: () {},
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
            if (userName != null && userLastName != null && userEmail != null)
            const Text("Usuarios Creados",
                style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
              CardWidget(
                userName: userName!,
                userLastName: userLastName!,
                userEmail: userEmail!,
              ),
          ],
        ),
      ),
    );
  }
}
