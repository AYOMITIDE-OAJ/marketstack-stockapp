// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tickers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tickers _$TickersFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Tickers',
  json,
      ($checkedConvert) {
    final val = Tickers(
      name: $checkedConvert('name', (v) => v as String?),
      symbol: $checkedConvert('symbol', (v) => v as String?),
    );
    return val;
  },
);
