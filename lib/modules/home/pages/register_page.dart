import 'package:flutter/material.dart';
import 'package:prueba_flutter/shared/widget/layout.dart';
import '../../../../env/theme/app_theme.dart';
import '../widget/form_add_user.dart';

class RegisterPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>>? keyPage;

  const RegisterPage({Key? key, this.keyPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return HomeLayoutWidget(
      nameInterceptor: 'register',
      keyDismiss: widget.keyPage,
      requiredStack: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Hero(
                tag: 'logo',
                child: Text("Registro de Usuario",
                    style: TextStyle(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25))),
            SizedBox(height: size.height * 0.03),
            FormAddUserWidget(keyDismiss: widget.keyPage),
          ],
        ),
      ),
    );
  }
}
