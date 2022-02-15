part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class GoogleSignupClicked extends EditProfileEvent {}

class FacebookSignupClicked extends EditProfileEvent {}

class NameChanged extends EditProfileEvent {
  NameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}
class LastNameChanged extends EditProfileEvent {
  LastNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}
class EmailChanged extends EditProfileEvent {
  EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class NumberChanged extends EditProfileEvent {
  NumberChanged(this.number);
  final String number;

  @override
  List<Object> get props => [number];
}

class OtpChanged extends EditProfileEvent {
  OtpChanged(this.otp);
  final String otp;

  @override
  List<Object> get props => [otp];
}

class PasswordChanged extends EditProfileEvent {
  PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordVisiblilityChanged extends EditProfileEvent {
  PasswordVisiblilityChanged(this.isVisible);
  final bool isVisible;

  @override
  List<Object> get props => [isVisible];
}

class SendOtpClicked extends EditProfileEvent {
  SendOtpClicked(this.number);
  final String number;

  @override
  List<Object> get props => [number];
}

class VerifyOtpClicked extends EditProfileEvent {
  VerifyOtpClicked(this.number, this.otp);
  final String number;
  final String otp;

  @override
  List<Object> get props => [number, otp];
}

class SignupWithCredentialsClicked extends EditProfileEvent {
  SignupWithCredentialsClicked(
      this.name, this.email, this.password, this.number);
  final String name;
  final String email;
  final String number;
  final String password;

  @override
  List<Object> get props => [name, email, password, number];
}

class RegisterWithCredentialsClicked extends EditProfileEvent {
  RegisterWithCredentialsClicked(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
