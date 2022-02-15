import 'dart:async';

import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/utility/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


part 'edit_profile_state.dart';
part 'edit_profile_event.dart';

class EditPageBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditPageBloc() : super(EditProfileState());
  final DataHelper _dataHelper = DataHelperImpl.instance;

  @override
  Stream<EditProfileState> mapEventToState(
      EditProfileEvent event,
      ) async* {
    if (event is NameChanged)
      yield state.update(isfNameValid: Validators.isValidFirstName(event.name));
    if (event is LastNameChanged)
      yield state.update(islNameValid: Validators.isValidFirstName(event.name));

    if (event is EmailChanged)
      yield state.update(isEmailValid: Validators.isValidEmail(event.email));

    if (event is NumberChanged)
      yield state.update(isNumberValid: Validators.isValidMobile(event.number));

    if (event is OtpChanged)
      yield state.update(isOtpValid: Validators.isValidOtp(event.otp));

    if (event is PasswordChanged)
      yield state.update(
          isPasswordValid: Validators.isValidPassword(event.password));

    if (event is SignupWithCredentialsClicked)
     // yield* _signUpWithCredentials(event);

  //  if (event is SendOtpClicked) yield* _sendOtp(event);

    //if (event is VerifyOtpClicked) yield* _verifyOtp(event);

    // if (event is GoogleSignupClicked)
    //   yield* _googleSignup();
    // if (event is FacebookSignupClicked)
    //   yield* _facebookSignup();
    //else
      UnimplementedError();
  }

 /* Stream<EditProfileState> _sendOtp(SendOtpClicked event) async* {
    yield state.copyWith(isSubmitting: true);
    final response =
    await _dataHelper.apiHelper.executeSendOtpRegister(event.number);
    yield* response.fold((l) async* {
      yield state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: l.errorMessage,
      );
    }, (r) async* {
      yield state.copyWith(
        isSubmitting: false,
        isFailure: false,
        signUpStage: SignUpStage.verifyOtp,
      );
    });
  }

  Stream<EditProfileState> _verifyOtp(VerifyOtpClicked event) async* {
    yield state.copyWith(isSubmitting: true);
    final response = await _dataHelper.apiHelper
        .executeVerifyOtpRegister(event.number, event.otp);
    yield* response.fold((l) async* {
      yield state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: l.errorMessage,
      );
    }, (r) async* {
      if (r.status == 'wrong_otp') {
        yield state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          isFailure: true,
          errorMessage: 'wrong otp',
        );
      } else {
        yield state.copyWith(
          isSubmitting: false,
          isFailure: false,
          signUpStage: SignUpStage.registerUser,
        );
      }
    });
  }

  Stream<EditProfileState> _signUpWithCredentials(
      SignupWithCredentialsClicked event) async* {
    yield state.copyWith(isSubmitting: true);
    final response = await _dataHelper.apiHelper.executeSignUp(
      SignUpRequest(
        name: event.name,
        email: event.email,
        password: event.password,
        phoneNo: event.number,
        confirmPassword: event.password,
      ),
    );
    yield* response.fold(
          (l) async* {
        yield state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          isFailure: true,
          errorMessage: l.errorMessage,
        );
      },
          (r) async* {
        yield state.copyWith(
          isSubmitting: false,
          isSuccess: true,
          isFailure: false,
        );
      },
    );
  }*/
}
