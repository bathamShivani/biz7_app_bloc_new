import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/splash_cubit.dart';


class SplashScreen extends AppScreen {
  SplashScreen({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends AppScreenState<SplashScreen>
    with TickerProviderStateMixin {
  late SplashCubit _splashCubit;
  late final AnimationController _controller;
  late final Duration _splashEndDuration;
  @override
  void onInit() {
    _controller = AnimationController(vsync: this);
    _splashCubit = BlocProvider.of<SplashCubit>(context);
    _splashCubit.getLoggedInStatus();
    super.onInit();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget setView() {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is LoggedInState)
          Future.delayed(const Duration(seconds: 5), () {
            state.isLoggedIn
                ? navigateToScreenAndReplace(Screen.home)
                : navigateToScreenAndReplace(Screen.login);
          });
      },
      child: Container(
          width: 0.0,
          height: 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              Container(
                width: 0.0,
                height: 45.0,
                child: Image.asset('assets/images/splash.png'),
              ),
              const Spacer(),
            ],
          )),
    );
  }
}
