
import 'package:biz_app_bloc/core/exceptions/custom_exception.dart';
import 'package:biz_app_bloc/data/api/api_client.dart';
import 'package:biz_app_bloc/model/Login.dart';
import 'package:dartz/dartz.dart';



//const buildApiEnvironment = ApiEnvironment.development;

class ApiEndPoints {

  static const String BASE_URL = "https://biz7.app/";
  static const String API_KEY = "";
  static const String BASE_IMAGE_URL = "https://biz7.app/assets/news_images/";
  // Login API Url
  static final String loginUrl = 'api-login-otp';

}

abstract class ApiHelper {
  Future<Either<CustomException, Login>> executeLogin(String mobile);

  executeVerifyOtp(String email, String otp) {}
  /*Future<Either<CustomException, SubjectAnalysis>> executeSubjectAnalysis(
      TestDetailsRequest request);
  Future<Either<CustomException, SubjectAnalysisComp>>
      executeSubjectAnalysisComp(TestDetailsRequest request);
  Future<Either<CustomException, ResultDetails>> executeResultDetails(
      TestDetailsRequest request);
  Future<Either<CustomException, RankDetails>> executeRankCompDetails(
      TestDetailsRequest request);
  Future<Either<CustomException, DailyMcq>> executeDailyCourseMcq(String slug);
  Future<Either<CustomException, GetRanks>> executeRankDetails(
      String testId, int lessonPlanId, int courseBatchId);
  Future<Either<CustomException, GetRanks>> executeEventRankDetails(
      String testId, int eventId, int eventQuizId);
  Future<Either<CustomException, PreQuizDetails>> executePreQuizDetails(
      PreQuizDetailRequest request);
  Future<Either<CustomException, PaymentModel>> executeCashFreePayment(
      PaymentRequest request);
  Future<Either<CustomException, PostComments>> executePostComments(
      PostCommentsRequest request);
  Future<Either<CustomException, testDetails.TestDetails>> executeTestDetails(
      TestDetailsRequest request);
  Future<Either<CustomException, testDetails.TestDetails>>
      executeTestDetailsForEvent(TestDetailsRequestForEvent request);
  Future<Either<CustomException, String>> executeReportComments(
      ReportCommentRequest request);
  Future<Either<CustomException, SendOtpResponse>> executeSendOtp(
      String mobileNumber);
  Future<Either<CustomException, Login>> executeVerifyOtp(
      String mobileNumber, String otp);
  Future<Either<CustomException, String>> executeGetInTouchVerifyOtp(
      String mobileNumber, String otp);
  Future<Either<CustomException, String>> executeGetInTouchForLoggedUsers(
      String mobileNumber);
  Future<Either<CustomException, void>> executedownloadForNewCourse(
      String url, String path);
  Future<Either<CustomException, SendOtpResponse>> executeSendOtpRegister(
      String mobileNumber);
  Future<Either<CustomException, SendOtpResponse>> executeResendOtp(
      String mobileNumber);
  Future<Either<CustomException, SendOtpResponse>> executeSendOtpForEnquiry(
      String mobileNumber);
  Future<Either<CustomException, Login>> executeVerifyOtpRegister(
      String mobileNumber, String otp);
  Future<Either<CustomException, String>> executeSignUp(SignUpRequest request);
  Future<Either<CustomException, String>> executeForgotPassword(
      ForgotPasswordRequest request);
  Future<Either<CustomException, Login>> executeSocialLogin(
      SocialLoginRequest request);
  Future<Either<CustomException, User>> executeUserDetails();
  Future<Either<CustomException, courses.Courses>> executeCourses(
      CourseRequest request);
  Future<Either<CustomException, CouresType>> executeCoursesTypeList();
  Future<Either<CustomException, CourseCategorys>>
      executeCoursesSubCategoryList(String slug);
  Future<Either<CustomException, courses.Courses>> executeExploreCourses();
  Future<Either<CustomException, MyCourses>> executeMyCourses();
  Future<Either<CustomException, CourseLiveClass>> executeMyCoursesLiveClass();
  Future<Either<CustomException, Overview_model>> executeOverView(
      OverviewRequest request);
  Future<Either<CustomException, String>> executeRemoveCoupon(String coupon);
  Future<Either<CustomException, Announcement_model>> executeAnnouncements(
      OverviewRequest request);
  Future<Either<CustomException, QuestionModel>> executeQuestions(
      QARequestFilter request);
  Future<Either<CustomException, QuestionModel>> executeAnswers(
      OverviewRequest request);
  Future<Either<CustomException, AttemptQuizModel>> executeAttemptQuiz(
      AttemptQuizRequest request);
  Future<Either<CustomException, McqModel>> executeQuiz(
      OverviewRequest request);
  Future<Either<CustomException, LikeQuestionModel>> executeLikeAnswer(
      LikeAnswerRequest request);
  Future<Either<CustomException, LikeQuestionModel>> executeLikeQuestion(
      LikeQuestionRequest request);
  Future<Either<CustomException, NewsLetter>> executeNewsLetter();
  Future<Either<CustomException, NewsFeed>> executeNewsFeed(
      FeedsRequest request);
  Future<Either<CustomException, NewsFeed>> executeNewsFeedSearch(
      String search);
  Future<Either<CustomException, NewsFeed>> executeNewsFeedBookmarks(int page);
  Future<Either<CustomException, NewsLetterDetail>> executeNewsLetterDetail(
      NewsLetterDetailRequest request);
  Future<Either<CustomException, NewsFeedDetail>> executeNewsFeedDetail(
      NewsFeedDetailRequest request);
  Future<Either<CustomException, List>> executeSubmitQuizAnswer(
      SubmitQuizRequest request);
  Future<Either<CustomException, String>> executeAddToCart(
      AddToCartRequest request);
  Future<Either<CustomException, String>> executePostQuestion(
      PostQuestionRequest request);
  Future<Either<CustomException, String>> executePostAnswer(
      PostAnswerRequest request);
  Future<Either<CustomException, Cart>> executeCartDetails();
  Future<Either<CustomException, String>> executeDeleteCartItem(
      AddToCartRequest request);
  Future<Either<CustomException, String>> executeApplyCoupon(String coupon);
  Future<Either<CustomException, CourseDetails>> executeCourseDetails(
      AddToCartRequest request);
  Future<Either<CustomException, NewCourseDetails>> executeNewCourseDetails(
      String courseCode);
  Future<Either<CustomException, NewAllCourseDesc>> executeNewAllCourseDesc(
      String courseCode);
  Future<Either<CustomException, CourseTestimonials>>
      executeNewAllCourseTestimonialCourse(String courseCode);
  Future<Either<CustomException, RelatedCourses>>
      executeNewAllCourseRelativeCourse(String courseCode);
  Future<Either<CustomException, UpscRelatedCourse>>
      executeNewAllCourseUpscRelativeCourse(String courseCode);
  Future<Either<CustomException, FaqForAllCourse>> executeNewAllCourseFaq(
      String courseCode);
  Future<Either<CustomException, NewCourseBatch>> executeNewCourseBatch(
      String courseCode);
  Future<Either<CustomException, NewCourseFaq>> executeNewCourseFaq(
      String courseCode);
  Future<Either<CustomException, NewCourseFaculty>> executeNewCourseFaculty(
      String courseCode);
  Future<Either<CustomException, String>> executeAddTocartNewCourse(
      String courseId, String courseBatch);
  Future<Either<CustomException, NewCourseSchedule>> executeNewCourseSchedule(
      String courseCode);
  Future<Either<CustomException, NewCourseScheduleBuyedUsers>>
      executeNewCourseScheduleForBuyers(String courseCode);
  Future<Either<CustomException, NewCourseHighlights>>
      executeNewCourseHighlights(String courseCode);
  Future<Either<CustomException, UserAddress>> executeUserAddress();
  Future<Either<CustomException, States>> executeAddressState();
  Future<Either<CustomException, City>> executeAddressCity(int stateId);
  Future<Either<CustomException, String>> executeDeleteAddress(int addressId);
  Future<Either<CustomException, String>> executeAddAddress(
      AddAddressRequest request);
  Future<Either<CustomException, String>> executeSetDefaultAddress(
      DefaultAddressRequest request);
  Future<Either<CustomException, PaymentCheckoutResponse>>
      executePaymentCheckout(PaymentCheckoutRequest request);
  Future<Either<CustomException, CoursesFilter>> executeCourseFilter();
  Future<Either<CustomException, LmsCourseDetail>> executeLmsCourseDetail(
      String courseSlug);
  Future<Either<CustomException, Notesmodel>> executeNotes(
      GetNotesRequest request);
  Future<Either<CustomException, Notesmodel>> executeCurrentNotes(
      GetCurrentNotesRequest request);
  Future<Either<CustomException, List>> executePostNotes(
      PostNotesRequest request);
  Future<Either<CustomException, String>> executeMarkCourseClass(
      int courseId, int courseClassId);
  Future<Either<CustomException, String>> executeDemarkCourseClass(
      int courseId, int courseClassId);
  Future<Either<CustomException, KorrectoSubmitResponse>>
      executeKorrectoSubmitAnswer(FormData data);
  Future<Either<CustomException, KorrectoSubmitResponse>>
      executeKorrectoBookletSubmitAnswer(FormData data);
  Future<Either<CustomException, String>> executeLmsVideoContent(int contentId);
  Future<Either<CustomException, int>> executeFeedLike(int feedId);
  Future<Either<CustomException, String>> executeFeedBookmark(int feedId);
  Future<Either<CustomException, SearchRecentPopular>>
      executeFeedSearchRecentPopular();
  Future<Either<CustomException, VideoContent>> executeVideoContent(
      int contentId);
  Future<Either<CustomException, QuizSheet>> executePopulateQuiz(
      String testId, int lessonPlanId, int courseBatchId);
  Future<Either<CustomException, QuizSheet>> executePopulateQuizForEvent(
      String testId, int eventId, int eventQuizId);
  Future<Either<CustomException, dynamic>> executeSubmitQuestion(
      SubmitQuestion request);
  Future<Either<CustomException, dynamic>> executeOpenQuestion(
      OpenQuestion request);
  Future<Either<CustomException, dynamic>> executeClearAnswer(
      ClearAnswerRequest request);
  Future<Either<CustomException, dynamic>> executeFlagQuestion(
      ClearAnswerRequest request);
  Future<Either<CustomException, dynamic>> executeExitAbruptly(
      ClearAnswerRequest request);
  Future<Either<CustomException, dynamic>> executeLiveBeat(
      ClearAnswerRequest request);
  Future<Either<CustomException, dynamic>> executeSubmitSection(
      String sectionId, int testResultId);
  Future<Either<CustomException, dynamic>> executeSubmitTest(
      String testId, int testResultId);
  Future<Either<CustomException, dynamic>> executeTrialOrder(
      TrialOrderRequest request);
  Future<Either<CustomException, TrialCourses>> executeMyTrialCourses();
  Future<Either<CustomException, ClassCompleteDetails>>
      executeClassCompleteDetails(ClassCompleteDetailsRequest request);
  Future<Either<CustomException, CourseCategoryTags>> executeCourseTags();
  Future<Either<CustomException, DailyQuote>> executeDailyQuote();
  Future<Either<CustomException, EventsList>> executeEventsList();
  Future<Either<CustomException, EventTestDetails>> executeEventTestDetails(
      int testid, int eventid, int eventquizid);
  Future<Either<CustomException, String>> executeRecordDownload(int id);*/
}

class ApiHelperImpl extends ApiHelper {
  ApiHelperImpl(this._api);
  final ApiClient _api;

  @override
  Future<Either<CustomException, Login>> executeLogin(String mobile) async {
    print('mobile>>'+mobile);
    try {
      final response =
      await _api.post( ApiEndPoints.loginUrl, {
        'phone': mobile,
        'device_id': "abc123",
        'let': "11.222",
        'lng': "11.333"
      });
      return Right(Login.fromJson(response));
    } on CustomException catch (e) {
      return Left(e);
    }
  }
}
