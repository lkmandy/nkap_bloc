import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:nkap/data/models/btc_eth_transactons_model.dart';

part 'btc_and_eth_latest_transaction_model.g.dart';

LatestTransactionsModel latestTransactionsModelFromJson(String str) =>
    LatestTransactionsModel.fromJson(json.decode(str));
String latestTransactionsModelToJson(LatestTransactionsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class LatestTransactionsModel {
  LatestTransactionsModel({
    required this.hash,
    required this.transactions,
    required this.numberOfTransactions,
    required this.time,
    required this.fee,
    required this.size,
  });

  String hash;
  @JsonKey(name: 'tx')
  List<BtcEthTransactionsModel> transactions;
  @JsonKey(name: 'n_tx')
  int numberOfTransactions;
  int time;
  int fee;
  int size;

  factory LatestTransactionsModel.fromJson(Map<String, dynamic> json) =>
      _$LatestTransactionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LatestTransactionsModelToJson(this);
}
