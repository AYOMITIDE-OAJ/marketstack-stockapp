import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:marketstackapi/api/api_service.dart';
import 'package:marketstackapi/models/stock.dart';
import 'package:marketstackapi/repository/marketstack_repositories.dart';
import 'package:marketstackapi/models/tickers.dart';
import 'package:marketstackapi/marketstackapi.dart';

class MockHttpClient extends Mock implements http.Client{}

void main() {
  group('MarketStackApiClient', () {
    late MarketStackApiClient marketStackApiClient;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      marketStackApiClient = MarketStackApiClient(httpClient: mockHttpClient);
    });

    test('getStockData returns a list of stocks', () async {
      final mockTickerResponse = http.Response('''
        {
          "data": [
            { "symbol": "AAPL", "name": "Apple Inc." },
            { "symbol": "GOOGL", "name": "Alphabet Inc." }
          ]
        }
      ''', 200);

      final mockStockResponse = http.Response('''
        {
          "data": [
            {
              "symbol": "AAPL",
              "open": 100.0,
              "high": 110.0,
              "low": 90.0,
              "close": 105.0,
              "volume": 1000000,
              "adj_high": 109.0,
              "adj_low": 89.0,
              "adj_close": 104.0,
              "adj_open": 99.0,
              "adj_volume": 900000,
              "split_factor": 1.0,
              "dividend": 0.5,
              "exchange": "NASDAQ",
              "date": "2022-01-01"
            }
          ]
        }
      ''', 200);

      when(() => mockHttpClient.get(Uri.parse('http://api.marketstack.com/v1/tickers?access_key=afd3a8e404b1fdbbf1bb0062c0fada8a&limit=10')))
          .thenAnswer((_) async => mockTickerResponse);

      when(() => mockHttpClient.get(Uri.parse('http://api.marketstack.com/v1/intraday?access_key=afd3a8e404b1fdbbf1bb0062c0fada8a&symbols=AAPL,GOOGL&limit=10')))
          .thenAnswer((_) async => mockStockResponse);

      final stocks = await marketStackApiClient.getStockData();

      expect(stocks.length, 1);
      expect(stocks[0].symbol, 'AAPL');
      expect(stocks[0].name, 'Apple Inc.');
      // Add more assertions for other properties as needed
    });

    test('getStockData throws StockRequestFailure when ticker API call fails', () async {
      when(() => mockHttpClient.get(Uri.parse('http://api.marketstack.com/v1/tickers?access_key=afd3a8e404b1fdbbf1bb0062c0fada8a&limit=10')))
          .thenAnswer((_) async => http.Response('Error', 500));

      expect(() => marketStackApiClient.getStockData(), throwsA(isA<StockRequestFailure>()));
    });

    test('getStockData throws StockNotFoundFailure when ticker data is not found', () async {
      final mockTickerResponse = http.Response('{"data": []}', 200);

      when(() => mockHttpClient.get(Uri.parse('http://api.marketstack.com/v1/tickers?access_key=afd3a8e404b1fdbbf1bb0062c0fada8a&limit=10')))
          .thenAnswer((_) async => mockTickerResponse);

      expect(() => marketStackApiClient.getStockData(), throwsA(isA<StockNotFoundFailure>()));
    });

    // Add more tests for other scenarios as needed
  });

  // Testing the repository Class

  group('StockRepository', () {
    late StockRepository stockRepository;
    late MarketStackApiClient mockMarketStackApiClient;

    setUp(() {
      mockMarketStackApiClient = MockMarketStackApiClient();
      stockRepository = StockRepository(marketStackApiClient: mockMarketStackApiClient);
    });

    test('getStocksData returns a list of stocks', () async {
      final mockStocks = [
        Stock(
          symbol: 'AAPL',
          name: 'Apple Inc.',
          open: 100.0,
          high: 110.0,
          low: 90.0,
          close: 105.0,
          volume: 1000000,
          adj_high: 109.0,
          adj_low: 89.0,
          adj_close: 104.0,
          adj_open: 99.0,
          adj_volume: 900000,
          split_factor: 1.0,
          dividend: 0.5,
          exchange: 'NASDAQ',
          date: '2022-01-01',
        ),
      ];

      when(() => mockMarketStackApiClient.getStockData()).thenAnswer((_) async => mockStocks);

      final stocks = await stockRepository.getStocksData();

      expect(stocks.length, 1);
      expect(stocks[0].symbol, 'AAPL');
      expect(stocks[0].name, 'Apple Inc.');
      // Add more assertions for other properties as needed
    });


  });
}

class MockMarketStackApiClient extends Mock implements MarketStackApiClient {}

