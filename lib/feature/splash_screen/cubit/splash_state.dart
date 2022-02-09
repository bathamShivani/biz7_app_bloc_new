part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class LoggedInState extends SplashState {
  LoggedInState(this.isLoggedIn);
  final bool isLoggedIn;

  @override
  List<Object> get props => [isLoggedIn];
}
