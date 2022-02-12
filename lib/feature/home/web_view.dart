import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/sizes.dart';
import 'package:biz_app_bloc/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends AppScreen {
  WebViewPage(
      {RouteObserver<Route>? routeObserver, Key? key, Bundle? arguments})
      : super(routeObserver, key, arguments);
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends AppScreenState<WebViewPage> {
  late final String url,title;
  @override
  void onInit() {
    url = widget.arguments?.get('newsSource');
    title = widget.arguments?.get('title');
    super.onInit();

  }
  @override
  Widget setView() {
    return
    Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
          title: title,
          hasLeading: true,
          leading: InkWell(
            onTap: () => navigateToBack(),
            child: Icon(
              Icons.arrow_back_outlined,
              color: AppColors.black,
            ),
          ),
          hasTrailing: false,
        ),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }

}

