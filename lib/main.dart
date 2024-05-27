import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'env/environment.dart';
import 'env/theme/app_theme.dart';
import 'shared/provider/functional_provider.dart';
import 'shared/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  String environment = const String.fromEnvironment('ENVIRONMENT',
      defaultValue: Environment.dev);
  Environment().initConfig(environment);
  initializeDateFormatting('es');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appName = Environment().config?.appName ?? 'name app default';
        //Comentario de prueba SonarQube

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FunctionalProvider())],
      child: MaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme().theme(),
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
          onGenerateRoute: AppRoutes.onGenerateRoute),
    );
  }
}
