// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Stock',
  json,
      ($checkedConvert) {
    final val = Stock(
      adj_close:
      $checkedConvert('adj_close', (v) => (v as num?)?.toDouble()),
      adj_open: $checkedConvert('adj_open', (v) => (v as num?)?.toDouble()),
      open: $checkedConvert('open', (v) => (v as num?)?.toDouble()),
      high: $checkedConvert('high', (v) => (v as num?)?.toDouble()),
      low: $checkedConvert('low', (v) => (v as num?)?.toDouble()),
      close: $checkedConvert('close', (v) => (v as num?)?.toDouble()),
      volume: $checkedConvert('volume', (v) => (v as num?)?.toDouble()),
      adj_high: $checkedConvert('adj_high', (v) => (v as num?)?.toDouble()),
      adj_low: $checkedConvert('adj_low', (v) => (v as num?)?.toDouble()),
      adj_volume:
      $checkedConvert('adj_volume', (v) => (v as num?)?.toDouble()),
      split_factor:
      $checkedConvert('split_factor', (v) => (v as num?)?.toDouble()),
      dividend: $checkedConvert('dividend', (v) => (v as num?)?.toDouble()),
      symbol: $checkedConvert('symbol', (v) => v as String?),
      exchange: $checkedConvert('exchange', (v) => v as String?),
      name: $checkedConvert('name', (v) => v as String?),
      date: $checkedConvert('date', (v) => v as String?),
    );
    return val;
  },
);
