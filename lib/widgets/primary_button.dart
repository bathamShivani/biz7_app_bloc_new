
import 'package:biz_app_bloc/utility/borders.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/spaces.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isLoading;
   Color backgroundColor;

   PrimaryButton({
    Key? key,
    required this.title,
     required this.backgroundColor,
    this.isLoading = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CustomButton(
        color:
            backgroundColor != null ? backgroundColor : AppColors.primaryColor,
        height: Sizes.HEIGHT_50,
        borderRadius: Sizes.RADIUS_24,
        textStyle: theme.textTheme.subtitle1!.copyWith(
          color: AppColors.white,
        ),
        onPressed: onPressed,
        hasIcon: true,
        icon: isLoading
            ? CircularProgressIndicator(
                backgroundColor: AppColors.white,
                strokeWidth: 2.0,
              )
            : Icon(
                Icons.arrow_forward,
                color: AppColors.white,
              ),
        title: title);
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.title,
    required this.onPressed,
    this.height = Sizes.HEIGHT_56,
    this.elevation = Sizes.ELEVATION_1,
    this.borderRadius = Sizes.RADIUS_24,
    this.color = AppColors.blackShade5,
    this.borderSide = Borders.defaultPrimaryBorder,
    required this.textStyle,
    required this.icon,
    this.hasIcon = false,
  });

  final VoidCallback onPressed;
  final double height;
  final double elevation;
  final double borderRadius;
  final String title;
  final Color color;
  final BorderSide borderSide;
  final TextStyle textStyle;
  final Widget icon;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: borderSide,
      ),
      height: height,
      color: color,
      child: Row(
        mainAxisAlignment:
            hasIcon ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
        children: <Widget>[
          title != null
              ? Text(
                  title,
                  style: textStyle,
                )
              : Container(),
          hasIcon ? SpaceW48() : Container(),
          hasIcon ? icon : Container(),
        ],
      ),
    );
  }
}
