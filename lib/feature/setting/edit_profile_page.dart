import 'dart:io';

import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/core/routes.dart';
import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/feature/setting/cubit/edit_profile_bloc.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/form_validator.dart';
import 'package:biz_app_bloc/utility/images.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/spaces.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:biz_app_bloc/widgets/auth_widgets.dart';
import 'package:biz_app_bloc/widgets/custom_appbar.dart';
import 'package:biz_app_bloc/widgets/form_input_field_with_icon.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter/src/widgets/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:biz_app_bloc/model/User.dart' as info;
import 'package:image_picker/image_picker.dart';

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
  TextEditingController dobController = TextEditingController();

  List gender = ["Male", "Female", "Other"];
  var select;
  late EditPageBloc editPageBloc;
  var result;
  ImagePicker imagePicker = ImagePicker();
  File? _image;
  String profile_image = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    editPageBloc = BlocProvider.of<EditPageBloc>(context);
    fnameController.addListener(_onfNameChanged);
    lnameController.addListener(_onlNameChanged);
    emailController.addListener(_onEmailChanged);
    mobileController.addListener(_onMobileChanged);
    //addressController.addListener(_onAddressChanged);
    getUserInfo();
  }

  void getUserInfo() async {
    final DataHelper _dataHelper = DataHelperImpl.instance;
    result = info.userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    mobileController.text = result.data.phone;
    fnameController.text = result.data.firstName;
    lnameController.text = result.data.lastName;
    emailController.text = result.data.email;
    dobController.text = result.data.dob;
    addressController.text = result.data.address;
    genderController.text = result.data.gender;
    profile_image = result.data.profileImage;
    select = result.data.gender;
  }

  void _onfNameChanged() {
    editPageBloc.add(NameChanged(fnameController.text));
  }

  void _onlNameChanged() {
    editPageBloc.add(LastNameChanged(lnameController.text));
  }

  void _onAddressChanged() {
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
              onTap: () {
                navigateToBack();
              },
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
            navigateToScreenAndReplace(Screen.home);
          }
          if (state.isFailure!) {
            ScaffoldMessenger.of(globalKey.currentContext!)
                .showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: kSpacingUnit * 3),
                    child: Stack(children: <Widget>[
                      (_image != null)
                          ? CircleAvatar(
                              radius: kSpacingUnit * 5,

                              backgroundColor:
                                  _image != null ? Colors.green : Colors.red,
                              backgroundImage: new FileImage(_image!))
                          : CircularProfileAvatar(
                              profile_image != null && profile_image != ""
                                  ? '${StringConst.BASE_URL}' + profile_image
                                  : '',
                              radius: kSpacingUnit * 5,
                              // sets radius, default 50.0
                              backgroundColor: Colors.white,
                              // sets background color, default Colors.white
                              borderWidth: 1,

                              placeHolder: (context, url) => Container(
                                width: 50,
                                height: 50,
                                child: Image.asset(ImagePath.PLACEHOLDER),
                              ),
                              errorWidget: (context, url, errror) =>
                                  Image.asset(ImagePath.profile),

                              borderColor: profile_image != null
                                  ? Colors.red
                                  : Colors.green,
                              elevation: 4.0,
                              foregroundColor: AppColors.white.withOpacity(0.5),
                              cacheImage: true,
                              showInitialTextAbovePicture: false,
                            ),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            _pickImage();
                          },
                          child: Container(
                            height: kSpacingUnit * 3.0,
                            width: kSpacingUnit * 3.0,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Sizes.PADDING_10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SpaceH8(),
                      UsernameEditText(
                        fnameController,
                        isValid: state.isfNameValid,
                        usernameType: UsernameType.fname,
                        hint_text: 'First Name',
                        iconPrefix: Icons.person_outline,
                        fieldTitle: StringConst.label.FNAME,
                        hasPrefixIcon: true,
                      ),
                      SpaceH8(),
                      UsernameEditText(
                        lnameController,
                        isValid: state.islNameValid,
                        iconPrefix: Icons.person_outline,
                        fieldTitle: StringConst.label.LNAME,
                        hasPrefixIcon: true,
                        usernameType: UsernameType.lname,
                        hint_text: StringConst.label.LNAME,
                      ),
                      SpaceH8(),
                      UsernameEditText(
                        mobileController,
                        isValid: state.isNumberValid,
                        iconPrefix: Icons.phone_android_rounded,
                        hasPrefixIcon: true,
                        fieldTitle: StringConst.label.MOBILE_NO,
                        usernameType: UsernameType.mobile,
                        hint_text: 'Mobile Number',
                        isnum: true,
                      ),
                      SpaceH8(),
                      UsernameEditText(
                        emailController,
                        isValid: state.isEmailValid,
                        iconPrefix: Icons.email,
                        fieldTitle: StringConst.label.EMAIL,
                        hasPrefixIcon: true,
                        usernameType: UsernameType.email,
                        hint_text: 'Email Id',
                      ),
                      SpaceH8(),
                      UsernameEditText(
                        dobController,
                        iconPrefix: Icons.calendar_today_outlined,
                        hasPrefixText: true,
                        fieldTitle: StringConst.label.BOD,
                        hasPrefixIcon: true,
                        isReadOnly: true,
                        isValid: true,
                        hint_text: 'Date of birth',
                        usernameType: UsernameType.address,
                        onTap: () async {
                          await showDatePicker(
                                  context: context,
                                  initialDate: new DateTime(2001),
                                  firstDate: new DateTime(1900),
                                  lastDate: new DateTime(2100))
                              .then((value) {
                            dobController.text =
                                value.toString().substring(0, 10);
                          });
                        },
                      ),
                      SpaceH8(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Gender',
                          style: textTheme.bodyText2,
                        ),
                      ),
                      new Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: Sizes.PADDING_14),
                        child: Row(children: <Widget>[
                          addRadioButton(0, 'Male',
                              (value) => {genderController.text = value}),
                          addRadioButton(1, 'Female',
                              (value) => {genderController.text = value}),
                        ]),
                      ),
                      SpaceH8(),
                      UsernameEditText(
                        addressController,
                        isValid: true,
                        iconPrefix: Icons.card_membership_outlined,
                        hasPrefixIcon: true,
                        fieldTitle: StringConst.label.ADDRESS,
                        usernameType: UsernameType.address,
                        hint_text: 'Address',
                      ),
                      SpaceH8(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 10.0),
                                child: Text(CommonButtons.CANCEL)),
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  width: 2.0, color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          ),
                          !state.isSubmitting!
                              ? ElevatedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10.0),
                                    child: Text(
                                      CommonButtons.Update,
                                      style: Theme.of(context)
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
                                                  color: AppColors.primaryColor)))),
                                  onPressed: () {
                                    if (select != null) {
                                      print('select gender' + select);
                                      genderController.text = select;
                                      editPageBloc.updateProfile(
                                          fnameController.text,
                                          lnameController.text,
                                          dobController.text,
                                          genderController.text,
                                          emailController.text,
                                          addressController.text);
                                    } else {
                                      ScaffoldMessenger.of(
                                              globalKey.currentContext!)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Please select gender')));
                                    }
                                  })
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }

  Row addRadioButton(int btnValue, String title, Function onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
            activeColor: Theme.of(context).primaryColor,
            value: gender[btnValue],
            groupValue: select != null ? select : genderController.text,
            onChanged: (value) {
              setState(() {
                print(value);
                select = value.toString();
              });
            }),
        Text(title)
      ],
    );
  }

  getImageGallery() async {
    Navigator.pop(context);
    var file =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(file!.path);
    });
    if (_image != null) {
      setState(() {
        editPageBloc.updateProfilePic(_image!);
      });
    }
  }

  getImageCamera() async {
    Navigator.pop(context);
    var file = await ImagePicker.platform.pickImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 60);
    setState(() {
      _image = File(file!.path);
    });
    if (_image != null) {
      setState(() {
        editPageBloc.updateProfilePic(_image!);
      });
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 150,
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.camera,
                        color: Colors.grey,
                      ),
                      title: new Text(
                        "Camera",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () => {getImageCamera()}),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo,
                      color: Colors.grey,
                    ),
                    title: new Text(
                      "Gallery",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () => {getImageGallery()},
                  ),
                ],
              ),
            ),
          );
        });
  }

  _pickImage() async {
    _settingModalBottomSheet(context);
  }
}
