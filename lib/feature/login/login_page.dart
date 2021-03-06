
import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/core/routes.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/form_validator.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/spaces.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:biz_app_bloc/utility/validators.dart';
import 'package:biz_app_bloc/widgets/auth_widgets.dart';
import 'package:biz_app_bloc/widgets/form_input_field_with_icon.dart';
import 'package:biz_app_bloc/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'bloc/login_bloc.dart';


class LoginPage extends AppScreen {
  LoginPage({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends AppScreenState<LoginPage> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  late LoginBloc _loginBloc;

  @override
  void onInit() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _mobileController.addListener(_onEmailChanged);
    _otpController.addListener(_onOtpChanged);
    super.onInit();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(_mobileController.text));
  }

  void _onOtpChanged() {
    _loginBloc.add(OtpChanged(_otpController.text));
  }
  void _onLoginPressed() {
    _loginBloc.add(
      LoginWithCredentialsClicked(
        _mobileController.text
      ),
    );
  }
  void sigInWithOtp() {
    _loginBloc.add(
      LoginWithCredentialsOtp(
        _mobileController.text,_otpController.text
      ),
    );
  }
  @override
  Widget setView() {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32.0,
          ),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isSuccess!) {
                navigateToScreenAndReplace(Screen.home);
              }
              if (state.isFailure!) {
                ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                    SnackBar(content: Text('${state.errorMessage}')));
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _TopTitle(),
                    state.isPartial!
                        ? SpaceH60()
                        : SpaceH96(),
                    UsernameEditText(
                      _mobileController,
                      isValid:state.isPartial!||state.isSubmitting
                      !?true: state.isMobile,
                      iconPrefix: Icons.email,
                      fieldTitle: StringConst.label.MOBILE_NO,
                      usernameType: UsernameType.mobile,
                      hint_text: 'Mobile Number',
                      isnum: true,
                      hasPrefixText: true,
                      prefixText: StringConst.label.P_MOBILE_NO,
                      hasPrefixIcon: false,
                    ),
                    if (state.isPartial!)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 24.0,),
                          formFieldTitle(
                              fieldTitle: StringConst.label.OTP, theme: theme),
                          PinCodeTextField(
                            key: const Key('login_textField'),
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: AppColors.greyShade3,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
                            animationType: AnimationType.fade,
                            validator: Validator().otp,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              fieldHeight: 40,
                              fieldWidth: 40,
                              activeFillColor: Colors.transparent,
                              inactiveFillColor:Colors.transparent,
                              activeColor: AppColors.primaryColor,
                              inactiveColor: AppColors.grey,
                              selectedColor: AppColors.primaryColor,
                              disabledColor: AppColors.greyShade6,
                              selectedFillColor: Colors.transparent,
                              borderWidth: 1,
                            ),
                            cursorColor: AppColors.black,
                            animationDuration: Duration(milliseconds: 300),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            onCompleted: (otp) {
                              print("Completed");
                              _otpController.text = otp;
                            },
                            onTap: () {
                              print("Pressed");
                            },
                            onChanged: (otp) {
                              print(otp);
                            },
                          ),
                        ],
                      ),
                    SpaceH24(),
                    !state.isSubmitting!?

                    PrimaryButton(
                        title: state.isPartial!
                            ? CommonButtons.Sign_in
                            : CommonButtons.Send_OTP,
                        isLoading:  state.isSubmitting!?true:false,
                        onPressed: () {
                          state.isPartial!|| state.isMobile?
                         state.isPartial!
                              ? sigInWithOtp()
                              : _onLoginPressed():
                          ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                              SnackBar(content: Text('Please enter mobile Number')));
                        }, backgroundColor: Colors.red):const Center(child: CircularProgressIndicator(color: Colors.red,)),

                    SpaceH4(),
                    if (state.isFailure!)
                      Text(
                        'Failed',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    SpaceH24(),
                    state.isPartial!
                        ? _BottomLineOtp()
                        : _BottomLineMobile(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget formFieldTitle(
    {required String fieldTitle, required ThemeData theme}) {
  return Container(
    margin: EdgeInsets.only(bottom: Sizes.MARGIN_8),
    child: Text(
      fieldTitle,
      style: theme.textTheme.caption,
    ),
  );
}


class _TopTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme themeData = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SpaceH16(),
        Text(
          StringConst.sentence.WELCOME,
          style: themeData.caption,
        ),
        SpaceH8(),
        Text(
          StringConst.sentence.SIGNIN_TITLE,
          style: themeData.headline5,
        ),
      ],
    );
  }
}

class _BottomLineMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme themeData = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConst.sentence.SIGNIN_BOTTOM,
          style: themeData.caption,
        ),
        Text(
          ' ' + StringConst.sentence.Request_ACCESS,
          style: themeData.caption!.copyWith(color: AppColors.primaryColor),
        )
      ],
    );
  }
}

class _BottomLineOtp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme themeData = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConst.sentence.DNRC,
          style: themeData.caption,
        ),
        Text(
          ' ' + StringConst.sentence.Resend_Now,
          style: themeData.caption!.copyWith(color: AppColors.primaryColor),
        )
      ],
    );
  }
}
