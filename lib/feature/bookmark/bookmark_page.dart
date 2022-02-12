import 'dart:io';
import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/data/api/api_helper.dart';
import 'package:biz_app_bloc/feature/bookmark/cubit/bookmark_cubit.dart';
import 'package:biz_app_bloc/feature/home/cubit/home_page_cubit.dart';
import 'package:biz_app_bloc/model/Category.dart';
import 'package:biz_app_bloc/model/News.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/images.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:biz_app_bloc/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


class BookmarkPage extends AppScreen {
  BookmarkPage(
      {RouteObserver<Route>? routeObserver, Key? key, Bundle? arguments})
      : super(routeObserver, key, arguments);
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends AppScreenState<BookmarkPage> {
  late BookmarkCubit _cubit;
  final DateFormat formatter = DateFormat('dd MMM, yyyy');

  @override
  void onInit() {
    _cubit = BlocProvider.of<BookmarkCubit>(context)
      ..fetchBookmark();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget setView() {

    return BlocConsumer<BookmarkCubit, BookmarkState>(
      listener: (context, state) {
        if (state.isNewsFailure) showSnackBar(state.errorMessage);
        //if (state.isNewsFailure) showSnackBar(state.errorMessage);

      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
            child: CustomAppBar(
              title: StringConst.BOOKMARK.toUpperCase(),
              hasLeading: false,
              hasTrailing: false,
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.news.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                           // physics: NeverScrollableScrollPhysics(),
                            // controller: homeController.scrollController.value,
                            itemCount: state.news.length,
                            itemBuilder: (context, index) {
                              Datum news = state.news[index];
                              return InkWell(
                                //onTap: () => Get.to(DetailPage(news: homeController.bookmarks,index:index)).then(onGoBack),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
                                  child: Card(
                                    elevation: 0,
                                    shape: Border(
                                        bottom: BorderSide(
                                            color: AppColors.grey, width: 1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Column(
                                                  children: [

                                                    Text(news.newsTitle,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1!
                                                            .copyWith(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        )),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: <Widget>[

                                                        Text(
                                                          formatter.format(new DateFormat(
                                                              "yyyy-MM-dd hh:mm:ss")
                                                              .parse(news.newsDate))+" | ",
                                                          style: TextStyle(
                                                              color: Colors.black45,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ),
                                                        new Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
                                                          Container(
                                                              color: AppColors.black,
                                                              child:  Padding(
                                                                padding:
                                                                const EdgeInsets.only(top:
                                                                3.0,left: 2,right: 2,bottom: 0),
                                                                child: Text(
                                                                  news.catName
                                                                      .toUpperCase(),
                                                                  textAlign: TextAlign.center,
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .copyWith(
                                                                      color: AppColors
                                                                          .white,
                                                                      fontSize: 8
                                                                  ),
                                                                ),
                                                              ))
                                                        ],),

                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              ),
                                              Container(
                                                  height: 65.0,
                                                  width: 65.0,
                                                  margin: EdgeInsets.only(left: 10),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder:
                                                    ImagePath.PLACEHOLDER,
                                                    image:ApiEndPoints.BASE_IMAGE_URL +news.smallImg
                                                    ,
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
                            }),
                      ),
                    ),
                    if (state.isNewsLoading)
                      const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                    if(state.isErrorMessage)
                      Expanded(
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 10),
                              child: Text("You haven't save any bookmark" ,
                                  style:
                                  Theme.of(context).textTheme. bodyText1!.copyWith(
                                    fontWeight: FontWeight.w300,
                                  )),
                            )),
                      )


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
      ..fetchBookmark();

    super.onBackResult(bundle);
  }

}
