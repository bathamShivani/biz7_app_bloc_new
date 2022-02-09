import 'package:biz_app_bloc/feature/login/bloc/login_bloc.dart';
import 'package:biz_app_bloc/feature/login/login_page.dart';
import 'package:biz_app_bloc/feature/splash_screen/cubit/splash_cubit.dart';
import 'package:biz_app_bloc/feature/splash_screen/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bundle.dart';

enum Screen {
  splash,
  login,
}

class Router {

  Route<dynamic> generateRoute(RouteSettings settings)  {
    var screen = Screen.values.firstWhere((e) => e.toString() == settings.name);

    switch (screen) {
      case Screen.splash:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                    create: (context) => SplashCubit(),
                    child: SplashScreen(
                        arguments: settings.arguments != null
                            ? settings.arguments as Bundle
                            : null)));

      case Screen.login:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (context) => LoginBloc(),
                  child: LoginPage(
                      arguments: settings.arguments != null
                          ? settings.arguments as Bundle
                          : null),
                ));
    }
  }
}
