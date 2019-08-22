
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ScreenAdapter{

  static init(context){
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }
  static height(double value){
     return ScreenUtil.getInstance().setHeight(value);
  }
  static width(double value){
      return ScreenUtil.getInstance().setWidth(value);
  }
  static getScreenHeight(){
    return ScreenUtil.screenHeightDp;
  }
  static getScreenWidth(){
    return ScreenUtil.screenWidthDp;
  }

  static getScreenPxWidth(){
    return ScreenUtil.screenWidth;
  }

  static getScreenPxHeight(){
    return ScreenUtil.screenHeight;
  }

  static size(double value){
    return ScreenUtil.getInstance().setSp(value);
  }
  // ScreenUtil.screenHeight
  //简单封装获取宽高 
}
