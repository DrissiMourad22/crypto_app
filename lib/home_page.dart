import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/data/crypto_data.dart';
import 'package:crypto_app/modules/crypto_presenter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements CryptoListViewContract {
  late CryptoListPresenter _presenter;
  late List<Crypto> _currencies;
  late bool _isLoading;
  // ignore: unused_field
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

   
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Crypto App"),
          elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            :ListView.builder(
          itemCount: _currencies.length,
          itemBuilder: (BuildContext context,int index)=>
              _getRowWithDivider(index),)
    );
  }

  Widget _getRowWithDivider(int i) {
    final Crypto currency = _currencies[i];
    var children = <Widget>[
      Padding(
          padding: const EdgeInsets.all(10.0),
          child: _getListItemUi(currency)
      ),
      const Divider(height: 5.0),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  ListTile _getListItemUi(Crypto currency) {
    return ListTile(
      leading: FadeInImage(placeholder: const AssetImage('assets/2.0x/stars.png'), image: NetworkImage("http://cryptoicons.co/32@2x/color/${currency.symbol.toLowerCase()}@2x.png")),
      title: Text(currency.name,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
      _getSubtitleText(currency.price_usd, currency.percent_change_1h),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = TextSpan(
        text: "\$$priceUSD\n", style: const TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText,
          style: const TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText, style: const TextStyle(color: Colors.red));
    }

    return RichText(
        text: TextSpan(
            children: [priceTextWidget, percentageChangeTextWidget]));
  }

  @override
  void onLoadCryptoComplete(List<Crypto> items) {
 
    setState(() {
      _currencies = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadCryptoError() {
   }
}
