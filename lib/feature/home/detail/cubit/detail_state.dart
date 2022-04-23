
part of 'detail_cubit.dart';

@immutable
class DetailState extends Equatable {

  final bool isNewsFailure;
  final bool isNewsLoading;
  final bool isbookmark;
  String errorMessage;
  final bool isAdverFailure;
  final bool isAdverLoading;
  List<AdvertismentList> adverlist;
  DetailState({
    this.isNewsFailure = false,
    this.isbookmark = false,
    this.isNewsLoading = true,
    this.errorMessage = '',
    this.isAdverFailure = false,
    this.isAdverLoading = true,
    required this.adverlist,
  });
  @override
  List<Object> get props {
    return [

      errorMessage,isNewsLoading,isNewsFailure,isbookmark,isAdverFailure,isAdverLoading,adverlist

    ];
  }

  DetailState copyWith(
      {
        String? errorMessage,
        bool? isNewsLoading,
        bool? isNewsFailure,
        bool? isbookmark,
        bool? isAdverFailure,
        bool? isAdverLoading,
        List<AdvertismentList>? adverlist,
      }) {
    return DetailState(
      errorMessage: errorMessage ?? this.errorMessage,
      isNewsLoading: isNewsLoading??this.isNewsLoading,
      isNewsFailure: isNewsFailure??this.isNewsFailure,
      isbookmark: isbookmark??this.isbookmark,
      isAdverFailure: isAdverFailure??this.isAdverFailure,
      isAdverLoading: isAdverLoading??this.isAdverLoading,
      adverlist: adverlist??this.adverlist,

    );
  }

  @override
  bool get stringify => true;
}
