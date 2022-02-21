import 'dart:async';
import 'dart:ui';

import 'package:biz_app_bloc/app/bloc/app_bloc.dart';
import 'package:biz_app_bloc/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bundle.dart';


abstract class AppScreen extends StatefulWidget {
  AppScreen(this.routeObserver, key, this.arguments) : super(key: key);
  final RouteObserver? routeObserver;
  final Bundle? arguments;
}

abstract class AppScreenState<WIDGET extends AppScreen> extends State<WIDGET>
    with WidgetsBindingObserver, RouteAware {
  final GlobalKey<ScaffoldState> globalKey =
      GlobalKey<ScaffoldState>(debugLabel: 'debugLable');

  AppLifecycleState? state;

  TextTheme get textTheme => Theme.of(context).textTheme;

  ThemeData get theme => Theme.of(context);


  bool _isExecuting = false;

  final String imagePath = 'assets/images/';

  final String flarePath = 'assets/flare/';

  late final AppBloc _appBloc;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
    onInit();
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    widget.routeObserver?.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is UserLoggedOut) {
          Navigator.popUntil(context, (route) => true);
          //Navigator.of(context).pushNamed(context,M);
        }
      },
      builder: (context, state) {
        return WillPopScope(
            onWillPop: () async => onBackPressed(),
            child: Scaffold(
              key: globalKey,
              resizeToAvoidBottomInset: isResizeToAvoidBottomInset(),
              appBar: appBar(),
              bottomNavigationBar: bottomNavigator(),
              floatingActionButton: floatingActionButton(),
              drawer: drawer(),
              body: SafeArea(
                left: false,
                right: false,
                child: setView(),
              ),
            ));
      },
    );
  }

  Widget? bottomNavigator() {}

  Widget? floatingActionButton() {}

  AppBar? appBar() {}

  Widget? drawer() {}

  Widget setView();

  bool widgetInsideSafeArea() {
    return true;
  }

  bool isResizeToAvoidBottomInset() {
    return true;
  }

  @override
  @mustCallSuper
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    this.state = state;
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.detached:
        onSuspending();
        break;
    }
  }

  void onInit() {}

  void onPaused() {}

  void onResumed() {}

  void onSuspending() {}

  Future navigateToScreen(Screen screen, [Bundle? bundle]) async {
    bundle ??= Bundle();
    await Navigator.pushNamed(context, screen.toString(), arguments: bundle)
        .then(onBackResult);
  }

  Future navigateToScreenAndReplace(Screen screen, [Bundle? bundle]) async {
    bundle ??= Bundle();
    await Navigator.pushReplacementNamed(context, screen.toString(),
        arguments: bundle)
        .then(onBackResult);
  }

  Future navigatePopUntil(Screen screen) async {
    if (Navigator.canPop(context))
      Navigator.popUntil(context, ModalRoute.withName(screen.toString()));
  }

  Future navigateToBack([Bundle? bundle]) async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, bundle);
    }
  }

  bool onBackPressed() {

    return true;
  }

  void onBackResult(Object? bundle) {}

  void onConnectionTimeout(Function onRetryCallback) {
    showSnackBar('Connection Timeout, Please check your Internet');
  }

  void onReceiveTimeout(Function onRetryCallback) {
    showSnackBar('Connection Timeout, Please check your Internet');
  }

  void onSendTimeout(Function onRetryCallback) {
    showSnackBar('Connection Timeout, Please check your Internet');
  }

  void onUnknownApiError(String error, Function onRetryCallback) {
    showSnackBar('Unknown Error Occurred: $error');
  }

  void onNoConnectionError(String error, Function onRetryCallback) {
    showSnackBar('Connection Issue, Please check your Internet: $error');
  }

  void onSessionExpired() {
    print('onSessionExpired() Cleaning session');
//    debounce(() => viewModel.clearSession());
    debounce(() {
     // navigateToScreenAndReplace(Screen.login);
    });
  }

  void debounce(Function action) async {
    if (!_isExecuting) {
      _isExecuting = true;
      action();
      await Future.delayed(const Duration(milliseconds: 300), () {
        _isExecuting = false;
      });
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
