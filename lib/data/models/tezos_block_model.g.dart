// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tezos_block_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TezosBlockModel _$TezosBlockModelFromJson(Map<String, dynamic> json) =>
    TezosBlockModel(
      hash: json['hash'] as String,
      level: json['level'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      cycle: json['cycle'] as int,
      fees: json['fees'] as int,
      deposit: json['deposit'] as int,
    );

Map<String, dynamic> _$TezosBlockModelToJson(TezosBlockModel instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'level': instance.level,
      'timestamp': instance.timestamp.toIso8601String(),
      'cycle': instance.cycle,
      'fees': instance.fees,
      'deposit': instance.deposit,
    };
