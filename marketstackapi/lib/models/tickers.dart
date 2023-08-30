import 'package:json_annotation/json_annotation.dart';

part 'tickers.g.dart';

@JsonSerializable()
class Tickers{
  final String? name;
  final String? symbol;

  const Tickers({this.name, this.symbol});

  factory Tickers.fromJson(Map<String, dynamic> json) => _$TickersFromJson(json);
}
