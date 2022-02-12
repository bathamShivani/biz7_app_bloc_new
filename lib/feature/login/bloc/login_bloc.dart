import 'dart:async';

import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/model/Login.dart';
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
    }

    if (event is PasswordChanged)
      yield state.update(
          isPasswordValid: Validators.isValidPassword(event.password));

    if (event is OtpChanged) {
      print('${Validators.isValidOtp(event.otp)}');
      yield state.update(isOtpValid: Validators.isValidOtp(event.otp));
    }

    //if (event is ResendOtpClicked) yield* _resendOtp(event);

    if (event is LoginWithCredentialsClicked) {
      if (!state.isMobile) {
        if (Validators.isValidMobile(event.mobile)) {
          yield state.copyWith(
               isMobile: true, );
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
    yield LoginState.loading(false);
    final response = await _dataHelper.apiHelper.executeLogin(
        event.mobile);
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


/*Stream<LoginState> _loginWithOtp(LoginWithCredentialsClicked event) async* {
    yield LoginState.loading();
    final response =
        await _dataHelper.apiHelper.executeVerifyOtp(event.email, event.otp);
    yield* response.fold((l) async* {
      yield LoginState.failure(l.errorMessage);
    }, (r) async* {
      await _dataHelper.cacheHelper.saveAccessToken(r.accessToken!);
      final userResponse = await _dataHelper.apiHelper.executeUserDetails();
      yield* userResponse.fold((l) async* {
        yield LoginState.failure(l.errorMessage);
      }, (r) async* {
        await _dataHelper.cacheHelper.saveUserInfo(userToMap(r));
        yield LoginState.success();
      });
    });
  }

  Stream<LoginState> _sendOtp(LoginWithCredentialsClicked event) async* {
    yield state.copyWith(isSubmitting: true);
    final response = await _dataHelper.apiHelper.executeSendOtp(event.email);
    yield* response.fold((l) async* {
      if (l.errorCode == 400)
        yield state.copyWith(
            isMobile: true,
            isEmail: false,
            isSubmitting: false,
            isUsernameReadOnly: true);

      yield LoginState.failure(l.errorMessage);
    }, (r) async* {
      yield state.copyWith(
          isMobile: true,
          isEmail: false,
          isSubmitting: false,
          isUsernameReadOnly: true);
    });
  }

  Stream<LoginState> _resendOtp(ResendOtpClicked event) async* {
    yield state.copyWith(isSubmitting: true);
    final response = await _dataHelper.apiHelper.executeResendOtp(event.number);
    yield* response.fold((l) async* {
      if (l.errorCode == 400)
        yield state.copyWith(
            isMobile: true,
            isEmail: false,
            isSubmitting: false,
            isUsernameReadOnly: true);

      yield LoginState.failure(l.errorMessage);
    }, (r) async* {
      yield state.copyWith(
          isMobile: true,
          isEmail: false,
          isSubmitting: false,
          isUsernameReadOnly: true);
    });
  }*/
}
