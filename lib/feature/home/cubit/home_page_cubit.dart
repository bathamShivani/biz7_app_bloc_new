import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/model/Category.dart';
import 'package:biz_app_bloc/model/News.dart';
import 'package:biz_app_bloc/model/User.dart' as info;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../model/Advertisement.dart';
part 'HomePageState.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(
    HomePageState(
        category: <Data>[],
        news: <Datum>[],
      adverlist: <AdvertismentList>[],
    )
  );
  final DataHelper _dataHelper = DataHelperImpl.instance;
  List<Data>? list = List.empty(growable: true);
  List<Datum>? newslist = List.empty(growable: true);
  List<AdvertismentList>? adlist = List.empty(growable: true);
  AdvertismentModel? advertismentModel;
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
      }
    });
  }

  Future<void> fetchnews(int page, {int catID=11 ,String searchText=""}) async {
    final result = info.userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    if(page==0){
      emit(state.copyWith(isNewsLoading: true,news:newslist));
    }else{
      emit(state.copyWith(isNewsLoading: true));
    }

    final response = await _dataHelper.apiHelper.executeNews(  page, [catID],result.data.id, searchText);
    response.fold((l) async {
      if(state.news==null ||state.news.length==0||page==0){
        emit(state.copyWith(
            isNewsFailure: true,
            errorMessage: l.errorMessage,
            isNewsLoading: false,
            page: page,
            news: newslist,
            selectedCatId: catID
        ));
      }else if(state.news!=null &&state.news.length!=0&&page!=0){
        emit(
          state.copyWith(
            isNewsLoading: false,
            page: page,
            isReloading:false,
            selectedCatId: catID,
            isNewsFailure: false,
          ),
        );
      }
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
         /* if(fetchadver) {
            for (int i = 0; i < _newscategory!.data.length; i++) {
              if (i % 3 == 0) {
                print('>>>>>>' + i.toString());
                print('>>>>>>' + advertismentModel!.data.length.toString());
                int a = (i / 3).toInt();
                print("aaaaaaaaaaaaa>>" + a.toString());
                _newscategory!.data.insert(i, Datum(newsId: 0,
                    catId: 0,
                    catName: "catName",
                    newsTitle: "newsTitle",
                    newsDescription: "newsDescription",
                    smallImg: "smallImg",
                    bigImg: "bigImg",
                    newsSource: "newsSource",
                    newsCountry: "newsCountry",
                    newsFooter: "newsFooter",
                    newsDate: "newsDate",
                    createdDate: "createdDate",
                    isBookmark: 0,
                    type: 'adv',
                    advimage: advertismentModel!.data.length > a
                        ? advertismentModel!.data[a].advImage
                        : advertismentModel!.data[0].advImage
                ));
              }
            }
          }*/
          news.addAll(r.data);
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
      }
    });
  }


  Future<void> savefcm() async {
    final result = info.userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    final token = await _dataHelper.cacheHelper.getFcmToken();
    emit(state.copyWith(isCategoryLoading: true));
    final response = await _dataHelper.apiHelper.executeFcm(result.data.id, token);

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
      emit(state.copyWith(isCategoryLoading: false,));
    });
  }

  Future<void> fetchAdvertisement() async {
    emit(state.copyWith(isAdverLoading: true));
    final response = await _dataHelper.apiHelper.executeAdvertisement();

    response.fold((l) async {
      emit(state.copyWith(
        isAdverFailure: true,
        errorMessage: l.errorMessage,
        isAdverLoading: false,
      ));
      emit(state.copyWith(
        isAdverFailure: false,
      ));
    }, (r) async {
      if (r.data.isEmpty) {
        emit(state.copyWith(
          adverlist: adlist,
          news: newslist,
          isAdverLoading: false,
        ));
      }
      else {
        advertismentModel = r;
        print('>>>>>>'+_newscategory!.data.length.toString());
       /* for (int i = 0; i < _newscategory!.data.length; i++) {
          if (i%3==0) {
            print('>>>>>>'+i.toString());
            int a=(i/3).toInt();
            print("aaaaaaaaaaaaa>>"+a.toString());
            _newscategory!.data.insert(i,Datum(newsId: 0, catId: 0, catName: "catName", newsTitle: "newsTitle", newsDescription: "newsDescription", smallImg: "smallImg", bigImg: "bigImg", newsSource: "newsSource", newsCountry: "newsCountry", newsFooter: "newsFooter", newsDate: "newsDate", createdDate: "createdDate", isBookmark: 0,
                type: 'adv',
                advimage:r.data.length>a? r.data[a].advImage:r.data[0].advImage
            ));
          }
        }*/

        emit(
          state.copyWith(
            adverlist: r.data,
            isAdverLoading: false,
          ),
        );
      }
    });
  }

}
