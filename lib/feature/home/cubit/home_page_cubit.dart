import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/model/Category.dart';
import 'package:biz_app_bloc/model/News.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'HomePageState.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(
    HomePageState(
        category: <Data>[],
        news: <News>[],
    )
  );
  final DataHelper _dataHelper = DataHelperImpl.instance;
  List<Data>? list = List.empty(growable: true);
  List<News>? newslist = List.empty(growable: true);

  Category? _category;
  NewsCategory? _newscategory;

  Future<void> fetchMyCategories() async {
    emit(state.copyWith(isCategoryLoading: true));
    final response = await _dataHelper.apiHelper.executeCategory();

    response.fold((l) async {
      emit(state.copyWith(
        isCategoryFailure: true,
        errorMessage: l.errorMessage,
        isCategoryLoading: false,
      ));
      emit(state.copyWith(
        isCategoryFailure: false,
      ));
    }, (r) async {
      if (r.data.isEmpty)
        emit(state.copyWith(
          category: list,
          isCategoryLoading: false,
        ));
      else {
        _category = r;
        emit(
          state.copyWith(
            category: r.data,
            isCategoryLoading: false,
          ),
        );
        /*final liveClassResponse =
        await _dataHelper.apiHelper.executeMyCoursesLiveClass();
        liveClassResponse.fold((l) {
          emit(state.copyWith(
            isLiveClassLoading: false,
          ));
        }, (r) {
          emit(state.copyWith(
            courseLiveClass: r.live,
            isLiveClassLoading: false,
          ));
        });*/
      }
    });
  }

  Future<void> fetchnews() async {
    emit(state.copyWith(isNewsLoading: true));
    final response = await _dataHelper.apiHelper.executeNews(0, [state.category[0].catId], '');

    response.fold((l) async {
      emit(state.copyWith(
        isNewsFailure: true,
        errorMessage: l.errorMessage,
        isNewsLoading: false,
      ));
      emit(state.copyWith(
        isNewsFailure: false,
      ));
    }, (r) async {
      if (r.data.isEmpty)
        emit(state.copyWith(
          news: newslist,
          isNewsLoading: false,
        ));
      else {
        _newscategory = r;
        emit(
          state.copyWith(
            news: r.data,
            isNewsLoading: false,
          ),
        );
        /*final liveClassResponse =
        await _dataHelper.apiHelper.executeMyCoursesLiveClass();
        liveClassResponse.fold((l) {
          emit(state.copyWith(
            isLiveClassLoading: false,
          ));
        }, (r) {
          emit(state.copyWith(
            courseLiveClass: r.live,
            isLiveClassLoading: false,
          ));
        });*/
      }
    });
  }



}
