import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TestBlocEvent extends Equatable {
  TestBlocEvent([List props = const []]) : super(props);
}


class GetWeather extends TestBlocEvent {
  final String cityName;

  //如果有两个实例 他们的cityName一样 那么 这两个实例相等 在super传入要判断的参数

  //Equatable allows for a simple value equality in dart .
  //All you need to do is to pass the class fields to the super constructor
  GetWeather(this.cityName) : super([cityName]);

}