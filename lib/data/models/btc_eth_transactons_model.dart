import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'btc_eth_transactons_model.g.dart';

BtcEthTransactionsModel tezosTransactionsModelFromJson(String str) =>
    BtcEthTransactionsModel.fromJson(json.decode(str));
String tezosTezosTransactionsModelToJson(BtcEthTransactionsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class BtcEthTransactionsModel {
  BtcEthTransactionsModel({
    required this.transactionHash,
    required this.transactionAmount,
    required this.transactionIndex,
    required this.transactionTimestamp,
  });
  @JsonKey(name: 'hash')
  String transactionHash;
  @JsonKey(name: 'fee')
  int transactionAmount;
  @JsonKey(name: 'tx_index')
  int transactionIndex;
  @JsonKey(name: 'time')
  int transactionTimestamp;

  factory BtcEthTransactionsModel.fromJson(Map<String, dynamic> json) =>
      _$BtcEthTransactionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BtcEthTransactionsModelToJson(this);
}
