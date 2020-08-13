import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'util/resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Animation/FadeAnimation.dart';
import 'newsScreen.dart';

import 'dart:async';

class CategoryScreen extends StatefulWidget {
  String seletecdCategory;
  String categoryUrl;
  bool darkMode;
  CategoryScreen({this.seletecdCategory,this.darkMode,this.categoryUrl});
  @override
  _CategoryScreenState createState() => _CategoryScreenState(selectedCategory: seletecdCategory,categoryUrl: categoryUrl ,darkMode: darkMode);
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  String selectedCategory;
  String categoryUrl;
  bool darkMode;
  _CategoryScreenState({this.selectedCategory,this.categoryUrl,this.darkMode});
  List<NewsData> newsList = List();
  List<NewsData> temp = List();
  String status = "";
  List<String> categoryLink = [
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F4719148.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F66949542.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F1898055.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F2886704.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F1081479906.cms',
    'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Frssfeeds%2F3908999.cms',
  ];
  List<String> category = [
    'Sports',
    'Tech',
    'Business',
    'Life & Style',
    'Entertainment',
    'Health'
  ];

  void getNews() async {
    String url;
    for(int i=0;i<category.length;i++)
    {
      if(selectedCategory == category[i]){
        url = categoryLink[i];
      }
    }
    var res = await http.get(url);
    var resBody = json.decode(res.body);
    for (var n in resBody["items"]) {
      String imgTemp ='https://static.toiimg.com/thumb/msid-76635241,width-535,height-290,imgsize-377478,resizemode-75,overlay-toi_sw,pt-0,y_pad-40/photo.jpg';
      NewsData temp1 = NewsData(
          n["title"].toString(),
          n["description"].toString(),
          n["link"].toString(),
          n["pubDate"].toString(),
          'https://static.toiimg.com/thumb/msid-'+n["link"].toString().substring(n["link"].toString().lastIndexOf('/')+1,n["link"].toString().lastIndexOf('.cms'))+',width-1070,height-580,imgsize-377478,resizemode-75,overlay-toi_sw,pt-0,y_pad-40/photo.jpg'
          );
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

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkMode==true?darkModeColor :whiteColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30 * 2.36.sp,
              color: darkMode==true? bgLight :fontDark,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          
          title: Text(
            selectedCategory,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: fontFamily,
                color: darkMode==true? bgLight :fontDark,
                fontSize: 30 * 2.36.sp,
                fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: darkMode==true? darkModeColor : whiteColor,
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
                        Expanded(
                          child: FadeAnimation(
                            1.4,
                            ListView.builder(
                              itemCount: newsList.length,
                              itemBuilder: (context, index) {
                                
                                return InkWell(
                                  onTap: () {
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
                                                  darkMode: darkMode,
                                                )));
                                  },
                                  child: Card(
                                    color: darkMode==true?  bgLightDark : bgLight,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: darkMode==true? bgLightDark : bgLight,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: 150 * 2.36.h,
                                                height: 150 * 2.36.h,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      topLeft: Radius.circular(10)),
                                                  child: Image(
                                                    fit: BoxFit.cover,
                                                    image: newsList[index].imageUrl == null ? NetworkImage('https://thumbs.dreamstime.com/b/no-image-available-icon-photo-camera-flat-vector-illustration-132483141.jpg'):NetworkImage(
                                                        newsList[index].imageUrl),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10*2.36.w,),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: 250 * 2.36.sp,
                                                    child: Text(
                                                      newsList[index].title,
                                                      style: TextStyle(
                                                          fontFamily: fontFamily,
                                                          color: darkMode==true? bgLight : fontDark,
                                                          fontSize: 20 * 2.36.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50 * 2.36.h,
                        )
                      ],
                    )
                  : Center(
                      child: SpinKitWave(
                        color: primaryColor,
                        size: 100 * 2.36.sp,
                      ),
                    )),
        ),
      ),
    );
  }
}

class NewsData {
  String title;
  String description;
  String urlPage;
  String imageUrl;
  String pubDate;
  NewsData(this.title, this.description,this.urlPage,this.pubDate,this.imageUrl);
}

