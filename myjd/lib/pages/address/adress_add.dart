import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/widet/JdButton.dart';
import 'package:myjd/widet/JdInputText.dart';
import 'package:city_pickers/city_pickers.dart';

class AddAdressPage extends StatefulWidget {
  @override
  _AddAdressPageState createState() => _AddAdressPageState();
}

class _AddAdressPageState extends State<AddAdressPage> {
  String area = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加收货地址'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 12),
        child: ListView(
          children: <Widget>[
            JdInputText(
              text: '收货人姓名',
              password: false,
            ),
            SizedBox(
              height: 10,
            ),
            JdInputText(
              text: '收货人电话',
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: ScreenAdapter.height(68),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    this.area.length > 0
                        ? Text(
                            this.area,
                            style: TextStyle(color: Colors.black54),
                          )
                        : Text(
                            '省市区',
                            style: TextStyle(color: Colors.black54),
                          )
                  ],
                ),
                onTap: () async {
              // type 1
                Result result = await CityPickers.showCityPicker(
                  context: context,
                  cancelWidget: Text('取消', style:TextStyle(color: Colors.black54)),
                  confirmWidget: Text('确定',style:TextStyle(color:Colors.black54))

                );

                setState(() {
                  this.area = result.provinceName + result.cityName + result.areaName ; 
                });
              },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            JdInputText(
              text: '详细地址',
              maxLines: 3,
              height: 200.0,
            ),
            SizedBox(
              height: 10,
            ),
          
            SizedBox(
              height: 40,
            ),
            JdButton(
              text: '增加',
              color: Colors.red,
            )
          ],
        ),
      ),
    );
    ;
  }
}
