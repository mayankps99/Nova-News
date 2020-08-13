import 'package:flutter/material.dart';
import 'util/resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'mainScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MainScreen())));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,allowFontScaling: true);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                  child: Container(
                    width: 450*2.36.w,
                    height: 450*2.36.w,
                    child: Column
                    (
                      children: <Widget>[
                        Container(
                          width: 300*2.36.w,
                          height: 300*2.36.w,
                          child: Image(
                            image: AssetImage('assets/logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                
                child: Center(
                        child: SpinKitChasingDots(
                          color: whiteColor,
                          size: 50 * 2.36.sp,
                        ),
                      ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10*2.36.h),
            child: Text(
              '',
              style: TextStyle(
                fontFamily: fontFamily,
                color: whiteColor,
                fontSize: 18*2.36.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}