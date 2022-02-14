import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/model/Category.dart';
import 'package:biz_app_bloc/model/News.dart';
import 'package:biz_app_bloc/model/User.dart' as info;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'bookmark_state.dart';


class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit()
      : super(
      BookmarkState(
        news: <Datum>[],
      )
  );
  final DataHelper _dataHelper = DataHelperImpl.instance;
  List<Datum>? newslist = List.empty(growable: true);

  NewsCategory? _newscategory;

  Future<void> fetchBookmark() async {
    final result = info.userFromJson(await _dataHelper.cacheHelper.getUserInfo());

    emit(state.copyWith(isNewsLoading : true));
    final response = await _dataHelper.apiHelper.executeBookmark(0, [1],result.data.id);


    response.fold((l) async {
      emit(state.copyWith(
        isNewsFailure : true,
        isErrorMessage: true,
        errorMessage: l.errorMessage,
        isNewsLoading : false,
      ));
      emit(state.copyWith(
        isNewsFailure : false,
      ));
    }, (r) async {
      if (r.data.isEmpty)
        emit(state.copyWith(
          news: newslist,
          isNewsLoading : false,
            isErrorMessage : true,
            errorMessage: r.msg
        ));
      else {
        _newscategory  = r;
        emit(
          state.copyWith(
            news: r.data,
            isNewsLoading : false,
              isErrorMessage:false
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
