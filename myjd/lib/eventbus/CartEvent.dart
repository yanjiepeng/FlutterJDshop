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

class UserEvent {
  String str;
  UserEvent(this.str);
}

class AddressEvent {
  String str;
  AddressEvent(this.str);
}

class DefaultAddressEvent {
  String str ;
  DefaultAddressEvent(this.str);
}