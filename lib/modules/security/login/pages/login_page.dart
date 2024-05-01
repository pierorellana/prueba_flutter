import 'package:flutter/material.dart';
import 'package:prueba_flutter/shared/widget/layout.dart';
import '../../../../env/theme/app_theme.dart';
import '../widgets/form_login.dart';

class LoginPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>>? keyPage;

  const LoginPage({super.key, this.keyPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return HomeLayoutWidget(
      nameInterceptor: 'login',
      keyDismiss: widget.keyPage,
      requiredStack: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Hero(
                tag: 'logo',
                child: Text("Bienvenido!",
                    style: TextStyle(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))
                ),
            SizedBox(height: size.height * 0.03),
            FormLoginWidget(keyDismiss: widget.keyPage),
          ],
        ),
      ),
    );
  }
}
