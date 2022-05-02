
part of 'home_page_cubit.dart';

@immutable
class HomePageState extends Equatable {
  //category
  final List<Data> category;
  final bool isCategoryFailure;
  final bool isCategoryLoading;

  //news
  final List<Datum> news;
  final bool isNewsFailure;
  final bool isNewsLoading,isReloading;
 int page=0;
  String errorMessage;
  String searchText;
  int selectedCatId;
  final bool isAdverFailure;
  final bool isAdverLoading;
  List<AdvertismentList> adverlist;
  HomePageState({
    required this.category,
    required this.news,
    this.isCategoryFailure = false,
    this.isNewsFailure = false,
    this.isCategoryLoading = true,
    this.isNewsLoading = true,
    this.errorMessage = '',
    this.page=0,
    this.searchText="",
    this.isReloading=true,
    this.selectedCatId=1,
    this.isAdverFailure = false,
    this.isAdverLoading = true,
    required this.adverlist,
  });
  @override
  List<Object> get props {
    return [
      category,
      isCategoryFailure,
      isCategoryLoading,
      errorMessage,
      news,isNewsLoading,isNewsFailure,page,searchText,  isReloading,selectedCatId,isAdverFailure,isAdverLoading,adverlist

    ];
  }

  HomePageState copyWith(
      {List<Data>? category,
        String? errorMessage,
        bool? isCategoryFailure,
        bool? isCategoryLoading,
        List<Datum>? news,
        bool? isNewsLoading,
        bool? isNewsFailure,
        bool? isReloading,
        int? page,
        String? searchText,
        int?selectedCatId,
        bool? isAdverFailure,
        bool? isAdverLoading,
        List<AdvertismentList>? adverlist,
       }) {
    return HomePageState(
        category: category ?? this.category,
        errorMessage: errorMessage ?? this.errorMessage,
        isCategoryLoading: isCategoryLoading??this.isCategoryLoading,
        isCategoryFailure: isCategoryFailure??this.isCategoryFailure,
        news: news ?? this.news,
        isNewsLoading: isNewsLoading??this.isNewsLoading,
        isNewsFailure: isNewsFailure??this.isNewsFailure,
      isReloading: isReloading??this.isReloading,
      page: page??this.page,
      searchText: searchText??this.searchText,
        selectedCatId:selectedCatId??this.selectedCatId,
      isAdverFailure: isAdverFailure??this.isAdverFailure,
      isAdverLoading: isAdverLoading??this.isAdverLoading,
      adverlist: adverlist??this.adverlist,
    );
  }

  @override
  bool get stringify => true;
}
