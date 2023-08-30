import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:marketstackapi/models/tickers.dart';
import '../marketstackapi.dart';

final _accessKey = 'afd3a8e404b1fdbbf1bb0062c0fada8a';

class StockRequestFailure implements Exception {}

class StockNotFoundFailure implements Exception {}

class MarketStackApiClient {
  final http.Client _httpClient;

  MarketStackApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final String _baseUrlWeather = 'http://api.marketstack.com/v1';

  Future<List<Stock>> getStockData({String? date_from, String? date_to}) async {
    final tickersResponse = await _httpClient.get(
        Uri.parse("$_baseUrlWeather/tickers?access_key=$_accessKey&limit=10"));

    if (tickersResponse.statusCode != 200) {
      throw StockRequestFailure();
    }

    final tickerJson = jsonDecode(tickersResponse.body) as Map<String, dynamic>;
    if (!tickerJson.containsKey('data')) throw StockNotFoundFailure();

    final tickersResult = tickerJson['data'] as List<dynamic>;
    if (tickersResult.isEmpty) throw StockNotFoundFailure();

    final tickers = tickersResult.map((data) =>
        Tickers.fromJson(data as Map<String, dynamic>)).toList();

    final stockSymbols = tickers.map((i) => i.symbol).toList();

    final stockResponse = await _httpClient.get(Uri.parse(
        "$_baseUrlWeather/intraday?access_key=$_accessKey&symbols=${stockSymbols
            .join(',')}&limit=10"));

    if (stockResponse.statusCode != 200) {
      throw StockRequestFailure();
    }

    final stockJson = jsonDecode(stockResponse.body) as Map <String, dynamic>;
    if (!stockJson.containsKey('data')) throw StockNotFoundFailure();


    final results = stockJson['data'] as List<dynamic>;
    if (results.isEmpty) throw StockNotFoundFailure();

    return results.map((data) {
      final stock = Stock.fromJson(data as Map<String, dynamic>);
      stock.name = tickers
          .firstWhere((i) => i.symbol == stock.symbol)
          .name;
      return stock;
    }).toList();
  }
}

