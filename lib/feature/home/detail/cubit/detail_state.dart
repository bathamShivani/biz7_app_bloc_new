
part of 'detail_cubit.dart';

@immutable
class DetailState extends Equatable {

  final bool isNewsFailure;
  final bool isNewsLoading;

  String errorMessage;

  DetailState({
    this.isNewsFailure = false,
    this.isNewsLoading = true,
    this.errorMessage = '',
  });
  @override
  List<Object> get props {
    return [

      errorMessage,isNewsLoading,isNewsFailure

    ];
  }

  DetailState copyWith(
      {
        String? errorMessage,
        bool? isNewsLoading,
        bool? isNewsFailure,
      }) {
    return DetailState(
      errorMessage: errorMessage ?? this.errorMessage,
      isNewsLoading: isNewsLoading??this.isNewsLoading,
      isNewsFailure: isNewsFailure??this.isNewsFailure,

    );
  }

  @override
  bool get stringify => true;
}
