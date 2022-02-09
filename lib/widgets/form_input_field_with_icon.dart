import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon(
      {required this.controller,
      required this.iconPrefix,
      this.suffixIcon,
      required this.labelText,
      required this.fieldTitle,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.hasSuffixIcon = false,
      this.hasPrefixIcon = false,
      required this.hasPrefixText,
      this.prefixText,
      this.minLines = 1,
      this.maxLines,
      this.borderColor = Colors.transparent,
      this.focusedBorderColor = Colors.transparent,
      this.enabledBorderColor = Colors.transparent,
      this.enabledField = true,
      this.borderRadius = Sizes.RADIUS_6,
      this.readOnly = false,
      // this.initialValue = '',
      this.onTap,
      required this.onChanged,
      required this.onSaved});

  final TextEditingController controller;
  final IconData iconPrefix;
  final IconData? suffixIcon;
  final String labelText;
  final String fieldTitle;
  final String Function(String?) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool hasSuffixIcon;
  final bool hasPrefixIcon;
  final bool hasPrefixText;
  final String? prefixText;
  final int? minLines;
  final int? maxLines;
  final Color borderColor;
  final double borderRadius;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final bool enabledField;
  final bool readOnly;

  final void Function(String) onChanged;
  final void Function()? onTap;
  final void Function(String?) onSaved;
  // final String initialValue;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    TextStyle titleTextStyle = theme.textTheme.caption!;
    TextStyle formHintTextStyle = theme.textTheme.bodyText2!.copyWith(
      color: AppColors.grey,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Container(
    margin: EdgeInsets.only(
        right: Sizes.PADDING_18, left: Sizes.PADDING_18),child: formFieldTitle(fieldTitle: fieldTitle, textStyle: titleTextStyle),

    ), TextFormField(
            // initialValue: initialValue,
            enabled: enabledField,
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: enabledBorderColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: focusedBorderColor,
                ),
              ),
              suffixIcon: hasSuffixIcon ? Icon(suffixIcon) : null,
              prefixIcon: hasPrefixIcon
                  ? Padding(
                      padding: EdgeInsets.only(
                          right: Sizes.PADDING_0, left: Sizes.PADDING_0),
                      child: Container(
                            alignment: Alignment.center,
                            height: Sizes.ICON_SIZE_16,
                            width: Sizes.ICON_SIZE_16,
                            child: Icon(
                              iconPrefix,
                              color: AppColors.secodaryText,
                              size: Sizes.ICON_SIZE_20,
                              // color: prefixIconColor,
                              // height: prefixIconHeight,
                            ),
                          ) ??
                          Container(),
                    )
                  : hasPrefixText
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: Sizes.PADDING_16,
                              bottom: Sizes.PADDING_16,
                              right: Sizes.PADDING_16),
                          child: Text(
                            prefixText!,
                          ))
                      : null,
              // hintText: hintText,
              hintStyle: formHintTextStyle,
              // filled: filled,
              // fillColor: fillColor,
              // errorText: errorText,
            ),
            controller: controller,
            onSaved: onSaved,
            onChanged: onChanged,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            minLines: minLines,
            validator: validator,
            onTap: onTap,
            readOnly: readOnly),
        new Container(
          margin: EdgeInsets.only(
        right: Sizes.PADDING_16, left: Sizes.PADDING_16),child:  Divider(height: 2,color: AppColors.greyShade6,),)

      ],
    );
  }

  Widget formFieldTitle({required String fieldTitle, required TextStyle textStyle}) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.MARGIN_4),
      child: Text(
        fieldTitle,
        style: textStyle,
      ),
    );
  }
}
