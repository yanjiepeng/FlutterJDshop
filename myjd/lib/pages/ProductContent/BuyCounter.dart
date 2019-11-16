import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';

class BuyCounter extends StatefulWidget {
  final _productContent;

  BuyCounter(this._productContent, {Key key}) : super(key: key);

  @override
  _BuyCounterState createState() => _BuyCounterState();
}

class _BuyCounterState extends State<BuyCounter> {
  var _productContent;

  @override
  void initState() {
    super.initState();

    this._productContent = widget._productContent;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      width: ScreenAdapter.width(165),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[_leftBtn(), _centerInput(), _rightBtn()],
      ),
    );
  }

  Widget _leftBtn() {
    return InkWell(
        onTap: () {
          setState(() {
            if (this._productContent.count > 1) {
              this._productContent.count -= 1;
            }
          });
        },
        child: Container(
          width: ScreenAdapter.width(45),
          height: ScreenAdapter.height(45),
          alignment: Alignment.center,
          child: Text('-'),
        ));
  }

  Widget _rightBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          this._productContent.count += 1;
        });
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
        left: BorderSide(width: 1, color: Colors.black12),
        right: BorderSide(width: 1, color: Colors.black12),
      )),
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.height(45),
      alignment: Alignment.center,
      child: Text('${this._productContent.count}'),
    );
  }
}
