import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../env/theme/app_theme.dart';
import '../../../../shared/widget/filled_button.dart';
import '../../../../shared/widget/placeholder.dart';
import '../../../../shared/widget/text_form_field_widget.dart';

class FormAddUserWidget extends StatefulWidget {
  const FormAddUserWidget({super.key, this.keyDismiss});

  final GlobalKey<State<StatefulWidget>>? keyDismiss;

  @override
  State<FormAddUserWidget> createState() => _FormAddUserWidgetState();
}

class _FormAddUserWidgetState extends State<FormAddUserWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showPassword = false;
  List<Map<String, String>> userList = [];

  void saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;

    Map<String, String> newUser = {
      'user_name': name,
      'user_last_name': lastName,
      'user_email': email,
    };

    print(newUser);

    userList.add(newUser);
    await prefs.setString('user_list', jsonEncode(userList));
    Navigator.pop(context, jsonEncode(newUser));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.01, bottom: size.height * 0.01),
            child: placeHolderWidget(placeholder: 'Nombres')),
        TextFormFieldWidget(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El nombre es requerido.';
            }
            return null;
          },
        ),
        SizedBox(height: size.height * 0.025),
        Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.01, bottom: size.height * 0.01),
            child: placeHolderWidget(placeholder: 'Apellidos')),
        TextFormFieldWidget(
          keyboardType: TextInputType.text,
          controller: lastNameController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El apellido es requerido.';
            }
            return null;
          },
        ),
        SizedBox(height: size.height * 0.025),
        Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.01, bottom: size.height * 0.01),
            child: placeHolderWidget(placeholder: 'Correo')),
        TextFormFieldWidget(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
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
            padding: EdgeInsets.only(
                left: size.width * 0.01, bottom: size.height * 0.01),
            child: placeHolderWidget(placeholder: 'Nombre de usuario')),
        TextFormFieldWidget(
          keyboardType: TextInputType.text,
          // controller: _controllerName,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El nombre es usuario es requerido.';
            }
            return null;
          },
        ),
        SizedBox(height: size.height * 0.025),
        Padding(
            padding: EdgeInsets.only(left: size.width * 0.025),
            child: placeHolderWidget(placeholder: 'Contraseña')),
        SizedBox(height: size.height * 0.0056),
        TextFormFieldWidget(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          // controller: passwordController,
          obscureText: !showPassword,
        ),
        SizedBox(height: size.height * 0.025),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: FilledButtonWidget(
              color: AppTheme.primaryColor,
              textButtonColor: AppTheme.white,
              text: 'Registrar',
              onPressed: saveUserData,
            )),
      ],
    );
  }
}
