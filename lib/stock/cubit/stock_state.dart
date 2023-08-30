part of 'stock_cubit.dart';

enum StockStatus{ initial, loading, success, failure }

extension StockStatusX on StockStatus {
  bool get isInitial => this == StockStatus.initial;
  bool get isLoading => this == StockStatus.loading;
  bool get isSuccess => this == StockStatus.success;
  bool get isFailure => this == StockStatus.failure;
}

class StockState extends Equatable {
  final StockStatus status;
  final List<Stock>? stock;

  const StockState({this.status = StockStatus.initial, this.stock});

  StockState copyWith({StockStatus? status, List<Stock>? stock}){
    return StockState(
        status: status ?? this.status,
        stock: stock ?? this.stock);
  }

  @override
  List<Object?> get props => [status, stock];
}

