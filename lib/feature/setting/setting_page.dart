import 'dart:ui';
import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/core/routes.dart';
import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/feature/home_navigation/cubit/homenavigation_cubit.dart';
import 'package:biz_app_bloc/utility/adaptive.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/shadows.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/spaces.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:biz_app_bloc/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

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
  SettingItem(
    title: StringConst.sentence.LOGOUT,
    textColor: AppColors.greyShade3,
    routeName: '',
  )
];

class SettingScreen extends AppScreen {
  SettingScreen(
      {RouteObserver<Route>? routeObserver, Key? key, Bundle? arguments})
      : super(routeObserver, key, arguments);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends AppScreenState<SettingScreen> {

  var isLoading = true;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final DataHelper _dataHelper = DataHelperImpl.instance;


  Future<void> _onLogout() async {
    await _dataHelper.cacheHelper.saveUserInfo('');
    navigateToScreenAndReplace(Screen.login);

  }

  @override
  bool onBackPressed() {
    //navigatePopUntil(Screen.home);
    // TODO: implement onBackPressed
    return super.onBackPressed();
  }
  @override
  Widget setView() {
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

          children: [
            BgCard(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.PADDING_8,
                vertical: Sizes.PADDING_8,
              ),
              borderColor: Colors.white,
              width: widthOfScreen,
              height: heightOfScreen,
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
                        onTap: ()  {
                          if (index == 0)
                            navigateToScreen(Screen.profile);

                          else
                            {_onLogout();}
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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



}

class DividerGrey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.grey,
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

