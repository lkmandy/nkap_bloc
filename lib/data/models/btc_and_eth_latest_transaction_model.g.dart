// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'btc_and_eth_latest_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestTransactionsModel _$LatestTransactionsModelFromJson(
        Map<String, dynamic> json) =>
    LatestTransactionsModel(
      hash: json['hash'] as String,
      transactions: (json['tx'] as List<dynamic>)
          .map((e) =>
              BtcEthTransactionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfTransactions: json['n_tx'] as int,
      time: json['time'] as int,
      fee: json['fee'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$LatestTransactionsModelToJson(
        LatestTransactionsModel instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'tx': instance.transactions,
      'n_tx': instance.numberOfTransactions,
      'time': instance.time,
      'fee': instance.fee,
      'size': instance.size,
    };
