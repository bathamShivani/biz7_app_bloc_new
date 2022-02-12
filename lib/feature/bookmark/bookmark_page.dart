
import 'package:biz_app_bloc/utility/adaptive.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:biz_app_bloc/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {

  @override
  void initState() {
    print('initstate');
    //homeController.getBookmarks();
    super.initState();
  }

  Future<bool> onGoBack(dynamic value) async {
    //homeController.getBookmarks();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    final DateFormat formatter = DateFormat.yMMMd();
    // final newsProv = Provider.of<NewsProvider>(context);
    // super.build(context);
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
        child: SingleChildScrollView(
          child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // controller: homeController.scrollController.value,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        //News news = homeController.bookmarks[index];
                        return Container(color: Colors.red,);
                       /* return InkWell(
                         // onTap: () =>Get.to(DetailPage(news: homeController.bookmarks,index:index)).then(onGoBack),
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
                                                      .subtitle1
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
                                                                .bodyText2
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
                                              image:ApiConstants.BASE_IMAGE_URL +news.smallImg
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
                        );*/
                      }),
                ),

              ],
            ),
          ),
        ),
    //  ),
    );
  }
}

