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
        news: <Datum>[],
    )
  );
  final DataHelper _dataHelper = DataHelperImpl.instance;
  List<Data>? list = List.empty(growable: true);
  List<Datum>? newslist = List.empty(growable: true);

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

  Future<void> fetchnews(int page, {int catID=1 ,String searchText=""}) async {
    emit(state.copyWith(isNewsLoading: true));
    final response = await _dataHelper.apiHelper.executeNews(
        page, [catID], searchText);

    response.fold((l) async {
      emit(state.copyWith(
        isNewsFailure: true,
        errorMessage: l.errorMessage,
        isNewsLoading: false,
        page: page,
        news: newslist,
        selectedCatId: catID
      ));
      emit(state.copyWith(
        isNewsFailure: false,
          page: page
      ));
    }, (r) async {
      if (r.data.isEmpty)
        emit(state.copyWith(
          news: newslist,
          isNewsLoading: false,
            page: page,
            selectedCatId: catID
        ));
      else {
        _newscategory = r;

        if(state.news==null ||state.news.length==0||page==0){
          emit(
            state.copyWith(
                news:  r.data,
                isNewsLoading: false,
                page: page,
                isReloading:true,
                selectedCatId: catID
            ),
          );
        }else if(state.news!=null &&state.news.length!=0&&page!=0){
          List<Datum> news=  state.news;

          news?.addAll(r.data!);
          emit(
            state.copyWith(
                news:  news,
                isNewsLoading: false,
                page: page,
              isReloading:news.length%10==0?true:false,
                selectedCatId: catID

            ),
          );
        }


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
