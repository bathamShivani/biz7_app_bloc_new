import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/core/routes.dart';
import 'package:biz_app_bloc/data/api/api_helper.dart';
import 'package:biz_app_bloc/feature/home/cubit/home_page_cubit.dart';
import 'package:biz_app_bloc/model/News.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/images.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final DateFormat formatter = DateFormat('dd MMM, yyyy');
  TextEditingController _search=new TextEditingController();

  @override
  void onInit() {
    _cubit = BlocProvider.of<HomePageCubit>(context)
    ..savefcm()
      ..fetchMyCategories()
      ..fetchnews(0);

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
              height: Sizes.ICON_SIZE_32,
            ),
            actions: <Widget>[
              IconButton(
                icon: FaIcon(FontAwesomeIcons.bell,
                color: Colors.black,),
                onPressed: () {
                },
              ),
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
                          controller: _search,
                          decoration: InputDecoration(
                            hintText: StringConst.sentence.Search,
                            hintStyle: TextStyle(color: Colors.grey.shade600),

                            suffixIcon: InkWell(
                              onTap: (){
                                FocusManager.instance.primaryFocus?.unfocus();
                                _cubit.fetchnews(0,
                                    catID: state.selectedCatId,searchText:_search.text);
                              },
                              child: new Container(
                                height: 10,
                                child: FaIcon(
                                  FontAwesomeIcons.search,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(5),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          onSubmitted: (value){
                            print(value);
                            _cubit.fetchnews(0,
                                catID: state.selectedCatId,searchText:value);
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
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _scrollController.initialScrollOffset;
                                                _search.text="";
                                                _cubit.fetchnews(0,
                                                    catID: cat.catId,searchText:_search.text);

                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1.0,
                                                        color: (state.selectedCatId == cat.catId)
                                                            ? AppColors.red
                                                            : AppColors.backColor),
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

                                  ],
                                ),
                              ),
                              state.news.isNotEmpty? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child:LazyLoadScrollView(
                                          onEndOfPage: () => {
                                            if(state.isReloading)
                                              _cubit.fetchnews(state.page+1,catID:state.selectedCatId,searchText:_search.text),
                                            },

                                    child:  ListView.builder(
                                        controller: _scrollController,
                                          shrinkWrap: true,
                                          itemCount: state.news.length,
                                          itemBuilder: (context, index) {
                                            Datum news = state.news[index];
                                            return InkWell(
                                              onTap: () {
                                                final _bundle = Bundle()
                                                ..put('news', state.news)

                                                  ..put('search', _search.text)
                                                ..put('index', index);
                                                navigateToScreen(
                                                    Screen.detail,
                                                    _bundle);
                                              },
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
                                          }))
                                ),
                              ):Expanded(
                                child: Center(
                                  child: new Text(state.isNewsLoading?"":state.errorMessage,
                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                        fontWeight: FontWeight.w600,color: AppColors.red,
                                      )),
                                ),
                              )
                            ]),
                      ),
                  ],
                ),

                new Positioned(child: state.isCategoryLoading||state.isNewsLoading?Center(
                  child: CircularProgressIndicator(color: Colors.red,),
                ) :new Container(),)
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
      ..fetchMyCategories()
    ..fetchnews(0);

    super.onBackResult(bundle);
  }
}
