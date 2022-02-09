import 'dart:async';

import 'package:biz_app_bloc/data/data_helper.dart';
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
    if (event is EmailChanged)
      yield state.update(isEmailValid: Validators.isValidUsername(event.email));

    if (event is PasswordChanged)
      yield state.update(
          isPasswordValid: Validators.isValidPassword(event.password));

    if (event is OtpChanged) {
      print('${Validators.isValidOtp(event.otp)}');
      yield state.update(isOtpValid: Validators.isValidOtp(event.otp));
    }

    //if (event is ResendOtpClicked) yield* _resendOtp(event);

    if (event is LoginWithCredentialsClicked) {
      if ( !state.isMobile) {
        if (Validators.isValidMobile(event.mobile)) {
          yield state.copyWith(
              isEmail: false, isMobile: true, isUsernameReadOnly: true);
        } else {
         // yield* _sendOtp(event);
        }
      } else {
        if (state.isMobile)
          yield* _loginWithCredentials(event);
        else
          yield* _loginWithOtp(event);
      }
    } else
      UnimplementedError();
  }

  Stream<LoginState> _loginWithCredentials(
      LoginWithCredentialsClicked event) async* {
    yield LoginState.loading();
    final response = await _dataHelper.apiHelper.executeLogin(
        event.mobile);
    yield* response.fold((l) async* {
      yield LoginState.failure(l.errorMessage);
    },  (r) async* {
        yield LoginState.partial();
      });

  }
  Stream<LoginState> _loginWithOtp(LoginWithCredentialsClicked event) async* {
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
