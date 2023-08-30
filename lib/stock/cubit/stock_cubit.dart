import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marketstackapi/marketstackapi.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'stock_state.dart';


class StockCubit extends Cubit<StockState> {
  final StockRepository _stockRepository;

  StockCubit(this._stockRepository) : super(const StockState());

  Future<void> getStockData({String? dateFrom, String? dateTo, int? limit}) async {
    emit(state.copyWith(status: StockStatus.loading));

    try {
      final stock = await _stockRepository.getStocksData(dateFrom: dateFrom, dateTo: dateTo);
      emit(state.copyWith(status: StockStatus.success, stock: stock));
    } on Exception {
      emit(state.copyWith(status: StockStatus.failure));
    }
  }

 void searchStock(List<Stock> stocks, String query){
    try{
      final result = stocks.where((element) => element.symbol!.contains(query.toUpperCase())).toList();
      emit(state.copyWith(status: StockStatus.success, stock: result));
    } on Exception {
      emit(state.copyWith(status: StockStatus.failure));
    }
  }
}