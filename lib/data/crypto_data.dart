import 'dart:async';

class Crypto {
  String name;
  // ignore: non_constant_identifier_names
  String price_usd;
  // ignore: non_constant_identifier_names
  String percent_change_1h;
  String symbol;

  // ignore: non_constant_identifier_names
  Crypto({required this.name, required this.price_usd, required this.percent_change_1h,required this.symbol});

  Crypto.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        price_usd = map['price_usd'],
        percent_change_1h = map['percent_change_1h'],
        symbol = map['symbol'];
}

abstract class CryptoRepository {
  Future<List<Crypto>> fetchCurrencies();
}

class FetchDataException implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final _message;

  FetchDataException([this._message]);

  @override
  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
