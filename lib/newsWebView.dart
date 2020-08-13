import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'util/resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DescriptionPage extends StatelessWidget {
  static String tag = 'description-page';
  DescriptionPage(this.urlnews,this.title);
  final String urlnews;
  final String title;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: fontDark,
            size: 30*2.36.sp,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: whiteColor,
        title: new Text(
          title,
          style: new TextStyle(
            color: fontDark
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: WebView(
        initialUrl: urlnews,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}