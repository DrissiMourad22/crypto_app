import 'package:crypto_app/data/crypto_data.dart';
import 'package:crypto_app/data/crypto_data_mock.dart';
import 'package:crypto_app/data/crypto_data_prod.dart';
 
// ignore: constant_identifier_names
enum Flavor { MOCK, PROD }

//DI
class Injector {
  static final Injector _singleton = Injector._internal();
  // ignore: non_constant_identifier_names
  late Flavor _flavor;

   void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  CryptoRepository get cryptoRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return MockCryptoRepository();
      default:
        return ProdCryptoRepository();
    }
  }
}
