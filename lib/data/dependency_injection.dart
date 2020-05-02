import 'package:fluttermvpillustrativeapp/data/xkcd_data.dart';
import 'package:fluttermvpillustrativeapp/data/xkcd_data_mock.dart';
import 'package:fluttermvpillustrativeapp/data/xkcd_data_prod.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  XKCDRepo get xkcdRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return MockXKCDRepository();
      default:
        return ProdXKCDRepo();
    }
  }
}
