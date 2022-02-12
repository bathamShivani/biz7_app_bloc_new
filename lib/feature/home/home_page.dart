import 'dart:io';
import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/data/api/api_helper.dart';
import 'package:biz_app_bloc/feature/home/cubit/home_page_cubit.dart';
import 'package:biz_app_bloc/model/Category.dart';
import 'package:biz_app_bloc/model/News.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/images.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';


class HomePage extends AppScreen {
  HomePage(
      {RouteObserver<Route>? routeObserver, Key? key, Bundle? arguments})
      : super(routeObserver, key, arguments);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends AppScreenState<HomePage> {
  final _scrollController = ScrollController();
  late HomePageCubit _cubit;
  int _courseProgress = 0;
  String name = '';
  String selectedEventName = '';
  int selectedEventindex = -1;
  final DateFormat formatter = DateFormat('dd MMM, yyyy');

  @override
  void onInit() {
    _cubit = BlocProvider.of<HomePageCubit>(context)
      ..fetchMyCategories()
      ..fetchnews(0);

   // _scrollController.addListener(_onListScrolled);
    super.onInit();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget setView() {

    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        if (state.isCategoryFailure) showSnackBar(state.errorMessage);
        //if (state.isNewsFailure) showSnackBar(state.errorMessage);

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            titleSpacing: 30,
            automaticallyImplyLeading: false,
            title: Image.asset(
              ImagePath.LOGO,
              // fit: BoxFit.cover,
              height: Sizes.ICON_SIZE_32,
            ),
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset(ImagePath.BELL, height: Sizes.ICON_SIZE_30),
                onPressed: () {
                  // showSearch(context: context, delegate: SearchNewsPage());
                },
              ),
              /*IconButton(
            icon: SvgPicture.asset(ImagePath.MENU, height: Sizes.ICON_SIZE_30),
            onPressed: () {
              // showSearch(context: context, delegate: SearchNewsPage());
            },
          ),*/
            ],
          ),
          body: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      height: 35,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: StringConst.sentence.Search,
                            hintStyle: TextStyle(color: Colors.grey.shade600),

                            suffixIcon: InkWell(
                              onTap: () {
                                //print(_searchController.text);
                                //search();
                              },
                              child: new Container(
                                height: 20,
                                child: SvgPicture.asset(
                                  ImagePath.SEARCH,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.contain,
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(5),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                         /// controller: _searchController,
                          onSubmitted: (value){
                            print(value);
                            _cubit.fetchnews(0,
                                catID: state.selectedCatId,searchText:value);
                            //search();
                          },
                          onChanged: (value){
                            if(value==''){
                              _cubit.fetchnews(0,
                                  catID: state.selectedCatId,searchText:value);
                            }
                          },
                        ),
                      ),
                    ),
                    //SearchLine(widthOfScreen: widthOfScreen),
                    Padding(
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Divider(
                        height: 3,
                        color: Colors.red,
                        thickness: 2,
                      ),
                    ),
                    if (state.category.isNotEmpty )
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              if (state.category.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 30,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.category.length,
                                        itemBuilder: (context, index) {
                                          final cat = state.category.elementAt(index);
                                         // Category c = state.category.elementAt(index) as Category;
                                         // Category selected = homeController.cat.value;
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: GestureDetector(
                                              onTap: () {

                                                _cubit.fetchnews(0,
                                                    catID: cat.catId);
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1.0,
                                                        color: (state.selectedCatId == cat.catId)
                                                            ? AppColors.red
                                                            :
                                                        AppColors.backColor),
                                                    color: AppColors.backColor,
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(40)),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 20.0, vertical: 6.0),
                                                    child: Text(
                                                      cat.catName,
                                                      textAlign: TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          );
                                        }),
                                  ),
                                ),

                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Divider(
                                  color: AppColors.grey,
                                  thickness: 1,
                                ),
                              ),
                               Padding(
                                padding:
                                const EdgeInsets.only(left: 16.0, right: 16, bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text('MOST RECENT',
                                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    /*SvgPicture.asset(
                        ImagePath.GRIDVIEW,
                        height: 30,
                      ),
                      SpaceW12(),
                      SvgPicture.asset(ImagePath.LISTVIEW, height: 30)*/
                                  ],
                                ),
                              ),
                             // if (state.news.isNotEmpty)
                              state.news.isNotEmpty? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),

                                      child:LazyLoadScrollView(
                                          onEndOfPage: () => {
                                            if(state.isReloading)
                                              _cubit.fetchnews(state.page+1),
                                            print(
                                                "sdsvvsvdsv>>>>>>>>>  ffff>>>>>>>>>>>>>>>>>>>>>>>...@@@@@@@****************"+state.page.toString())


                                          },

                                    child:  ListView.builder(
                                          shrinkWrap: true,
                                          //controller: ,
                                          itemCount: state.news.length,

                                          itemBuilder: (context, index) {
                                            Datum news = state.news[index];
                                            return InkWell(
                                              /*onTap: () => Get.to(() => DetailPage(
                                                  news: homeController.news,
                                                  index: index)).then(onGoBack),*/
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    0.0, 0.5, 0.0, 0.5),
                                                child: Card(
                                                  elevation: 0,
                                                  shape: Border(
                                                      bottom: BorderSide(
                                                          color: AppColors.grey, width: 1)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(news.newsTitle,
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.bold
                                                                    ),

                                                                    /* style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )*/
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Text(
                                                                        formatter.format(new DateFormat(
                                                                            "yyyy-MM-dd hh:mm:ss")
                                                                            .parse(news
                                                                            .newsDate)) +
                                                                            " | ",
                                                                        style: TextStyle(
                                                                            color:
                                                                            Colors.black45,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                      ),
                                                                      new Row(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          Container(
                                                                              color: AppColors
                                                                                  .black,
                                                                              child: Padding(
                                                                                padding:
                                                                                const EdgeInsets
                                                                                    .only(
                                                                                    top:
                                                                                    3.0,
                                                                                    left: 2,
                                                                                    right:
                                                                                    2,
                                                                                    bottom:
                                                                                    0),
                                                                                child: Text(
                                                                                  news.catName
                                                                                      .toUpperCase(),
                                                                                  textAlign:
                                                                                  TextAlign
                                                                                      .center,
                                                                                  style: Theme.of(
                                                                                      context)
                                                                                      .textTheme
                                                                                      .bodyText2!
                                                                                      .copyWith(
                                                                                      color: AppColors
                                                                                          .white,
                                                                                      fontSize:
                                                                                      8),
                                                                                ),
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                                height: 65.0,
                                                                width: 65.0,
                                                                margin:
                                                                EdgeInsets.only(left: 10),
                                                                child: FadeInImage.assetNetwork(
                                                                  placeholder:
                                                                  ImagePath.PLACEHOLDER,
                                                                  image: ApiEndPoints
                                                                      .BASE_IMAGE_URL +
                                                                      news.smallImg,
                                                                  fit: BoxFit.cover,
                                                                )),
                                                          ],
                                                        ),

                                                        // Icon(Icons.bookmark_border),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );

                                            // return Padding(
                                            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            //   child: Container(
                                            //       decoration: BoxDecoration(
                                            //         color: AppColors.backColor,
                                            //         borderRadius:
                                            //             BorderRadius.all(Radius.circular(40)),
                                            //       ),
                                            //       child: Padding(
                                            //         padding: const EdgeInsets.symmetric(
                                            //             horizontal: 30.0, vertical: 16.0),
                                            //         child: Text(
                                            //           _dx.news[index].news_title,
                                            //           style: Theme.of(context)
                                            //               .textTheme
                                            //               .bodyText1
                                            //               .copyWith(
                                            //                   // fontWeight: FontWeight.bold,
                                            //                   ),
                                            //         ),
                                            //       )),
                                            // );
                                          }))
                                  //),
                                ),
                              ):Expanded(
                                child: Center(
                                  child: new Text(state.errorMessage,

                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                        fontWeight: FontWeight.w600,color: AppColors.red,
                                      )),
                                ),
                              )
                            ]),
                      ),
                    if (state.isCategoryLoading ||state.isNewsLoading)
                      const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }



  @override
  void onBackResult(Object? bundle) {
    _cubit
      ..fetchMyCategories();

    super.onBackResult(bundle);
  }


/*
  void _onListScrolled() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent &&
        !_cubit.isFetching) {
      _cubit
        ..isFetching = true
        ..fetchMyCoursesList();
    }
  }
*/
}
