import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'tezos_block_model.g.dart';

TezosBlockModel tezosBlockModelFromJson(String str) => TezosBlockModel.fromJson(json.decode(str));
String tezosBlockModelToJson(TezosBlockModel data) => json.encode(data.toJson());

@JsonSerializable()
class TezosBlockModel {
  TezosBlockModel({
    required this.hash,
    required this.level,
    required this.timestamp,
    required this.cycle,
    required this.fees,
    required this.deposit,
  });

  String hash;
  int level;
  DateTime timestamp;
  int cycle;
  int fees;
  int deposit;

  factory TezosBlockModel.fromJson(Map<String, dynamic> json) =>
      _$TezosBlockModelFromJson(json);

  Map<String, dynamic> toJson() => _$TezosBlockModelToJson(this);
}
