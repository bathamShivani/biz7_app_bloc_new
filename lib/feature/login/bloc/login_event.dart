part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordClicked extends LoginEvent {}

class EmailChanged extends LoginEvent {
  EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class OtpChanged extends LoginEvent {
  OtpChanged(this.otp);
  final String otp;

  @override
  List<Object> get props => [otp];
}

class ResendOtpClicked extends LoginEvent {
  ResendOtpClicked(this.number);
  final String number;

  @override
  List<Object> get props => [number];
}

class PasswordVisiblilityChanged extends LoginEvent {
  PasswordVisiblilityChanged(this.isVisible);
  final bool isVisible;

  @override
  List<Object> get props => [isVisible];
}

class LoginWithCredentialsClicked extends LoginEvent {
  LoginWithCredentialsClicked(this.mobile);
  final String mobile;

  @override
  List<Object> get props => [mobile];
}
class LoginWithCredentialsOtp extends LoginEvent {
  LoginWithCredentialsOtp(this.mobile,this.otp);
  final String mobile;
  final String otp;

  @override
  List<Object> get props => [mobile,otp];
}
