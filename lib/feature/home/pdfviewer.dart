import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewer extends AppScreen {
  PdfViewer(
      {RouteObserver<Route>? routeObserver, Key? key, Bundle? arguments})
      : super(routeObserver, key, arguments);
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends AppScreenState<PdfViewer> {
  late final String url,title;
  @override
  void onInit() {
    url = widget.arguments?.get('newsSource');
    title = widget.arguments?.get('title');
    super.onInit();
  }

  @override
  Widget setView() {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
          child: CustomAppBar(
            title: title,
            hasLeading: true,
            leading: InkWell(
              onTap: () {
                navigateToBack();
              },
              child: Icon(
                Icons.arrow_back_outlined,
                color: AppColors.black,
              ),
            ),
            hasTrailing: false,
          ),
        ),
        body:
        Container(
          child:const PDF().fromUrl(
            url,
            placeholder: (double progress) => Center(child: Text('$progress %')),
            errorWidget: (dynamic error) => Center(child: Text(error.toString())),
          ),)
    );
  }
}


