import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/images.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    required this.title,
    this.hasLeading = true,
    this.hasTrailing = true,
    this.hasTitle = true,
     this.onActionTap,
    this.color = AppColors.white,
     this.trailing,
    this.leadingColor = AppColors.white,
    this.trailingColor = AppColors.white,
     this.leading,
     this.onLeadingTap,
  });

  final GestureTapCallback? onLeadingTap;
  final GestureTapCallback? onActionTap;
  final List<Widget>? trailing;
  final Widget? leading;
  final Color color;
  final Color leadingColor;
  final Color trailingColor;
  final bool hasLeading;
  final bool hasTrailing;
  final bool hasTitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AppBar(
      elevation: hasLeading ? 0.0 : 4.0,
      backgroundColor: color,
      leading: hasLeading ? (leading ?? defaultLeading()) : null,
      centerTitle: hasLeading ? false : true,
      title: hasTitle
          ? Text(
              title,
              style: theme.textTheme.subtitle1!.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w700,
              ),
            )
          : null,
      actions: hasTrailing ? (trailing ?? defaultTrailing()) : null,
    );
  }

  List<Widget> defaultTrailing() {
    return <Widget>[
      InkWell(
        onTap: onActionTap,
        child: Padding(
          padding: const EdgeInsets.only(right: Sizes.PADDING_16),
          child: SvgPicture.asset(
            ImagePath.BELL,
            color: trailingColor,
          ),
        ),
      )
    ];
  }

  Widget defaultLeading() {
    return InkWell(
      onTap: onLeadingTap,
      child: Padding(
          padding: const EdgeInsets.only(left: Sizes.PADDING_8),
          child: Container(
            alignment: Alignment.center,
            height: Sizes.ICON_SIZE_32,
            width: Sizes.ICON_SIZE_32,
            child: SvgPicture.asset(
              ImagePath.MENU,
              color: leadingColor,
            ),
          )),
    );
  }
}
