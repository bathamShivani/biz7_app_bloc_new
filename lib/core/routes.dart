import 'package:biz_app_bloc/feature/bookmark/cubit/bookmark_cubit.dart';
import 'package:biz_app_bloc/feature/home/detail/cubit/detail_cubit.dart';
import 'package:biz_app_bloc/feature/home/detail/detailpage.dart';
import 'package:biz_app_bloc/feature/home/pdfviewer.dart';
import 'package:biz_app_bloc/feature/home/web_view.dart';
import 'package:biz_app_bloc/feature/home_navigation/cubit/homenavigation_cubit.dart';
import 'package:biz_app_bloc/feature/home_navigation/home.dart';
import 'package:biz_app_bloc/feature/login/bloc/login_bloc.dart';
import 'package:biz_app_bloc/feature/login/login_page.dart';
import 'package:biz_app_bloc/feature/splash_screen/cubit/splash_cubit.dart';
import 'package:biz_app_bloc/feature/splash_screen/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bundle.dart';
import 'package:biz_app_bloc/feature/home/cubit/home_page_cubit.dart';

enum Screen {
  splash,
  login,
  home,
  detail,
  pdfview,
  webview
}

class Router {
  final _categoryCubit = HomePageCubit();
  final _bookmarkCubit = BookmarkCubit();

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

      case Screen.home:
        return MaterialPageRoute(
            builder: (_) =>
                MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _categoryCubit,
                    ),
                    BlocProvider.value(
                      value: _bookmarkCubit,
                    ),

                    BlocProvider(create: (context) => HomeNavigationCubit())
                  ],
                  child: HomeNavigationScreen(
                      arguments: settings.arguments != null
                          ? settings.arguments as Bundle
                          : null),
                ));

      case Screen.detail:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (context) => DetailCubit(),
                  child: DetailPage(
                      arguments: settings.arguments != null
                          ? settings.arguments as Bundle
                          : null),
                ));

      case Screen.pdfview:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (context) => LoginBloc(),
                  child: PdfViewer(
                      arguments: settings.arguments != null
                          ? settings.arguments as Bundle
                          : null),
                ));

      case Screen.webview:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (context) => LoginBloc(),
                  child: WebViewPage(
                      arguments: settings.arguments != null
                          ? settings.arguments as Bundle
                          : null),
                ));
    }
  }
}
