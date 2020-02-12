
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SignService {
//转换 API数据 到签名检验 API数据
  static String getSign(json) {

    var attrKeys = json.keys.toList();

    attrKeys.sort();

    String str = '';

    for (var i = 0; i < attrKeys.length; i++) {
      str += '${attrKeys[i]}${json[attrKeys[i]]}';
    }


    //调用MD5加密
    

    return  (md5.convert(utf8.encode(str))).toString();
    
  }
}
