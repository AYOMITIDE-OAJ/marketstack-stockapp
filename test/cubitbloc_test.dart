// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:marketstackapi/models/stock.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_app/stock/cubit/stock_cubit.dart';
import 'package:marketstackapi/repository/marketstack_repositories.dart';
import 'package:stock_app/main.dart';


class MockStockRepository extends Mock implements StockRepository {}

void main() {
  group('StockCubit', () {
    late StockRepository stockRepository;
    late StockCubit stockCubit;

    setUp(() {
      stockRepository = MockStockRepository();
      stockCubit = StockCubit(stockRepository);
    });

    test('initial state is correct', () {
      expect(stockCubit.state, const StockState());
    });

    group('getStockData', () {
      final stocks = [
        Stock(/* stock data */),
        Stock(/* stock data */),
      ];

      test('emits loading and success states with stocks', () {
        when(stockRepository.getStocksData(
            dateFrom: anyNamed('dateFrom'), dateTo: anyNamed('dateTo')))
            .thenAnswer((_) async => stocks);

        final expectedStates = [
          const StockState(status: StockStatus.loading),
          StockState(status: StockStatus.success, stock: stocks),
        ];

        expectLater(stockCubit, emitsInOrder(expectedStates));

        stockCubit.getStockData(dateFrom: '2021-01-01', dateTo: '2021-01-31');
      });

      test('emits loading and failure states when an exception occurs', () {
        when(stockRepository.getStocksData(
            dateFrom: anyNamed('dateFrom'), dateTo: anyNamed('dateTo')))
            .thenThrow(Exception());

        final expectedStates = [
          const StockState(status: StockStatus.loading),
          const StockState(status: StockStatus.failure),
        ];

        expectLater(stockCubit, emitsInOrder(expectedStates));

        stockCubit.getStockData(dateFrom: '2021-01-01', dateTo: '2021-01-31');
      });
    });

    group('searchStock', () {
      final stocks = [
        Stock(symbol: 'AAPL'),
        Stock(symbol: 'GOOG'),
        Stock(symbol: 'TSLA'),
      ];

      test('emits success state with filtered stocks', () {
        stockCubit.emit(StockState(status: StockStatus.success, stock: stocks));

        stockCubit.searchStock(stocks, 'AAPL');

        expect(stockCubit.state.stock, [Stock(symbol: 'AAPL')]);
      });

      test('emits failure state when an exception occurs', () {
        stockCubit.emit(StockState(status: StockStatus.success, stock: stocks));

        stockCubit.searchStock(stocks, '');

        expect(stockCubit.state.status, StockStatus.failure);
      });
    });
  });
}
