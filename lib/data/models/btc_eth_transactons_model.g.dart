// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'btc_eth_transactons_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BtcEthTransactionsModel _$BtcEthTransactionsModelFromJson(
        Map<String, dynamic> json) =>
    BtcEthTransactionsModel(
      transactionHash: json['hash'] as String,
      transactionAmount: json['fee'] as int,
      transactionIndex: json['tx_index'] as int,
      transactionTimestamp: json['time'] as int,
    );

Map<String, dynamic> _$BtcEthTransactionsModelToJson(
        BtcEthTransactionsModel instance) =>
    <String, dynamic>{
      'hash': instance.transactionHash,
      'fee': instance.transactionAmount,
      'tx_index': instance.transactionIndex,
      'time': instance.transactionTimestamp,
    };
