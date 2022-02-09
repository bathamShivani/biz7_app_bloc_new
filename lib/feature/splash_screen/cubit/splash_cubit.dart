import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  final DataHelper _dataHelper = DataHelperImpl.instance;

  Future<void> getLoggedInStatus() async {
    try {
      final result = await _dataHelper.cacheHelper.getUserInfo();
      if (result.isNotEmpty)
        emit(LoggedInState(true));
      else
        emit(LoggedInState(false));
    } catch (e) {
      emit(LoggedInState(false));
    }
  }
}
