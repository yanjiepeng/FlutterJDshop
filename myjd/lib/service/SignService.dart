
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SignService {
//转换 API数据 到签名检验 API数据
  static getSign(json) {
    Map addressListAttr = {"uid": '1', "age": 10, "salt": 'xxxxxxxx'};

    var attrKeys = addressListAttr.keys.toList();

    attrKeys.sort();

    print(attrKeys);

    String str = '';

    for (var i = 0; i < attrKeys.length; i++) {
      str += '${attrKeys[i]}${addressListAttr[attrKeys[i]]}';
    }

    print(str);

    //调用MD5加密
    print (md5.convert(utf8.encode(str)));



  }
}
