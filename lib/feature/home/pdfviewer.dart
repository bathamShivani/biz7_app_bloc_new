import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:flutter/material.dart';



class PdfFileScreen extends AppScreen {
  PdfFileScreen(
      {RouteObserver<Route>? routeObserver,
        Key? key,
        Bundle? arguments,
        this.showAppBar = true})
      : super(routeObserver, key, arguments);
  final bool showAppBar;
  @override
  _PdfFileScreenState createState() => _PdfFileScreenState();
}

class _PdfFileScreenState extends AppScreenState<PdfFileScreen> {
  late String pdf;
  late String link;
  late String url;
  late String? fileName;
  PDFDocument? document;

  @override
  void onInit() {
    link = widget.arguments?.get('newsSource');
    fileName = widget.arguments?.get('title');
    super.onInit();
  }

  Future<PDFDocument> _getDocument() async {
    File file = File(link);
    return await PDFDocument.fromFile(file);
  }

  @override
  AppBar? appBar() {
    return widget.showAppBar
        ? AppBar(
      title: Text(
        fileName ?? 'PDF',
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: Theme.of(context).primaryColor),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
    )
        : null;
  }

  @override
  Widget setView() {
    return FutureBuilder<PDFDocument>(
      future: _getDocument(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Container(child: PDFViewer(document: snapshot.data!));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Could not able to load the PDF.\nPlease try again later.',
              style: textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  bool onBackPressed() {
    return true;
  }

  @override
  void onBackResult(Object? bundle) {
    super.onBackResult(bundle);
  }
}
