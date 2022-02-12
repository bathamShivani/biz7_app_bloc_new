
part of 'home_page_cubit.dart';

@immutable
class HomePageState extends Equatable {
  //category
  final List<Data> category;
  final bool isCategoryFailure;
  final bool isCategoryLoading;

  //news
  final List<News> news;
  final bool isNewsFailure;
  final bool isNewsLoading;

  String errorMessage;

  HomePageState({
    required this.category,
    required this.news,
    this.isCategoryFailure = false,
    this.isNewsFailure = false,
    this.isCategoryLoading = true,
    this.isNewsLoading = true,
    this.errorMessage = '',
  });
  @override
  List<Object> get props {
    return [
      category,
      isCategoryFailure,
      isCategoryLoading,
      errorMessage,
      news,isNewsLoading,isNewsFailure

    ];
  }

  HomePageState copyWith(
      {List<Data>? category,
        String? errorMessage,
        bool? isCategoryFailure,
        bool? isCategoryLoading,

        List<News>? news,
        bool? isNewsLoading,
        bool? isNewsFailure,
       }) {
    return HomePageState(
        category: category ?? this.category,
        errorMessage: errorMessage ?? this.errorMessage,
        isCategoryLoading: isCategoryLoading??this.isCategoryLoading,
        isCategoryFailure: isCategoryFailure??this.isCategoryFailure,
        news: news ?? this.news,
        isNewsLoading: isNewsLoading??this.isNewsLoading,
        isNewsFailure: isNewsFailure??this.isNewsFailure,

    );
  }

  @override
  bool get stringify => true;
}
