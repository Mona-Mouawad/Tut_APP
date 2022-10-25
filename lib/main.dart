import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/presentation/resources/langauge_manager.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    child: Phoenix(child: MyApp()),
    path: ASSET_PATH_LOCALISATIONS,
    supportedLocales: [ARABIC_LOCALE,ENGLISH_LOCALE],
  ));
}
