import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Test extends Equatable {
  final String cityName;
  final double temperature;

  Test({@required this.cityName, @required this.temperature})
      : super([cityName, temperature]);
}
