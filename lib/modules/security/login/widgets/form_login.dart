import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../env/theme/app_theme.dart';
import '../../../../shared/provider/functional_provider.dart';
import '../../../../shared/widget/filled_button.dart';
import '../../../../shared/widget/placeholder.dart';
import '../../../../shared/widget/text_form_field_widget.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({super.key, this.keyDismiss});

  final GlobalKey<State<StatefulWidget>>? keyDismiss;

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.025),
          child: placeHolderWidget(placeholder: 'Usuario'),
        ),
        SizedBox(height: size.height * 0.006),
        TextFormFieldWidget(
          keyboardType: TextInputType.emailAddress,
          controller: userController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El correo es requerido.';
            }
            if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                .hasMatch(value)) {
              return 'El correo ingresado no es valido.';
            }
            return null;
          },
        ),
        SizedBox(height: size.height * 0.025),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.025),
          child: placeHolderWidget(placeholder: 'Contraseña'),
        ),
        SizedBox(height: size.height * 0.0056),
        TextFormFieldWidget(
          keyboardType: TextInputType.visiblePassword,
          controller: passwordController,
          obscureText: !showPassword,
          suffixIcon: IconButton(
            color: AppTheme.bordergrey,
            icon: !showPassword
                ? const Icon(Icons.remove_red_eye_outlined)
                : const Icon(Icons.visibility_off_outlined),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        ),
        SizedBox(height: size.height * 0.04),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: FilledButtonWidget(
            color: AppTheme.primaryColor,
            textButtonColor: AppTheme.white,
            text: 'Iniciar sesión',
            onPressed: () {
              _login(context);
            },
          ),
        ),
      ],
    );
  }

  void _login(BuildContext context) {
    if ((userController.text.trim() == 'admin' &&
            passwordController.text.trim() == 'admin') ||
        (userController.text.trim() == 'user' &&
            passwordController.text.trim() == 'user')) {
      final functionalProvider =
          Provider.of<FunctionalProvider>(context, listen: false);

      functionalProvider.login(
          userController.text.trim(), passwordController.text.trim());

      String route =
          (userController.text.trim() == 'user') ? '/user' : '/admin';
      Navigator.pushReplacementNamed(context, route);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciales incorrectas'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
