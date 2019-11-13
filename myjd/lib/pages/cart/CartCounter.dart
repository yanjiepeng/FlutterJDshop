import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(

      width: ScreenAdapter.width(165),
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Colors.black12
        ),

      ),
      child: Row(
        children: <Widget>[

          _leftBtn(),
          _centerInput(),
          _rightBtn()

        ],


      ),
    );
  }

  Widget _leftBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        alignment: Alignment.center,
        child: Text('-'),
      )
    );
  }

  Widget _rightBtn() {
    return InkWell(
      onTap: () {

      },
      child: Container(
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        alignment: Alignment.center,
        child: Text('+'),
      ),
    );
  }

  Widget _centerInput() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                width: 1,
                color: Colors.black12
            ),
            right: BorderSide(
                width: 1,
                color: Colors.black12
            ),

          )
      ),
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.height(45),
      alignment: Alignment.center,
      child: Text('1'),
    );
  }
}
