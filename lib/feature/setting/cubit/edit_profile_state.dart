part of 'edit_profile_bloc.dart';

enum SignUpStage { sendOtp, verifyOtp, registerUser }

@immutable
class EditProfileState extends Equatable {
  EditProfileState({
    this.isfNameValid = false,
    this.islNameValid = false,
    this.isAddressValid = false,
    this.isEmailValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage = '',
    this.isNumberValid = false,
    this.isOtpValid = false,
    //this.signUpStage = SignUpStage.sendOtp,
  });
  // factory EditProfileState.empty() {
  //   return EditProfileState(
  //     isNameValid: false,
  //     isEmailValid: false,
  //     isPasswordValid: false,
  //     isNumberValid: false,
  //     isSubmitting: false,
  //     isSuccess: false,
  //     isFailure: false,
  //     errorMessage: '',
  //     signUpStage: SignUpStage.sendOtp,
  //   );
  // }
  // factory EditProfileState.loading() {
  //   return EditProfileState(
  //       isNameValid: true,
  //       isEmailValid: true,
  //       isPasswordValid: true,
  //       isSubmitting: true,
  //       isSuccess: false,
  //       isFailure: false,
  //       errorMessage: '');
  // }
  factory EditProfileState.failure(String errorMessage) {
    return EditProfileState(
      isfNameValid: true,
      islNameValid: true,
      isAddressValid: true,
      isEmailValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }

  // factory EditProfileState.success() {
  //   return EditProfileState(
  //       isNameValid: true,
  //       isEmailValid: true,
  //       isPasswordValid: true,
  //       isSubmitting: false,
  //       isSuccess: true,
  //       isFailure: false,
  //       errorMessage: '');
  // }
  final bool? islNameValid;
  final bool? isfNameValid;
  final bool? isAddressValid;
  final bool? isEmailValid;
  final bool? isNumberValid;
  final bool? isOtpValid;
  final bool? isSubmitting;
  final bool? isSuccess;
  final bool? isFailure;
  final String? errorMessage;

  bool get isMobileValid => isNumberValid!;
  bool get isMobileOtpValid => isOtpValid!;
  bool get isCredentialsValid =>
      isNumberValid! && isEmailValid! && isfNameValid! && islNameValid! && isAddressValid!;

  EditProfileState update({
    bool? isfNameValid,
    bool? islNameValid,
    bool? isAddressValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isNumberValid,
    bool? isOtpValid,
  }) {
    return copyWith(
      isfNameValid: isfNameValid,
      islNameValid: islNameValid,
      isAddressValid: isAddressValid,
      isEmailValid: isEmailValid,
      isNumberValid: isNumberValid,
      isPasswordValid: isPasswordValid,
      isOtpValid: isOtpValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  EditProfileState copyWith({
    bool? isfNameValid,
    bool? islNameValid,
    bool? isAddressValid,
    bool? isEmailValid,
    bool? isNumberValid,
    bool? isOtpValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    SignUpStage? signUpStage,
    String? errorMessage,
  }) {
    return EditProfileState(
      isfNameValid: isfNameValid ?? this.isfNameValid,
      islNameValid: islNameValid ?? this.islNameValid,
      isAddressValid: isAddressValid ?? this.isAddressValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isNumberValid: isNumberValid ?? this.isNumberValid,
      isOtpValid: isOtpValid ?? this.isOtpValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
     // signUpStage: signUpStage ?? this.signUpStage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''EditProfileState {
      isfNameValid: $isfNameValid,
      islNameValid: $islNameValid,
      isAddressValid: $isAddressValid,
      isEmailValid: $isEmailValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }

  @override
  List<Object> get props => [
    isfNameValid!,
    islNameValid!,
    isAddressValid!,
    isEmailValid!,
    isSubmitting!,
    isSuccess!,
    isFailure!,
    isNumberValid!,
    errorMessage!,
    isOtpValid!,
  ];
}
