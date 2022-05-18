import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nkap/data/models/tezos_block_model.dart';

class TezosBlockRepository {
  final String _baseUrl = "https://api.tzkt.io/v1/blocks";

  Future<List<TezosBlockModel>> getTezosBlock() async {
    final response = await http.get(Uri.parse(_baseUrl), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET"
    });
    if (response.statusCode == 200) {
      return [
        for (final item in jsonDecode(response.body))
          TezosBlockModel.fromJson(item),
    ];
    } else {
      throw Exception("Failed to load tezos block");
    }
  }
}
