import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'util/resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Animation/FadeAnimation.dart';
import 'newsScreen.dart';
import 'categoryScreen.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<NewsData> newsList = List();
  List<NewsData> temp = List();
  String status = "";

  void getNews() async {
    var res = await http.get(
        "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeedstopstories.cms");
    var resBody = json.decode(res.body);

    for (var n in resBody["items"]) {
      String imgTemp =
          'https://static.toiimg.com/thumb/msid-76635241,width-1070,height-580,imgsize-377478,resizemode-75,overlay-toi_sw,pt-0,y_pad-40/photo.jpg';
      NewsData temp1 = NewsData(
          n["title"].toString(),
          n["description"].toString(),
          n["link"].toString(),
          'https://static.toiimg.com/thumb/msid-' +
              n["link"].toString().substring(
                  n["link"].toString().lastIndexOf('/') + 1,
                  n["link"].toString().lastIndexOf('.cms')) +
              ',width-1070,height-580,imgsize-377478,resizemode-75,overlay-toi_sw,pt-0,y_pad-40/photo.jpg',
          n["pubDate"].toString());
      temp.add(temp1);
    }
    String statuscode = resBody["status"];
    if (!mounted) return;
    setState(() {
      newsList = temp;
      status = statuscode;
      print(status);
    });
  }

  List<String> category = [
    'Sports',
    'Tech',
    'Business',
    'Life & Style',
    'Entertainment',
    'Health'
  ];
  List<String> categoryLink = [
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F4719148.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F66949542.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F1898055.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F2886704.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F1081479906.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F3908999.cms',
  ];
  List<String> categoryImage = [
    'assets/sports.png',
    'assets/mobile.png',
    'assets/business.png',
    'assets/fashion.png',
    'assets/film.png',
    'assets/politics.png'
  ];

  bool toggleValue = false;
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _controller;

  AppBar appBar = AppBar();
  double borderRadius = 0.0;
  bool isDarkMode = false;
  

  @override
  void initState() {
    super.initState();
    getNews();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return WillPopScope(
      onWillPop: () async {
        if (!isCollapsed) {
          setState(() {
            _controller.reverse();
            borderRadius = 0.0;
            isCollapsed = !isCollapsed;
          });
          return false;
        } else
          return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: isDarkMode == true ? darkModeColor : whiteColor,
          body: Stack(
            children: <Widget>[
              menu(context),
              AnimatedPositioned(
                  left: isCollapsed ? 0 : 0.6 * screenWidth,
                  right: isCollapsed ? 0 : -0.6 * screenWidth,
                  top: isCollapsed ? 0 : screenHeight * 0.0,
                  bottom: isCollapsed ? 0 : screenHeight * 0.0,
                  duration: duration,
                  curve: Curves.fastOutSlowIn,
                  child: dashboard(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu(context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 70 * 2.36.h,
                ),
                Container(
                  height: 200 * 2.36.w,
                  width: 200 * 2.36.w,
                  child: Center(
                    child: CircleAvatar(
                      radius: 500*2.36.sp,
                      backgroundColor: primaryColor.withOpacity(0.8),
                      child: Text(
                        'U',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          color: whiteColor,
                          fontSize: 80*2.36.sp,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20 * 2.36.h,
                ),
                Container(
                  width: 200*2.36.w,
                  child: Center(
                    child: Text(
                      'User',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 30 * 2.36.sp,
                        color: isDarkMode == true ? whiteColor : fontDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70 * 2.36.h,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 22.0 * 2.36.sp,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode == true ? whiteColor : fontDark),
                      ),
                      SizedBox(
                        width: 20 * 2.36.w,
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          activeColor: primaryColor,
                          value: isDarkMode,
                          onChanged: (val) {
                            setState(() {
                              isDarkMode = !isDarkMode;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.settings,
                        color: isDarkMode == true ? whiteColor : fontDark,
                        size: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode == true ? whiteColor : fontDark),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.info_outline,
                        color: isDarkMode == true ? whiteColor : fontDark,
                        size: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'About',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode == true ? whiteColor : fontDark),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return SafeArea(
      child: Material(
        shadowColor: isDarkMode == true ? whiteColor : fontDark,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        type: MaterialType.card,
        animationDuration: duration,
        color: isDarkMode == true ? darkModeColor : whiteColor,
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: isDarkMode == true ? darkModeColor : whiteColor,
              leading: IconButton(
                  icon: AnimatedIcon(
                    size: 30.0,
                    color: isDarkMode == true ? whiteColor : fontDark,
                    icon: AnimatedIcons.menu_close,
                    progress: _controller,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isCollapsed) {
                        _controller.forward();

                        borderRadius = 16.0;
                      } else {
                        _controller.reverse();

                        borderRadius = 0.0;
                      }

                      isCollapsed = !isCollapsed;
                    });
                  }),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.bookmark_border,
                    size: 30 * 2.36.sp,
                    color: isDarkMode == true ? whiteColor : fontDark,
                  ),
                  onPressed: null,
                ),
              ],
              title: Text(
                'Feeds',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: fontFamily,
                    color: isDarkMode == true ? whiteColor : fontDark,
                    fontSize: 30 * 2.36.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            backgroundColor: isDarkMode == true ? darkModeColor : whiteColor,
            body: SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
                  // padding: EdgeInsets.symmetric(horizontal: 5.0*2.36.w),
                  child: status == "ok"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10 * 2.36.h,
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 10 * 2.36.w),
                              child: Text(
                                'Category',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    color: isDarkMode == true
                                        ? bgLight
                                        : fontMedium,
                                    fontSize: 25 * 2.36.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 10 * 2.36.h,
                            ),
                            
                            FadeAnimation(
                              1,
                              Container(
                                height: 100 * 2.36.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: category.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          CategoryScreen(
                                                            seletecdCategory:
                                                                category[index],
                                                            darkMode:
                                                                isDarkMode,
                                                          )));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5 * 2.36.w),
                                              width: 80 * 2.36.w,
                                              height: 80 * 2.36.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                border: Border.all(
                                                    color: primaryColor,
                                                    width: 2 * 2.36.w),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                child: Image(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      categoryImage[index]),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            category[index],
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              color: isDarkMode == true
                                                  ? bgLight
                                                  : fontMedium,
                                              fontSize: 16 * 2.36.sp,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: 10 * 2.36.h,
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 10 * 2.36.w),
                              child: Text(
                                'Top Headlines',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    color: isDarkMode == true
                                        ? bgLight
                                        : fontMedium,
                                    fontSize: 25 * 2.36.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 10 * 2.36.h,
                            ),
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                height: 500 * 2.36.h,
                                enlargeCenterPage: true,
                                autoPlay: true,
                              ),
                              itemCount: newsList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      NewsScreen(
                                                        title: newsList[index].title,
                                                        imageUrl: newsList[index].imageUrl,
                                                        description: newsList[index]
                                                            .description,
                                                        url: newsList[index].urlPage,
                                                        pubDate: newsList[index].pubDate,
                                                        darkMode: isDarkMode,)));
                                  },
                                  child: Card(
                                    color: isDarkMode == true
                                        ? bgLightDark
                                        : bgLight,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: <Widget>[
                                        Container(
                                          height: MediaQuery.of(context).size.height,
                                          decoration: BoxDecoration(
                                              color: isDarkMode == true
                                                  ? bgLightDark
                                                  : bgLight,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image(
                                              image: NetworkImage(
                                                  newsList[index].imageUrl),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(10,10,10,10),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          decoration: BoxDecoration(
                                            color: fontDark.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)
                                            )
                                          ),
                                          child: Text(
                                            newsList[index].title,
                                            style: TextStyle(
                                                fontFamily: fontFamily,
                                                color:bgLight,                                                    
                                                fontSize: 22 * 2.36.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10 * 2.36.h,
                            ),
                            // Expanded(
                            //   child: Container(
                            //     margin: EdgeInsets.only(bottom: 60),
                            //     child: FadeAnimation(
                            //       1.4,
                            //       ListView.builder(
                            //         scrollDirection: Axis.horizontal,
                            //         itemCount: newsList.length,
                            //         itemBuilder: (context, index) {
                            //           index = index;
                            //           return InkWell(
                            //             onTap: () {
                            //               Navigator.of(context).push(
                            //                   MaterialPageRoute(
                            //                       builder: (BuildContext context) =>
                            //                           NewsScreen(
                            //                             title: newsList[index].title,
                            //                             imageUrl: newsList[index].imageUrl,
                            //                             description: newsList[index]
                            //                                 .description,
                            //                             url: newsList[index].urlPage,
                            //                             darkMode: isDarkMode,
                            //                           )));
                            //             },
                            //             child: Card(
                            //               color: isDarkMode==true ? bgLightDark : bgLight,
                            //               shape: RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.circular(10),
                            //               ),
                            //               child: Container(
                            //                 height: 150 * 2.36.h,
                            //                 width: MediaQuery.of(context).size.width,
                            //                 decoration: BoxDecoration(
                            //                   color: isDarkMode==true ? bgLightDark : bgLight,
                            //                   borderRadius: BorderRadius.circular(10),
                            //                 ),
                            //                 child: Row(
                            //                   children: <Widget>[
                            //                     Container(
                            //                       width: 150 * 2.36.h,
                            //                       height: 150 * 2.36.h,
                            //                       child: ClipRRect(
                            //                         borderRadius: BorderRadius.only(
                            //                             bottomLeft:
                            //                                 Radius.circular(10),
                            //                             topLeft: Radius.circular(10)),
                            //                         child: Image(
                            //                           fit: BoxFit.cover,
                            //                           image: NetworkImage(newsList[index].imageUrl),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     SizedBox(width: 10*2.36.w,),
                            //                     Column(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.center,
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment.start,
                            //                       children: <Widget>[
                            //                         Container(
                            //                           width: 250 * 2.36.sp,
                            //                           child: Text(
                            //                             newsList[index].title,
                            //                             style: TextStyle(
                            //                                 fontFamily: fontFamily,
                            //                                 color: isDarkMode==true ? bgLight : textColor,
                            //                                 fontSize: 20 * 2.36.sp,
                            //                                 fontWeight:
                            //                                     FontWeight.w600),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           );
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        )
                      : Center(
                          child: SpinKitFadingCircle(
                            color: primaryColor,
                            size: 100 * 2.36.sp,
                          ),
                        )),
            ),
          ),
        ),
      ),
    );
  }

  // Widget CarouselView(int index) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (BuildContext context) => NewsScreen(
  //                 title: newsList[index].title,
  //                 imageUrl: newsList[index].url,
  //                 description: newsList[index].description,
  //                 url: newsList[index].urlPage,
  //                 name: newsList[index].name,
  //                 darkMode: isDarkMode,
  //               )));
  //     },
  //     child: Stack(
  //       alignment: Alignment.bottomLeft,
  //       children: <Widget>[
  //         Center(child: Image.network(newsList[index].url,fit: BoxFit.cover,)),
  //         Container(
  //           padding: EdgeInsets.fromLTRB(
  //               2 * 2.36.w, 2 * 2.36.h, 2 * 2.36.w, 2 * 2.36.h),
  //           decoration: BoxDecoration(
  //             color: Colors.black.withOpacity(0.5),
  //           ),
  //           child: Text(
  //             newsList[index].title,
  //             style: TextStyle(
  //                 fontFamily: fontFamily,
  //                 color: whiteColor,
  //                 fontSize: 16 * 2.36.sp,
  //                 fontWeight: FontWeight.w700),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class NewsData {
  String title;
  String description;
  String urlPage;
  String imageUrl;
  String pubDate;

  NewsData(
      this.title, this.description, this.urlPage, this.imageUrl, this.pubDate);
}
