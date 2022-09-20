import 'package:flutter/material.dart';
import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/presentation/ForgotPassword/ForgotPasswordView.dart';
import 'package:tut_app/presentation/Login/LoginView.dart';
import 'package:tut_app/presentation/Main/MainView.dart';
import 'package:tut_app/presentation/OnBoarding/OnBoardingView.dart';
import 'package:tut_app/presentation/Register/RegisterView.dart';
import 'package:tut_app/presentation/Splash/SplashView.dart';
import 'package:tut_app/presentation/StoreDetails/StoreDetailsView.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

class Routes {
  static const String splashRout = '/';

  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String onBoardingRoute = "/onBoardingRoute";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRout:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());

      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

     case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
