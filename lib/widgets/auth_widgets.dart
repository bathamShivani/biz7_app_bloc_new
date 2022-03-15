import 'package:biz_app_bloc/utility/borders.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:flutter/material.dart';

enum UsernameType { fname, lname, mobile, email, address }

class UsernameEditText extends StatelessWidget {
  UsernameEditText(
    this.editTextController, {
    Key? key,
    this.isValid,
    this.isReadOnly,
    required this.usernameType,
    required this.fieldTitle,
    required this.hint_text,
    this.isnum = false,
    required this.iconPrefix,
    this.hasPrefixIcon = false,
    this.hasPrefixText = false,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.red,
    this.enabledBorderColor = Colors.grey,
    this.enabledField = true,
    this.prefixText,this.onTap,
  }) : super(key: key);
  final TextEditingController editTextController;
  final bool? isValid;
  final bool isnum;
  final bool? isReadOnly;
  final UsernameType usernameType;
  final String hint_text;
  final IconData iconPrefix;
  final bool hasPrefixIcon;
  final bool hasPrefixText;
  final String? prefixText;
  final String fieldTitle;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final bool enabledField;
  final void Function()? onTap;

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
          margin:
              EdgeInsets.only(right: Sizes.PADDING_18, left: Sizes.PADDING_18),
          child:
              formFieldTitle(fieldTitle: fieldTitle, textStyle: titleTextStyle),
        ),
        TextFormField(
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
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: enabledBorderColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: focusedBorderColor,
              ),
            ),
            hintText: hint_text,
            hintStyle: formHintTextStyle,
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
                    ))
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
          ),

          controller: editTextController,
          autocorrect: false,
          keyboardType: isnum ? TextInputType.number : TextInputType.text,
          style: formHintTextStyle,
          readOnly: isReadOnly ?? false,
          // autofillHints: [AutofillHints.email],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTap: onTap,
          validator: (value) =>
              isValid! ? '' : _getInvalidMessage(context, usernameType),
        ),
       /* new Container(
          margin:
              EdgeInsets.only(right: Sizes.PADDING_16, left: Sizes.PADDING_16),
          child: Divider(
            height: 2,
            color: AppColors.greyShade6,
          ),
        )*/
      ],
    );
  }

  String _getInvalidMessage(BuildContext context, UsernameType type) {
    switch (type) {
      case UsernameType.mobile:
        return 'Enter valid mobile number';

      case UsernameType.fname:
        return 'Enter valid first name';

      case UsernameType.lname:
        return 'Enter valid last name';

      case UsernameType.email:
        return 'Enter valid email id';

      case UsernameType.address:
        return 'Enter valid address';

      default:
        return 'Enter mobile number';
    }
  }

  Widget formFieldTitle(
      {required String fieldTitle, required TextStyle textStyle}) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.MARGIN_4),
      child: Text(
        fieldTitle,
        style: textStyle,
      ),
    );
  }
}


class OtpEditText extends StatelessWidget {
  OtpEditText(
    this.editTextController, {
    Key? key,
    required this.isValid,
  }) : super(key: key);
  final TextEditingController editTextController;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: TextFormField(
        controller: editTextController,
        autocorrect: false,
        obscureText: true,
        style: textTheme.bodyText2,
        keyboardType: TextInputType.number,
        maxLength: 4,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => isValid ? null : 'Enter valid OTP.',
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          hintText: 'Enter OTP',
          hintStyle: textTheme.caption,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(width: 2, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
