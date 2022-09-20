import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
 MyApp._internal();

static final MyApp  _instance = MyApp._internal();

factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRout,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: getTheme(),
    );
  }
}
