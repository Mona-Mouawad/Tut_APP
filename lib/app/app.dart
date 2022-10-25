import 'package:flutter/material.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
 MyApp._internal();

static final MyApp  _instance = MyApp._internal();

factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppPreferences _appPreferences = instance<AppPreferences> ();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local)=> {
      context.setLocale(local)
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRout,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: getTheme(),
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
