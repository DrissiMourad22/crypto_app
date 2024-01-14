import 'dart:async' show Future;
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:crypto_app/data/crypto_data.dart';

class ProdCryptoRepository implements CryptoRepository {
  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
  @override
  Future<List<Crypto>> fetchCurrencies() async {
     var cryptoUrl2 = cryptoUrl;
    http.Response response = await http.get(cryptoUrl2 as Uri);
    final List responseBody = json.decode(response.body);
    final statusCode = response.statusCode;
    // ignore: unnecessary_null_comparison
    var bool = null == responseBody;
    if (statusCode != 200 || bool) {
      throw FetchDataException(
          "An error ocurred : [Status Code : $statusCode]");
    }

    return responseBody.map((c) => Crypto.fromMap(c)).toList();
  }
}
