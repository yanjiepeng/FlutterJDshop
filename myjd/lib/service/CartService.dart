import 'dart:convert';

import 'package:myjd/model/ProductContentModel.dart';
import 'package:myjd/service/Storage.dart';
import 'Storage.dart';

class CartService {
  static addCart(ProductContentItem item) async {
    var res = formatData(item);

    try {
      List cartList = json.decode(await Storage.getString('cartList'));

      //判断购物车是否有当前加入的商品数据
      bool hasData = cartList.any((value) {
        if ((value['-Id'] == res['_id']) &&
            (value['selectAttr'] == res['selectAttr'])) {
          return true;
        } else {
          return false;
        }
      });

      if (hasData) {
        //有数据 让对应的count+1
        for (var i = 0; i < cartList.length; i++) {
          if ((cartList[i]['-Id'] == res['_id']) &&
              (cartList[i]['selectAttr'] == res['selectAttr'])) {
            cartList[i]['count'] += 1;
          }
        }
        //重新写入本地存储
        await Storage.setString('cartList', json.encode(cartList));
      } else {
        cartList.add(res);
        //重新写入本地存储
        await Storage.setString('cartList', json.encode(cartList));
      }
    } catch (e) {
      //本地数据没有数据 加入本地存储
      List tempList = [];
      tempList.add(res);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  //过滤数据 将所提交到购物车需要的数据转换为MAP
  static formatData(ProductContentItem item) {
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectAttr'] = item.selectAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    //是否选中
    data['checked'] = true;
    return data;
  }

/*
      1、获取本地存储的cartList数据
      2、判断cartList是否有数据
            有数据：
                1、判断购物车有没有当前数据：
                        有当前数据：
                            1、让购物车中的当前数据数量 等于以前的数量+现在的数量
                            2、重新写入本地存储

                        没有当前数据：
                            1、把购物车cartList的数据和当前数据拼接，拼接后重新写入本地存储。

            没有数据：
                1、把当前商品数据以及属性数据放在数组中然后写入本地存储



                List list=[
                  {"_id": "1",
                    "title": "磨砂牛皮男休闲鞋-有属性",
                    "price": 688,
                    "selectedAttr": "牛皮 ,系带,黄色",
                    "count": 4,
                    "pic":"public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png",
                    "checked": true
                  },
                    {"_id": "2",
                    "title": "磨xxxxxxxxxxxxx",
                    "price": 688,
                    "selectedAttr": "牛皮 ,系带,黄色",
                    "count": 2,
                    "pic":"public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png",
                    "checked": true
                  }

                ];


      */

}
