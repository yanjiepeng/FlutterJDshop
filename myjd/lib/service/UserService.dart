import 'dart:convert';
import 'Storage.dart';
class UserService {
  static getUserInfo() async {
    List userInfo;
    try {
      userInfo = json.decode(await Storage.getString('userInfo'));
      return userInfo;
    } catch (e) {
      return [];
    }
  }

  //获取用户是否登录状态
  static getUserLoginState() async {
    var userInfo = await UserService.getUserInfo();
    return (userInfo.length > 0 && userInfo[0]['username'] != '');
  }

  //用户退出登录
  static loginOut() {
    Storage.remove('userInfo');
  }
}
