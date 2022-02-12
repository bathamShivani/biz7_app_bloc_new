import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/core/routes.dart';
import 'package:biz_app_bloc/data/api/api_helper.dart';
import 'package:biz_app_bloc/feature/home/detail/cubit/detail_cubit.dart';
import 'package:biz_app_bloc/model/News.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/images.dart';
import 'package:biz_app_bloc/utility/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class DetailPage extends AppScreen {
  DetailPage(
      {RouteObserver<Route>? routeObserver, Key? key, Bundle? arguments})
      : super(routeObserver, key, arguments);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends AppScreenState<DetailPage> {
  bool isBookMark = false;
  int pageNumber = 0;
  late PageController _controller ;
  final DateFormat formatter = DateFormat.MMMMd();
  late final List<Datum> news;
  late final int index;
  late DetailCubit _cubit;

  @override
  void onInit() {
    _cubit = BlocProvider.of<DetailCubit>(context);
    news = widget.arguments?.get('news');
    index = widget.arguments?.get('index');
    isBookMark =news[index].isBookmark == '1' ? true : false;
    pageNumber=index;
    _controller = PageController(
      initialPage: index,
    );
    super.onInit();

  }

  @override
  Widget setView() {
    return BlocConsumer<DetailCubit, DetailState>(
        listener: (context, state) {
      if (state.isNewsFailure) showSnackBar(state.errorMessage);
      //if (state.isNewsFailure) showSnackBar(state.errorMessage);

    },
    builder: (context, state) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          PageView(
              scrollDirection: Axis.vertical,
              onPageChanged: (page) {
                print("page>> " + page.toString());
                pageNumber=page;
                setState(() {
                  isBookMark = news[page].isBookmark == '1' ? true : false;
                });

              },
              controller: _controller,
              children: news
                  .map((item) => SingleChildScrollView(
                child: Column(
                  children: [
                    FadeInImage.assetNetwork(
                      height: 300,
                      placeholder: ImagePath.PLACEHOLDER,
                      image: ApiEndPoints.BASE_IMAGE_URL + item.bigImg,
                      fit: BoxFit.fitHeight,
                    ),
                    SpaceH12(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                formatter.format(new DateFormat(
                                    "yyyy-MM-dd hh:mm:ss")
                                    .parse(item.newsDate)),
                                style: TextStyle(
                                  // color: Colors.black45,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                  // color: Colors.black45,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SpaceH12(),
                          Text(
                            item.newsTitle,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SpaceH12(),
                          Text(
                            item.newsDescription,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          SpaceH12(),
                          Center(
                            child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48.0, vertical: 10.0),
                                  child: Text(
                                    "Continue Reading".toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.primaryColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                30),
                                            side: BorderSide(color: AppColors.primaryColor)))),
                                onPressed: ()  {
                                  if(item.newsSource.contains('.pdf')){
                                    // _launchURL(item.newsSource)


                                   // Get.to(PdfViewer(url: item.newsSource, title: item.newsTitle))
                                    final _bundle = Bundle()
                                      ..put('newsSource',item.newsSource)
                                      ..put('title', item.newsTitle);
                                    navigateToScreenAndReplace(Screen.webview,_bundle);
                                  }else{
                                    //Get.to(PdfViewer(url: item.newsSource));
                                    ///Get.to(WebViewMain(url: item.newsSource, title: item.newsTitle))
                                    final _bundle = Bundle()
                                       ..put('newsSource',item.newsSource)
                                       ..put('title', item.newsTitle);
                                    navigateToScreenAndReplace(Screen.pdfview,_bundle);

                                  }


                                }),
                          )
                        ],
                      ),
                    ),
                    SpaceH12(),
                  ],
                ),
              ))
                  .toList()),
          new Container(
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 26.0),
                  child: IconButton(
                    onPressed: () {
                    navigateToBack();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                      size: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0, right: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isBookMark = (isBookMark == true) ? false : true;
                            });
                            _cubit.updateBookmark(news[pageNumber].newsId,isBookMark?1:0);
                           /* homeController.bookmark(
                                widget.news[pageNumber].newsId,
                                isBookMark ? 1 : 0);*/
                          },
                          child: Icon(
                            isBookMark
                                ? Icons.bookmark_sharp
                                : Icons.bookmark_outline_sharp,
                            color: AppColors.white,
                            size: 28,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Share.share('check out my website https://example.com');
                          Share.share('To update yourself with business TINY. Download Biz7 - https://play.google.com/store/apps/details?id=com.biz_app.biz_app');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0, right: 5),
                          child: Icon(
                            Icons.share,
                            color: AppColors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),)
        ],
      ),
    );
  });
  }
}
