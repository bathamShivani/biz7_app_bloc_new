import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/model/Category.dart';
import 'package:biz_app_bloc/model/News.dart';
import 'package:biz_app_bloc/model/User.dart' as info;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'detail_state.dart';


class DetailCubit extends Cubit<DetailState> {
  DetailCubit()
      : super(
      DetailState(
      )
  );
  final DataHelper _dataHelper = DataHelperImpl.instance;
  List<Datum>? newslist = List.empty(growable: true);


  Future<void> updateBookmark(news_id, is_bookmark) async {
    emit(state.copyWith(isNewsLoading : true,isbookmark: false));

    final result = info.userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    final response = await _dataHelper.apiHelper.updateBookmark(news_id, is_bookmark, result.data.id);


    response.fold((l) {
      print('failure');
      print(l.errorMessage);
      emit(state.copyWith(isNewsLoading : false,isbookmark: false,errorMessage: l.errorMessage));
    }, (r) {
      print('success');
      print(r);
      emit(state.copyWith(isNewsLoading : false,isbookmark: true,errorMessage: r));
    });
  }




}
