import 'dart:async';
import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/model/User.dart';
import 'package:biz_app_bloc/utility/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.empty());
  final DataHelper _dataHelper = DataHelperImpl.instance;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged){
      if (Validators.isValidMobile(event.mobile)) {
        yield state.copyWith(
          isMobile: true, );
      }
      else{
        yield state.copyWith(
          isMobile: false, );
      }
    }

    if (event is PasswordChanged)
      yield state.update(
          isPasswordValid: Validators.isValidPassword(event.password));

    if (event is OtpChanged) {
      print('${Validators.isValidOtp(event.otp)}');
      yield state.update(isOtpValid: Validators.isValidOtp(event.otp));
    }
    if (event is LoginWithCredentialsClicked) {
      if (!state.isMobile) {
        if (Validators.isValidMobile(event.mobile)) {
          yield state.copyWith(
               isMobile: true);
        }

      } else {

        if (state.isMobile)
          yield* _loginWithCredentials(event);
      }
    } else
      UnimplementedError();

    if (event is LoginWithCredentialsOtp) {

          yield* _loginWithOtp(event);

    } else
      UnimplementedError();
  }

  Stream<LoginState> _loginWithCredentials(
      LoginWithCredentialsClicked event) async* {
    print('mobile');
    final fcmToken = await DataHelperImpl.instance.cacheHelper.getFcmToken();
    yield LoginState.loading(false);
    final response = await _dataHelper.apiHelper.executeLogin(
        event.mobile,fcmToken);
    yield* response.fold((l) async* {
      yield LoginState.failure(l.errorMessage,false);
    },  (r) async* {
      await _dataHelper.cacheHelper.saveAccessToken(r.data.id.toString());

      yield LoginState.partial();
      });

  }

  Stream<LoginState> _loginWithOtp(LoginWithCredentialsOtp event) async* {
    yield LoginState.loading(true);
    print('otp');

    final id = await DataHelperImpl.instance.cacheHelper.getAccessToken();

    final fcmToken = await DataHelperImpl.instance.cacheHelper.getFcmToken();
    final response =
    await _dataHelper.apiHelper.executeVerifyOtp(id, event.otp);
    yield* response.fold((l) async* {
      yield LoginState.failure(l.errorMessage,true);
    }, (r) async* {
        await _dataHelper.cacheHelper.saveUserInfo(userToJson(r));
        yield LoginState.success(true);
      });
   // });
  }


}
