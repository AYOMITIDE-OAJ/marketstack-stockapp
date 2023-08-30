import 'package:json_annotation/json_annotation.dart';

part 'stock.g.dart';

@JsonSerializable()
class Stock {
  final double? open;
  final double? high;
  final double? low;
  final double? close;
  final double? volume;
  final double? adj_high;
  final double? adj_low;
  final double? adj_close;
  final double? adj_open;
  final double? adj_volume;
  final double? split_factor;
  final double? dividend;
  final String? symbol;
  String? name;
  final String? exchange;
  final String? date;

  Stock({
    this.adj_close,
    this.adj_open,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.adj_high,
    this.adj_low,
    this.adj_volume,
    this.split_factor,
    this.dividend,
    this.symbol,
    this.exchange,
    this.name,
    this.date});

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);
}