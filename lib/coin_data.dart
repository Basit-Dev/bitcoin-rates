import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'network_Helper.dart';

const List<String> currenciesList = [
  'USD',
  'AUD',
  'BRL',
  'CAD',
  'CHF',
  'CLP',
  'CNY',
  'DKK',
  'EUR',
  'GBP',
  'HKD',
  'INR',
  'ISK',
  'JPY',
  'KRW',
  'NZD',
  'PLN',
  'RUB',
  'SEK',
  'SGD',
  'THB',
  'TRY',
  'TWD'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String blockChainURL = 'https://blockchain.info/ticker';
  String getSymbol;
  var getBTCTicker;

  Future<dynamic> getData() async {
    NetworkHelper networkHelper = NetworkHelper(url: blockChainURL);
    var getJsonData = await networkHelper.getURL();
    return getJsonData;
  }

  Future<String> getResult(String currencySymbol) async {
    var getJsonResult = await getData();
    getBTCTicker = getJsonResult['$currencySymbol']['buy'];
    String resultToString = getBTCTicker.toStringAsFixed(2);
    return resultToString;
  }

  Future<String> getETH(String currencySymbol) async {
    var getJsonResult = await getData();
    getBTCTicker = getJsonResult['$currencySymbol']['symbol'];
    String resultToString = getBTCTicker;
    return resultToString;
  }
}
