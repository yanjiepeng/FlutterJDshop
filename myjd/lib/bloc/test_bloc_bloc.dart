import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:myjd/model/Test.dart';
import './bloc.dart';

class TestBlocBloc extends Bloc<TestBlocEvent, TestBlocState> {
  @override
  TestBlocState get initialState => TestInitial();

  @override
  Stream<TestBlocState> mapEventToState(TestBlocEvent event,) async* {
    // TODO: Add Logic

    if (event is GetWeather) {
      //yield 表示TestLoading执行完后 数据立即传到stream中
      yield TestLoading();

      final test = await _fetchDataFromApi(event.cityName);

      yield TestLoaded(test);
    }
  }

  _fetchDataFromApi(String cityName) {
    return Future.delayed(
        Duration(seconds: 1),
            () {
          return Test(
              cityName: cityName,
              temperature: 20 + Random().nextInt(15) + Random().nextDouble(),
          );
        }
    );
  }
}
