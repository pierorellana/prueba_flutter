
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_flutter/shared/provider/functional_provider.dart';

class AuthProvider extends StatelessWidget {
  final Widget child;
  const AuthProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FunctionalProvider>(
      create: (context) => FunctionalProvider(),
      child: child,
    );
  }

  static FunctionalProvider of(BuildContext context) =>
      Provider.of<FunctionalProvider>(context, listen: false);
}
