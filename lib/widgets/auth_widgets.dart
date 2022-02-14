import 'package:biz_app_bloc/utility/borders.dart';
import 'package:flutter/material.dart';


enum UsernameType {fname,lname, mobile, email,address}

class UsernameEditText extends StatelessWidget {
  UsernameEditText(
    this.editTextController, {
    Key? key,
    this.isValid,
    this.isReadOnly,
    this.borderRadius,
    required this.usernameType,
        required this.hint_text,
         this.isnum=false
  }) : super(key: key);
  final TextEditingController editTextController;
  final bool? isValid;
  final bool isnum;
  final bool? isReadOnly;
  final BorderRadius? borderRadius;
  final UsernameType usernameType;
  final String hint_text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: TextFormField(

        controller: editTextController,
        autocorrect: false,
        keyboardType:isnum?TextInputType.number:TextInputType.text,
        style: textTheme.bodyText2,
        readOnly: isReadOnly ?? false,
        // autofillHints: [AutofillHints.email],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            isValid! ? null : _getInvalidMessage(context, usernameType),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          hintText: hint_text,
          hintStyle: textTheme.caption,
        ),

      ),
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
}

/*
class PasswordEditText extends StatelessWidget {
  PasswordEditText(
    this.editTextController, {
    Key? key,
    this.isValid,
  }) : super(key: key);
  final TextEditingController editTextController;
  final bool? isValid;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: AutofillGroup(
        child: TextFormField(
          controller: editTextController,
          autocorrect: false,
          obscureText: true,
          style: textTheme.bodyText2,
          // autofillHints: [AutofillHints.password],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => isValid! ? null : l10n.invalidPassword,
          decoration: InputDecoration(
            // suffixIcon: IconButton(
            //     icon: const Icon(Icons.visibility), onPressed: () {}),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            hintText: l10n.password,
            hintStyle: textTheme.caption,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(width: 2, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
*/

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
