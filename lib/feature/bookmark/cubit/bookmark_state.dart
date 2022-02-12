
part of 'bookmark_cubit.dart';

@immutable
class BookmarkState extends Equatable {


  //news
  final List<Datum> news;
  final bool isNewsFailure;
  final bool isNewsLoading;
  final bool isErrorMessage;

  String errorMessage;

  BookmarkState({
    required this.news,
    this.isNewsFailure = false,
    this.isNewsLoading = true,
    this.isErrorMessage = false,
    this.errorMessage = '',
  });
  @override
  List<Object> get props {
    return [

      errorMessage,
      news,isNewsLoading,isNewsFailure,isErrorMessage

    ];
  }

  BookmarkState copyWith(
      {
        String? errorMessage,

        List<Datum>? news,
        bool? isNewsLoading,
        bool? isNewsFailure,
        bool? isErrorMessage,
      }) {
    return BookmarkState(
      errorMessage: errorMessage ?? this.errorMessage,
      news: news ?? this.news,
      isNewsLoading: isNewsLoading??this.isNewsLoading,
      isNewsFailure: isNewsFailure??this.isNewsFailure,
      isErrorMessage: isErrorMessage??this.isErrorMessage,

    );
  }

  @override
  bool get stringify => true;
}
