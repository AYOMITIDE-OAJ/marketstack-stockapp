import 'package:marketstackapi/marketstackapi.dart';

class StockRepository {
  final MarketStackApiClient _stockApiClient;
  StockRepository({MarketStackApiClient? marketStackApiClient}) : _stockApiClient = marketStackApiClient ?? MarketStackApiClient();

  Future<List<Stock>> getStocksData({String? dateFrom, String? dateTo}) async {
    return await _stockApiClient.getStockData(date_from: dateFrom, date_to: dateTo);
  }
}