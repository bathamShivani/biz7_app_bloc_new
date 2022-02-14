import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/core/routes.dart';
import 'package:biz_app_bloc/feature/setting/cubit/edit_profile_bloc.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/form_validator.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/spaces.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:biz_app_bloc/widgets/auth_widgets.dart';
import 'package:biz_app_bloc/widgets/custom_appbar.dart';
import 'package:biz_app_bloc/widgets/form_input_field_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter/src/widgets/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kSpacingUnit = 10;

class ProfileScreen extends AppScreen {
  ProfileScreen({RouteObserver<Route>? routeObserver, key, Bundle? arguments})
      : super(routeObserver, key, arguments);


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends AppScreenState<ProfileScreen> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  List gender = ["Male", "Female", "Other"];
  var select;
  late EditPageBloc editPageBloc;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    editPageBloc = BlocProvider.of<EditPageBloc>(context);
    fnameController.addListener(_onfNameChanged());
    lnameController.addListener(_onlNameChanged());
    emailController.addListener(_onEmailChanged);
    mobileController.addListener(_onMobileChanged);
    addressController.addListener(_onAddressChanged());

  }
   _onfNameChanged() {
    editPageBloc.add(NameChanged(fnameController.text));
  }
  _onlNameChanged() {
    editPageBloc.add(NameChanged(lnameController.text));
  }
  _onAddressChanged() {
    editPageBloc.add(NameChanged(addressController.text));
  }
  void _onEmailChanged() {
    editPageBloc.add(EmailChanged(emailController.text));
  }
  void _onMobileChanged() {
    editPageBloc.add(NumberChanged(mobileController.text));
  }




  @override
  Widget setView() {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
          child: CustomAppBar(
            title: StringConst.PROFILE_SCREEN.toUpperCase(),
            leading: InkWell(
              onTap: () => navigateToBack(),
              child: Icon(
                Icons.arrow_back_outlined,
                color: AppColors.black,
              ),
            ),
            hasTrailing: false,
          ),
        ),
        body: BlocConsumer<EditPageBloc, EditProfileState>(
            listener: (context, state) {
              if (state.isSuccess!) {
                print('true');
                navigateToScreenAndReplace(Screen.home);
              }
              if (state.isFailure!) {
                ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                    SnackBar(content: Text('${state.errorMessage}')));
              }
            },
            builder: (context, state) {
             return SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(top: kSpacingUnit * 3),
                        child: Stack(children: <Widget>[
                          CircleAvatar(
                              radius: kSpacingUnit * 5,
                              backgroundImage: AssetImage(
                                  'assets/images/logo.png')),


                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              //onTap: () => {selectImage(context)},
                              child: Container(
                                height: kSpacingUnit * 3.5,
                                width: kSpacingUnit * 3.5,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  heightFactor: kSpacingUnit * 2.5,
                                  widthFactor: kSpacingUnit * 2.5,
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.PADDING_10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SpaceH8(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'First Name',
                              style: textTheme.bodyText2,
                            ),
                          ),

                          UsernameEditText(
                            fnameController,
                            isValid:state.isfNameValid,
                            usernameType: UsernameType.fname,
                            hint_text: 'First Name',
                          ),

                          SizedBox(
                            height: 10.0,
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Last Name',
                              style: textTheme.bodyText2,
                            ),
                          ),

                          UsernameEditText(
                            lnameController,
                            isValid:state.islNameValid,

                            usernameType: UsernameType.lname,
                            hint_text: 'Last Name',
                          ),

                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Mobile Number',
                              style: textTheme.bodyText2,
                            ),
                          ),

                          UsernameEditText(
                            mobileController,
                            isValid:state.isNumberValid,

                            usernameType: UsernameType.mobile,
                            hint_text: 'Mobile Number',
                            isnum: true,
                          ),

                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email Id',
                              style: textTheme.bodyText2,
                            ),
                          ),

                          UsernameEditText(
                            emailController,
                            isValid:state.isEmailValid,

                            usernameType: UsernameType.email,
                            hint_text: 'Email Id',
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                         /* Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Date of Birth',
                              style: textTheme.bodyText2,
                            ),
                          ),

                          UsernameEditText(
                            fnameController,

                            usernameType: UsernameType.mobile,
                            hint_text: 'Dob',
                          ),*/
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gender',
                              style: textTheme.bodyText2,
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Sizes.PADDING_14),
                            child: Row(children: <Widget>[
                              addRadioButton(
                                  0,
                                  'Male',
                                      (value) =>
                                  {
                                    genderController.text = value
                                  }),
                              addRadioButton(
                                  1,
                                  'Female',
                                      (value) =>
                                  {
                                    genderController.text = value
                                  }),
                            ]),),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Address',
                              style: textTheme.bodyText2,
                            ),
                          ),
                          UsernameEditText(
                            addressController,
                            isValid:state.isAddressValid,

                            usernameType: UsernameType.address,
                            hint_text: 'Address',
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  /* editProfileController.fNameController.text =
                             user.first_name;
                         editProfileController.lNameController.text =
                             user.last_name;
                         editProfileController.emailController.text =
                             user.email;
                         editProfileController.genderController.text =
                             user.gender;
                         editProfileController.dobController.text =
                             user.dob;
                         editProfileController.addressController.text =
                             user.address;
                         editProfileController.mobileController.text =
                             user.phone;*/
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10.0),
                                    child: Text(CommonButtons.CANCEL)),
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                      width: 2.0,
                                      color: AppColors.primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10.0),
                                    child: Text(
                                      CommonButtons.Update,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.primaryColor),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              side: BorderSide(
                                                  color: AppColors
                                                      .primaryColor)))),
                                  onPressed: () {
                                    /*if (_formKey.currentState.validate()) {
                             if (select != null) {
                               print('select gender' + select);
                               editProfileController
                                   .genderController.text = select;
                             }
                             _formKey.currentState.save();
                             editProfileController.updateProfile();
                           }*/
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })
    );
  }

  Row addRadioButton(int btnValue, String title, Function onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
            activeColor: Theme
                .of(context)
                .primaryColor,
            value: gender[btnValue],
            groupValue: select != null
                ? select
                : genderController.text,
            onChanged: (value) {
              // print('select g'+value.toString());
              setState(() {
                print(value);
                select = value.toString();
              });
            }),
        Text(title)
      ],
    );
  }

}