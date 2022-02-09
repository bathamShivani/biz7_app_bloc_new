
class StringConst {
  // API STRINGS
  static const String BASE_URL = "http://news.apoliums.com/";

  static LABEL label = const LABEL();
  static SENTENCE sentence = const SENTENCE();
  static CommonButtons commonButtons = const CommonButtons();

  //strings
  static const String APP_NAME = "Biz App";

  // screen
  static const String HOME = "Home";

  //bottom tabs
  static const String BROWSE = "Browse";
  static const String SETTING = "Settings";
  static const String BOOKMARK = "Bookmark";
  static const String PROFILE_SCREEN = "Profile";
  static const String SETTING_SCREEN = "Settings";
  static const String FAQ_SCREEN = "FAQ";
// static const String VIEW_REPORT = "View Report";
// static const String VIEW_INVOICE = "Invoice";
// static const String VIEW = "View";
// static const String Prescription = "Prescription";
}

class SENTENCE {
  const SENTENCE();
  String get PROFILE => "Profile";
  String get LOGOUT => "Logout";
  String get FAQ => "Faq";
  String get Search => "Search ";
  //String get TAG_LINE => 'discover stories that matter.';
  String get TAG_LINE => 'ECONOMIC TINY BRINGING BUSINESS SUCCESS';
  //String get SIGNIN_TITLE => 'The community that sparks charges';
  String get SIGNIN_TITLE => 'TINY THAT BRING CHANGE';
  String get WELCOME => 'Welcome to';
  String get SIGNIN_BOTTOM => 'Don\'t have an account?';
  String get Request_ACCESS => 'Request for access';
  String get Resend_Now => 'Resend Now';

  String get UPLOAD_FAILED => 'Upload failed. Try later.';
  String get APPOINTMENT_FAILED => 'Appointment failed. Try later.';
  String get LOG_IN => 'Login';
  String get FORGOT_PASSWORD => 'Forgot Password ?';
  String get FORGOT_PASSWORD_LABEL => 'Forgot Password';
  String get FACEBOOK => 'Facebook';
  String get GOOGLE => 'Google';
  String get NEW_HERE => 'New here ? ';
  String get CREATE_ACCOUNT => 'Create account';
  String get GYR => 'Get yourself registered';
  String get MAO => 'Member access only';

  String get ENTER_CODE => 'Enter code';
  String get OTP_CODE => '******';
  String get NEXT_LINE => '\n';
  String get DNRC => 'Did not receive the code? ';
  String get OTP_CODE_DESC =>
      'We have sent you an SMS on your mobile number with 4 digit verification code';
  String get NO_UP_APPOINTMETS =>
      'You have no sheduled appointments. Book one ?';
  String get NO_REQ_APPOINTMETS =>
      'You have no request appointments. Book one ?';
  String get NO_PAST_APPOINTMETS => 'You have no past appointments.';
  String get No_Immunization => 'No Immunization';

  String get NO_UP_SERVICES => 'You have no sheduled services. Book one ?';
  String get NO_REQ_SERVICES => 'You have no request services. Book one ?';
  String get NO_PAST_SERVICES => 'You have no past services.';

  String get INVALID_EMAIL => 'Please enter valid email';
  String get EMPTY_EMAIL => 'Please enter email';

  String get EMPTY_OTP => 'Please enter otp';
  String get EMPTY_PASSWORD => 'Please enter password';
  String get LOGIN_FAILED => 'Login Failed';
  String get SIGNUP_FAILED => 'Signup Failed';
  String get EMPTY_MOBILE => 'Please enter mobile number';
  String get EMPTY_NAME => 'Please enter name';
  String get EMPTY_FILED => 'Please enter all field.';
  String get ERROR_MESSAGE => 'Some Error occured';
}

class LABEL {
  const LABEL();

  String get MOBILE_NO => 'MOBILE NUMBER';
  String get H_MOBILE_NO => 'XXX-XXX-XX-XX';
  String get P_MOBILE_NO => 'IN +91';
  String get OTP => 'OTP';
  String get FNAME => 'FIRST NAME';
  String get LNAME => 'LAST NAME';
  String get MOBILE => 'MOBILE';
  String get EMAIL => 'EMAIL';
  String get BOD => 'BIRTHDAY';
  String get GENDER => 'GENDER';
  String get ADDRESS => 'ADDRESS';
}

class CommonButtons {
  const CommonButtons();

  // common buttons
  static const String Update = "Update";
  static const String Cancel = "Cancel";
  static const String Send_OTP = "Send OTP";
  static const String Sign_in = "Sign in";
  static const String RETRY = "Retry";
  static const String SAVE = "Save";
  static const String UPDATE = "Update";
  static const String DELETE = "Delete";
  // startup
  static const String NEXT = "Next";
  static const String CANCEL = "Cancel";
  static const String FINISH = "Finish";
  // welcome
  static const String LOGIN = "Login";
  static const String SIGNUP = "Sign up";
  //user type
  static const String USER = "User";

  static const String CONTINUE = "Continue";
}
