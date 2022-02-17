import 'dart:async';
import 'dart:io';

import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/model/User.dart';
import 'package:biz_app_bloc/utility/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:biz_app_bloc/model/User.dart' as info;


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

  }
  Future<void> updateProfile(fname,lname,dob,gender,email,address) async {
    emit(state.copyWith(isSubmitting: true));
    final result = info.userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    final response = await _dataHelper.apiHelper.updateProfile(result.data.id,fname,lname,dob,gender,email,address);


    response.fold((l) {
      print('failure');
      print(l.errorMessage);
      emit(state.copyWith(errorMessage : l.errorMessage,isSuccess: false,isFailure: true,isSubmitting: false));
    }, (r) async{
      print('success');
      print(r);
      await _dataHelper.cacheHelper.saveUserInfo(userToJson(r));
      emit(state.copyWith(errorMessage : 'Profile detail updated successfully.',isFailure: false,isSuccess: true,isSubmitting: false));
    });
  }
  Future<void> updateProfilePic(File file) async {
    print('file.path updateProfile' + file.path);
    emit(state.copyWith(isSubmitting: true));
    final result = info.userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    final response = await _dataHelper.apiHelper.updateProfilePic(result.data.id,file.path);
    response.fold((l) {
      emit(state.copyWith(errorMessage : l.errorMessage,ispicupdate:false));
    }, (r) async{
      await _dataHelper.cacheHelper.saveUserInfo(userToJson(r));
      emit(state.copyWith(errorMessage : 'Profile detail updated successfully.',ispicupdate: true));
    });
  }
}
