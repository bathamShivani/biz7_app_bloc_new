
part of 'detail_cubit.dart';

@immutable
class DetailState extends Equatable {

  final bool isNewsFailure;
  final bool isNewsLoading;
  final bool isbookmark;
  String errorMessage;

  DetailState({
    this.isNewsFailure = false,
    this.isbookmark = false,
    this.isNewsLoading = true,
    this.errorMessage = '',

  });
  @override
  List<Object> get props {
    return [

      errorMessage,isNewsLoading,isNewsFailure,isbookmark

    ];
  }

  DetailState copyWith(
      {
        String? errorMessage,
        bool? isNewsLoading,
        bool? isNewsFailure,
        bool? isbookmark,

      }) {
    return DetailState(
      errorMessage: errorMessage ?? this.errorMessage,
      isNewsLoading: isNewsLoading??this.isNewsLoading,
      isNewsFailure: isNewsFailure??this.isNewsFailure,
      isbookmark: isbookmark??this.isbookmark,


    );
  }

  @override
  bool get stringify => true;
}
