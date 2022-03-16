
import 'dart:io';

import 'package:biz_app_bloc/core/routes.dart';
import 'package:biz_app_bloc/feature/login/login_page.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:biz_app_bloc/core/routes.dart' as _router;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_helper.dart';
import '../utility/service/flutter_local_notification.dart';
import 'bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class App extends StatefulWidget {
  const App({Key? key, required this.appBloc}) : super(key: key);
  final AppBloc appBloc;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  FirebaseMessaging messaging =  FirebaseMessaging.instance;
  final DataHelper _dataHelper = DataHelperImpl.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterLocalNotification.initialize(context);
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) async {
      print(value);


      await _dataHelper.cacheHelper.saveAccessToken(value.toString());
    });

    if (Platform.isAndroid) {
      // dynamic iosSubscription = messaging.onIosSettingsRegistered.listen((data) {});
      messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
     _messageHandler();
  }
  void _messageHandler(){

    //App is in Terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message){

    });


// App is in foreground state
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification!=null) {
        FlutterLocalNotification.display(message);
      }
    });

    //When App is in background state but not Terminated
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('messageCome');
      print(message.data.toString());
      print(message.notification);
      print(message.notification.toString());
    });

  }
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
