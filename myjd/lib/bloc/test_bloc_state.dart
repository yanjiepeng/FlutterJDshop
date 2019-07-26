import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:myjd/model/Test.dart';

@immutable
abstract class TestBlocState extends Equatable {
  TestBlocState([List props = const []]) : super(props);
}

class TestInitial extends TestBlocState {

}

class TestLoading extends TestBlocState {

}

class TestLoaded extends TestBlocState {
  final Test test;
  TestLoaded(this.test) : super([test]);

}