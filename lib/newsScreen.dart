import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'util/resource.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
import 'newsWebView.dart';

class NewsScreen extends StatefulWidget {
  String imageUrl, title, description, url;
  String pubDate;
  bool darkMode;
  NewsScreen({this.title,this.imageUrl,this.description,this.url,this.pubDate,this.darkMode});
  @override
  _NewsScreenState createState() => _NewsScreenState(
    title: title,
    imageUrl: imageUrl,
    description: description,
    url: url,
    darkMode:darkMode,
    pubDate: pubDate,
  );
}

class _NewsScreenState extends State<NewsScreen> {
  String imageUrl, title, description, url,pubDate;
  bool darkMode;
  _NewsScreenState({this.title,this.imageUrl,this.description,this.url,this.pubDate,this.darkMode});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,allowFontScaling:true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkMode==true ? darkModeColor : whiteColor,
        body: SingleChildScrollView(
          child: Container(
            child: url!=null ?
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500*2.36.h,
                      child: ClipRect(
                        child: PhotoView(
                          imageProvider: imageUrl==null ? NetworkImage('https://thumbs.dreamstime.com/b/no-image-available-icon-photo-camera-flat-vector-illustration-132483141.jpg'):NetworkImage(imageUrl),
                          minScale: PhotoViewComputedScale.contained*0.8,
                          maxScale: PhotoViewComputedScale.covered*2,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: whiteColor,
                        size: 40*2.36.sp,
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20*2.36.w),
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height: 20*2.36.h,),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            color: darkMode==true ? fontLight : fontMedium,
                            size: 25*2.36.sp,
                          ),
                          SizedBox(
                            width: 10*2.36.w,
                          ),
                          Container(
                            child: Text(
                              pubDate,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 20*2.36.sp,
                                color: darkMode==true ? fontLight : fontMedium,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20*2.36.h,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 26*2.36.sp,
                            color: darkMode==true ? bgLight : fontDark,
                            fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      SizedBox(height: 20*2.36.h,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          description.contains('</a>')==true ? description.substring(description.lastIndexOf('</a>')+4) : description,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 20*2.36.sp,
                            color: darkMode==true ? bgLight : fontDark,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      SizedBox(height: 30*2.36.h,),
                      Row(
                        children: <Widget>[
                          Container(
                        child: Text(
                          'Continue Reading - ',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 20*2.36.sp,
                            color: darkMode==true ? bgLight : fontDark,
                            fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      SizedBox(width: 10*2.36.h,),
                      InkWell(
                        onTap: (){
                          var openUrl = url;
                          Navigator.push(context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => new DescriptionPage(url,title)
                      )
                    );
                        },
                        child: Container(
                          child: Text(
                            'Click Here',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 20*2.36.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                        ],
                      ),
                      SizedBox(height: 50*2.36.h,),
                    ],
                  ),
                ),
              ],
            ):Center(
                      child: SpinKitCircle(
                        color: primaryColor,
                        size: 100 * 2.36.sp,
                      ),
                    )
          ),
        ),
      ),
    );
  }
}