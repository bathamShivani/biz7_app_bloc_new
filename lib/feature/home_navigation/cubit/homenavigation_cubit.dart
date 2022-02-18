import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'homenavigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit() : super(HomeNavigationIndexState(0));

  void switchBottomNavIndex(int index) {
    if (index != (state as HomeNavigationIndexState).index)
      emit(HomeNavigationIndexState(index));

  }
}
