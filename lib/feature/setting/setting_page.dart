import 'dart:ui';
import 'package:biz_app_bloc/utility/adaptive.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/shadows.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/spaces.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:biz_app_bloc/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SettingItem {
  SettingItem({
    required this.title,
    required this.textColor,
    required this.routeName,
  });

  final String title;
  final Color textColor;
  final String routeName;
}

List<SettingItem> settingItems = [
  SettingItem(
    title: StringConst.sentence.PROFILE,
    textColor: AppColors.greyShade3,
    routeName: '',
  ),
  /*SettingItem(
    title: StringConst.sentence.FAQ,
    textColor: AppColors.greyShade3,
    routeName: '',
  ),*/
  SettingItem(
    title: StringConst.sentence.LOGOUT,
    textColor: AppColors.greyShade3,
    routeName: '',
  )
];

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // ProfileBloc _profileBloc;
  // DrawerBloc _drawerBloc;
  // FamilyMember member;
  // User user;
  var isLoading = true;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // asyncSharePref();
    // _profileBloc = getItInstance<ProfileBloc>();
    // _drawerBloc = getItInstance<DrawerBloc>();
    // _profileBloc.add(GetProfile());
  }

  void asyncSharePref() async {
    // await SharedPreferenceHelper.setUserPref(null);

    // member = await SharedPreferenceHelper.getFamilyPref();
    // user = await SharedPreferenceHelper.getUserPref();
    // print(member);
    // print(user);
    // if (member != null || user != null) {
    //   // print('member >>>>>>>>>>>>' + member.toString());
    //   print('user >>>>>>>>>>>>>' + user.toString());
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  void _openDrawer() {
    // scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
          child: CustomAppBar(
            title: StringConst.SETTING_SCREEN.toUpperCase(),
            hasLeading: false,
            hasTrailing: false,
          ),
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BgCard(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.PADDING_8,
                vertical: Sizes.PADDING_8,
              ),
              borderColor: Colors.white,
              width: widthOfScreen,
              height: heightOfScreen * 0.7,
              borderRadius: const BorderRadius.all(
                const Radius.circular(Sizes.RADIUS_10),
              ),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: settingItems.length,
                    itemBuilder: (context, index) {
                      SettingItem item = settingItems[index];
                      return InkWell(
                        onTap: () => {
                          if (index == 0)
                           // {Get.to(EditProfilePage())}
                          /*else if(index==1){
                            Get.to(FaqPage())
                          }*/
                         // else
                            {_onLogout()}
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                    top: Sizes.PADDING_4,
                                    left: Sizes.PADDING_4,
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: Sizes.PADDING_10),
                                    title: new Text(item.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w800)),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: Sizes.ICON_SIZE_16,
                                      color: AppColors.secodaryText,
                                    ),
                                  )),
                              DividerGrey()
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SpaceH16()
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _onLogout() async {
    //await SharedPreferenceHelper.setUserPref(null);

   // Get.to(LoginPage());
  }
}

class DividerGrey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.grey,
      // height: ,
    );
  }
}
class BgCard extends StatelessWidget {
  BgCard({
    required this.borderColor,
    this.width = Sizes.WIDTH_60,
    this.height = Sizes.HEIGHT_60,
    this.borderWidth = 0.5,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Sizes.PADDING_16,
      vertical: Sizes.PADDING_16,
    ),
    this.backgroundColor = AppColors.white,
    this.borderRadius = const BorderRadius.all(
      const Radius.circular(Sizes.RADIUS_4),
    ),
    this.shadow = Shadows.bgCardShadow,
    this.gradient,
    this.child,
  });
  final Color borderColor;
  final double width;
  final double height;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;
  final BoxShadow shadow;
  final Widget? child;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        gradient: this.gradient,
        border: Border.all(
            color: borderColor != null ? borderColor : AppColors.white,
            width: borderWidth),
        color: this.backgroundColor,
        borderRadius: borderRadius,
        boxShadow: [shadow],
      ),
      child: child ?? Container(),
    );
  }
}

