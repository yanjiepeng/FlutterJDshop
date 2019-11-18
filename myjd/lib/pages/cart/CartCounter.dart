import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartCounter extends StatefulWidget {
  Map value;

  CartCounter(this.value);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  Map _itemData;

  Cart provider;

  @override
  void initState() {
    super.initState();
    _itemData = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    provider = Provider.of<Cart>(context);

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
          if (_itemData['count'] > 1) {
            setState(() {
              _itemData['count']--;
            });
            this.provider.changeItemCount();
          }
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
          _itemData['count']++;
        });

        this.provider.changeItemCount();
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
      child: Text('${_itemData['count']}'),
    );
  }
}
