import 'package:event_bus/event_bus.dart';

// Eventbus初始化
EventBus eventBus = new EventBus();

class CartEvent {
  String msg;

  CartEvent(this.msg);
}

class EditEvent {
  bool flag;

  EditEvent(this.flag);
}

class TabEvent {
  int index;

  TabEvent(this.index);
}
