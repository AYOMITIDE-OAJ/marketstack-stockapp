import 'package:get_it/get_it.dart';
import 'package:marketstackapi/marketstackapi.dart';

class DiContainer {
  static final getIt = GetIt.instance;

  DiContainer(){
    _setUp();
  }

  _setUp(){
    getIt.registerLazySingleton<StockRepository>(() => StockRepository());
  }
}