import 'package:biz_app_bloc/core/routes.dart';
import 'package:biz_app_bloc/feature/login/login_page.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:biz_app_bloc/core/routes.dart' as _router;

import 'bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class App extends StatefulWidget {
  const App({Key? key, required this.appBloc}) : super(key: key);
  final AppBloc appBloc;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => widget.appBloc),
      ],
      child: AppLanding(),
    );
  }
}

class AppLanding extends StatefulWidget {
  AppLanding({Key? key}) : super(key: key);

  @override
  _AppLandingState createState() => _AppLandingState();
}

class _AppLandingState extends State<AppLanding> {
  final _routes = _router.Router();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, constraints) {
      return OrientationBuilder(
        builder: (orientationContext, orientation) {
          //ResponsiveUtil().init(constraints, orientation);
         // AppTheme.setStatusBarAndNavigationBarColors(ThemeMode.system);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringConst.APP_NAME,
            theme: ThemeData.light(),
            onGenerateRoute: _routes.generateRoute,
            initialRoute: Screen.splash.toString(),
          );

        },
      );
    });
  }

  @override
  void dispose() {
    //_routes.dispose();
    super.dispose();
  }
}
