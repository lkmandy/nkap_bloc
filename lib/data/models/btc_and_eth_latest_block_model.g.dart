// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'btc_and_eth_latest_block_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestBlockModel _$LatestBlockModelFromJson(Map<String, dynamic> json) =>
    LatestBlockModel(
      hash: json['hash'] as String?,
      time: json['time'] as int?,
      blockIndex: json['blockIndex'] as int?,
      height: json['height'] as int?,
      txIndexes:
          (json['txIndexes'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$LatestBlockModelToJson(LatestBlockModel instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'time': instance.time,
      'blockIndex': instance.blockIndex,
      'height': instance.height,
      'txIndexes': instance.txIndexes,
    };
