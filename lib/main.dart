import 'dart:async';
import 'dart:developer';

import 'package:biz_app_bloc/app/app.dart';
import 'package:biz_app_bloc/feature/login/login_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'app/app_bloc_observer.dart';
import 'data/data_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
        () => runApp(App(appBloc: DataHelperImpl.instance.appBloc)),
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
