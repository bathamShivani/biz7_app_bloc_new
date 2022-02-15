part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  LoginState({
    this.isEmailValid,
    this.isPasswordValid,
    this.isSubmitting,
    this.isSuccess,
    this.isFailure,
    this.isPartial,
    this.errorMessage,
    this.isEmail = false,
    this.isMobile = false,
    this.isOtp = false,
    this.isUsernameReadOnly = false,
    this.isOtpValid,
  });
  factory LoginState.empty() {
    return LoginState(
        isEmailValid: false,
        isPasswordValid: false,
        isOtpValid: false,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isPartial: false,
        isEmail: false,
        isMobile: false,
        errorMessage: '');
  }
  factory LoginState.loading(bool isPartial) {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isOtpValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        isPartial: isPartial,
        errorMessage: '');
  }
  factory LoginState.failure(String errorMessage,bool isPartial) {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: false,
      isOtpValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isPartial: isPartial,
      errorMessage: errorMessage,
    );
  }

  factory LoginState.socialLoginFailure(String errorMessage) {
    return LoginState(
      isEmailValid: false,
      isPasswordValid: false,
      isOtpValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isPartial: false,
      errorMessage: errorMessage,
    );
  }

  factory LoginState.success(bool isPartial) {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isOtpValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        isPartial: false,
        errorMessage: '');
  }
  factory LoginState.partial() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isOtpValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isPartial: true,
        errorMessage: '');
  }
  final bool? isEmailValid;
  final bool? isPasswordValid;
  final bool? isOtpValid;
  final bool? isSubmitting;
  final bool? isSuccess;
  final bool? isFailure;
  final bool? isPartial;
  final String? errorMessage;
  final bool isMobile;
  final bool isEmail;
  final bool isOtp;
  final bool isUsernameReadOnly;

  bool get isUsernameValid => isEmailValid!;
  bool get isFormValid => (isMobile);

  LoginState update({
    bool? isMobile,
    bool? isPasswordValid,
    bool? isOtpValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isOtpValid: isOtpValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isOtpValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isPartial,
    bool? isMobile,
    bool? isEmail,
    bool? isUsernameReadOnly,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isPartial: isPartial ?? this.isPartial,
      isMobile: isMobile ?? this.isMobile,
      isEmail: isEmail ?? this.isEmail,
      isUsernameReadOnly: isUsernameReadOnly ?? this.isUsernameReadOnly,
      isOtpValid: isOtpValid ?? this.isOtpValid,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isPartial: $isPartial,
    }''';
  }

  @override
  List<Object> get props => [
        isEmailValid!,
        isPasswordValid!,
        isOtpValid!,
        isSubmitting!,
        isSuccess!,
        isFailure!,
        isPartial!,
        isEmail,
        isMobile,
        isUsernameReadOnly,
      ];
}
